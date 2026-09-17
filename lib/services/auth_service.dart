import 'package:get/get.dart';
import 'package:portfolio/core/api_client/client_index.dart';
import 'package:portfolio/core/api_client/main_client.dart';
import 'package:portfolio/core/global/global_helpers.dart';

/// Real JWT-backed admin auth against the ASP.NET Core API, via the
/// shared [mainClient] and the persisted [sessionHelper] session.
class AuthService extends GetxService {
  final _isAuthenticated = false.obs;
  bool get isAuthenticated => _isAuthenticated.value;

  String? _lastError;
  String? get lastError => _lastError;

  /// Restores a previous session on app start by checking for a stored,
  /// non-expired JWT. Call this once before `runApp`.
  Future<void> restoreSession() async {
    await sessionHelper.initPreference();
    if (!sessionHelper.isLoggedIn) {
      await sessionHelper.signOut();
      _isAuthenticated.value = false;
      return;
    }
    _isAuthenticated.value = true;
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await mainClient.apiAuthLoginPost(
        body: LoginRequestModel(email: email, password: password),
      );
      final token = response.body?.token;
      if (token == null || token.isEmpty) {
        _lastError = 'Login failed. Please try again.';
        return false;
      }
      await sessionHelper.setAccessToken(token);
      final refreshToken = response.body?.refreshToken;
      if (refreshToken != null && refreshToken.isNotEmpty) {
        await sessionHelper.setRefreshToken(refreshToken);
      }
      _isAuthenticated.value = true;
      _lastError = null;
      return true;
    } on ApiException catch (e) {
      _lastError = e.message;
      return false;
    } catch (_) {
      _lastError = 'Invalid email or password.';
      return false;
    }
  }

  Future<void> logout() async {
    await sessionHelper.signOut();
    _isAuthenticated.value = false;
  }

  /// Throws [ApiException] with the backend's message on failure (e.g.
  /// wrong current password) so the caller can show it directly.
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await mainClient.apiAuthChangePasswordPost(
      body: ChangePasswordRequestModel(
        currentPassword: currentPassword,
        newPassword: newPassword,
      ),
    );
    // The backend revokes every outstanding refresh token on password
    // change, including this session's — force a fresh login rather than
    // let the next silent refresh fail unexpectedly.
    await logout();
  }
}
