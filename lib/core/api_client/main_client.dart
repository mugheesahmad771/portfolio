import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter/foundation.dart';

import '../constants/api_constant.dart';
import '../global/global_helpers.dart';
import 'api.swagger.dart';

/// Thrown for any non-2xx response or connection failure — wraps the
/// backend's `{ "success": false, "message": "...", "errors": [...] }`
/// error body (see `CustomExceptionFilterAttribute` on the backend) into
/// one display string.
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() => message;
}

/// Attaches the stored admin access token to every outgoing request and
/// converts any failed response into an [ApiException] so callers never
/// have to check `response.isSuccessful` themselves.
///
/// Runs *outside* chopper's [AuthenticatorInterceptor] in the request
/// pipeline, so by the time it inspects the response, [MyAuthenticator]
/// has already had its chance to silently refresh an expired token and
/// retry — this only sees (and reports on) the final outcome.
class AuthInterceptor implements chopper.Interceptor {
  @override
  Future<chopper.Response<BodyType>> intercept<BodyType>(
    chopper.Chain<BodyType> chain,
  ) async {
    final updatedRequest = chopper.applyHeader(
      chain.request,
      'Authorization',
      'Bearer ${sessionHelper.accessToken ?? ''}',
      override: false,
    );

    try {
      final response = await chain.proceed(updatedRequest);
      if (response.isSuccessful == false) {
        Map<String, dynamic> jsonParsed = {};
        try {
          jsonParsed = jsonDecode(response.bodyString) as Map<String, dynamic>;
        } catch (_) {
          jsonParsed = {};
        }
        if (jsonParsed.containsKey('success') && jsonParsed['success'] == false) {
          var message = jsonParsed['message'].toString();
          if (jsonParsed.containsKey('errors')) {
            final errors = jsonParsed['errors'] as List<dynamic>;
            for (final error in errors) {
              message += '\n$error';
            }
          }
          throw ApiException(message, response.statusCode);
        }
      }
      return response;
    } on ApiException {
      rethrow;
    } catch (e) {
      if (isConnectionError(e)) {
        debugPrint('[Auth] Connection error at ${updatedRequest.url}: $e');
        throw ApiException('Server is not responding', null);
      }
      throw ApiException(e.toString(), null);
    }
  }
}

/// Silently exchanges the stored refresh token for a new access+refresh
/// pair whenever a request 401s, then retries that request exactly once
/// with the new token. Falls back to signing out (which drops the admin
/// back to the login form) when there's no refresh token, the refresh
/// call itself fails, or a retried request still 401s.
class MyAuthenticator extends chopper.Authenticator {
  @override
  FutureOr<chopper.Request?> authenticate(
    chopper.Request request,
    chopper.Response response, [
    chopper.Request? originalRequest,
  ]) async {
    if (response.statusCode != 401) return null;

    // A 401 straight from login/refresh means bad credentials or an
    // already-invalid refresh token — never retry those.
    if (request.url.path.contains('/Auth/login') ||
        request.url.path.contains('/Auth/refresh')) {
      return null;
    }

    final updatedHeaders = Map<String, String>.of(request.headers);
    if (updatedHeaders.containsKey('RetryCount')) {
      // Already retried once for this request — the new token didn't
      // help either, so give up rather than loop.
      return null;
    }

    final refreshToken = sessionHelper.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) {
      await sessionHelper.signOut();
      return null;
    }

    try {
      final refreshResponse = await _refreshClient.apiAuthRefreshPost(
        body: RefreshTokenRequestModel(refreshToken: refreshToken),
      );
      final newAccessToken = refreshResponse.body?.token;
      if (!refreshResponse.isSuccessful ||
          newAccessToken == null ||
          newAccessToken.isEmpty) {
        await sessionHelper.signOut();
        return null;
      }

      await sessionHelper.setAccessToken(newAccessToken);
      final newRefreshToken = refreshResponse.body?.refreshToken;
      if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
        await sessionHelper.setRefreshToken(newRefreshToken);
      }

      updatedHeaders['Authorization'] = 'Bearer $newAccessToken';
      updatedHeaders['RetryCount'] = '1';
      return request.copyWith(headers: updatedHeaders);
    } catch (e) {
      debugPrint('[Auth] Refresh failed: $e');
      await sessionHelper.signOut();
      return null;
    }
  }
}

/// Bare client used only to redeem a refresh token — deliberately has no
/// [MyAuthenticator] of its own, so a failed refresh call can never
/// trigger another refresh attempt underneath it.
final Api _refreshClient = Api.create(
  baseUrl: Uri.parse(production ? apiProdBase : apiDebugBase),
  interceptors: [AuthInterceptor()],
);

/// The single, shared generated [Api] client used for every backend call
/// in the app — construct request/response DTOs from `client_index.dart`
/// and call methods on this instance directly (`mainClient.apiProjectsGet()`
/// etc). Every call throws [ApiException] on failure, and a 401 is
/// silently retried once via [MyAuthenticator] before that happens.
final Api mainClient = Api.create(
  baseUrl: Uri.parse(production ? apiProdBase : apiDebugBase),
  authenticator: MyAuthenticator(),
  interceptors: [AuthInterceptor()],
);