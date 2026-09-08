import 'package:get/get.dart';

class AuthService extends GetxService {
  final String _adminPasscode = 'admin123';
  final _isAuthenticated = false.obs;

  bool get isAuthenticated => _isAuthenticated.value;

  Future<bool> authenticate(String passcode) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (passcode.trim() == _adminPasscode) {
      _isAuthenticated.value = true;
      return true;
    }
    return false;
  }

  void logout() {
    _isAuthenticated.value = false;
  }
}
