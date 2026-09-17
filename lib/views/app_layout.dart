import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/views/app_footer.dart';
import 'package:portfolio/views/app_nav.dart';

class AppLayoutController extends GetxController {
  static const double navHeight = 80;

  final ScrollController scrollController = ScrollController();
  final isScrolled = false.obs;
  final showScrollTop = false.obs;
  final mobileMenuOpen = false.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (!scrollController.hasClients) return;
    final offset = scrollController.offset;
    final scrolled = offset > 12;
    final showTop = offset > 480;
    var changed = false;
    if (scrolled != isScrolled.value) {
      isScrolled.value = scrolled;
      changed = true;
    }
    if (showTop != showScrollTop.value) {
      showScrollTop.value = showTop;
      changed = true;
    }
    if (changed) update();
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  void toggleMobileMenu() {
    mobileMenuOpen.value = !mobileMenuOpen.value;
    update();
  }

  void closeMobileMenu() {
    if (!mobileMenuOpen.value) return;
    mobileMenuOpen.value = false;
    update();
  }

  @override
  void onClose() {
    scrollController.removeListener(_handleScroll);
    scrollController.dispose();
    super.onClose();
  }
}

/// Wraps every public page with the single shared nav + footer chrome.
///
/// Previously, several pages (Resume/Contact/Skills/Experience/
/// ProjectDetail) ALSO rendered their own header/nav/footer widgets on top
/// of what this layout already provides, causing a literal double
/// header/footer on those routes. This is now the ONLY place chrome
/// renders — pages must return content only.
///
/// Scroll position and mobile-menu-open state live in [AppLayoutController]
/// (a GetxController) rather than a StatefulWidget's local state.
class AppLayout extends StatelessWidget {
  final Widget child;

  const AppLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppLayoutController>(
      init: AppLayoutController(),
      global: false,
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.bg,
          body: Stack(
            children: [
              SingleChildScrollView(
                controller: controller.scrollController,
                physics: controller.mobileMenuOpen.value
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: AppLayoutController.navHeight),
                    child,
                    const AppFooter(),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppNav(
                  isScrolled: controller.isScrolled.value,
                  mobileMenuOpen: controller.mobileMenuOpen.value,
                  onToggleMobileMenu: controller.toggleMobileMenu,
                ),
              ),
              if (controller.mobileMenuOpen.value)
                Positioned.fill(
                  child: MobileNavOverlay(
                    onNavigate: controller.closeMobileMenu,
                  ),
                ),
              Positioned(
                right: 24,
                bottom: 24,
                child: IgnorePointer(
                  ignoring: !controller.showScrollTop.value,
                  child: AnimatedOpacity(
                    opacity: controller.showScrollTop.value ? 1 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: AnimatedScale(
                      scale: controller.showScrollTop.value ? 1 : 0.7,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      child: _ScrollTopButton(
                        onPressed: controller.scrollToTop,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ScrollTopButton extends StatefulWidget {
  final VoidCallback onPressed;
  const _ScrollTopButton({required this.onPressed});

  @override
  State<_ScrollTopButton> createState() => _ScrollTopButtonState();
}

class _ScrollTopButtonState extends State<_ScrollTopButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: 48,
          height: 48,
          transform: Matrix4.translationValues(0, _hovering ? -3 : 0, 0),
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(
                  alpha: _hovering ? 0.45 : 0.25,
                ),
                blurRadius: _hovering ? 22 : 14,
                spreadRadius: 1,
              ),
            ],
          ),
          child: const Icon(
            Icons.keyboard_arrow_up,
            color: AppColors.bg,
            size: 26,
          ),
        ),
      ),
    );
  }
}
