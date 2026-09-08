import 'package:get/get.dart';

class HeaderController extends GetxController {
  final RxBool isMobileMenuOpen = false.obs;

  void toggleMobileMenu() {
    isMobileMenuOpen.toggle();
  }

  void closeMobileMenu() {
    isMobileMenuOpen.value = false;
  }

  void navigateTo(String route) {
    Get.toNamed(route);
    closeMobileMenu();
  }
}
