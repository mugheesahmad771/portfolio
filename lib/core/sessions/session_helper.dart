import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Single source of truth for the admin JWT — persisted across page
/// reloads via [SharedPreferences] and read by [main_client.dart]'s auth
/// interceptor on every request.
class SessionHelper with ChangeNotifier {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  String? accessToken;
  String? refreshToken;
  SharedPreferences? preferences;

  Future<void> initPreference() async {
    if (preferences == null) {
      preferences ??= await SharedPreferences.getInstance();
      accessToken = preferences?.getString(_accessTokenKey);
      refreshToken = preferences?.getString(_refreshTokenKey);
    }
  }

  Future<void> setAccessToken(String accessToken) async {
    this.accessToken = accessToken;
    await initPreference();
    await preferences?.setString(_accessTokenKey, accessToken);
    notifyListeners();
  }

  Future<void> setRefreshToken(String refreshToken) async {
    this.refreshToken = refreshToken;
    await initPreference();
    await preferences?.setString(_refreshTokenKey, refreshToken);
    notifyListeners();
  }

  /// True when the access token is still valid, OR it's expired but a
  /// refresh token is available to silently renew it — see
  /// `MyAuthenticator` in `main_client.dart`, which does that renewal the
  /// moment a request actually 401s.
  bool get isLoggedIn {
    final current = accessToken;
    if (current != null && current.isNotEmpty && !_isExpired(current)) {
      return true;
    }
    return (refreshToken ?? '').isNotEmpty;
  }

  bool _isExpired(String jwt) {
    try {
      final parts = jwt.split('.');
      if (parts.length != 3) return true;
      var payload = parts[1].replaceAll('-', '+').replaceAll('_', '/');
      switch (payload.length % 4) {
        case 2:
          payload += '==';
          break;
        case 3:
          payload += '=';
          break;
      }
      final decoded = utf8.decode(base64.decode(payload));
      final Map<String, dynamic> map = json.decode(decoded);
      final exp = map['exp'];
      if (exp is! int) return false;
      final expiry = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return DateTime.now().isAfter(expiry);
    } catch (_) {
      return true;
    }
  }

  Future<bool> signOut() async {
    accessToken = null;
    refreshToken = null;
    await initPreference();
    await preferences?.clear();
    notifyListeners();
    return false;
  }
}