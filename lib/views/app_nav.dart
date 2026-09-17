import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/core/constants/app_route.dart';
import 'package:portfolio/core/constants/breakpoints.dart';
import 'package:portfolio/views/app_buttons.dart';

const List<Map<String, String>> _navLinks = [
  {'route': AppRoute.home, 'label': 'Home'},
  {'route': AppRoute.about, 'label': 'About'},
  {'route': AppRoute.experience, 'label': 'Experience'},
  {'route': AppRoute.projects, 'label': 'Projects'},
  {'route': AppRoute.skills, 'label': 'Skills'},
  {'route': AppRoute.resume, 'label': 'Resume'},
  {'route': AppRoute.contact, 'label': 'Contact'},
];

void _safeNavigate(String route) {
  if (Get.currentRoute == route) return;
  try {
    Get.toNamed(route);
  } catch (_) {
    // The route may not be registered yet (e.g. '/about' pending a later
    // pass) — fail silently rather than crash the app.
  }
}

/// Single fixed top nav bar, replacing the old Header/AppHeader/
/// AppNavigationBar trio (and the double-header/footer bug they caused when
/// pages rendered their own chrome on top of [AppLayout]'s). Rendered
/// inside a [Positioned] by [AppLayout] so it stays visible while page
/// content scrolls underneath it.
class AppNav extends StatelessWidget {
  final bool isScrolled;
  final bool mobileMenuOpen;
  final VoidCallback onToggleMobileMenu;

  const AppNav({
    super.key,
    required this.isScrolled,
    required this.mobileMenuOpen,
    required this.onToggleMobileMenu,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);
    final horizontalPadding = isMobile
        ? 24.0
        : (Breakpoints.isTablet(context) ? 40.0 : 64.0);
    // The full link row (logo + 7 links + CTA) genuinely doesn't fit below
    // ~1024px — showing it any earlier (e.g. at the `isMobile` threshold of
    // 600px) overflows the Row. Tablet widths get the compact/hamburger nav
    // too, not just phones.
    final showFullNav = Breakpoints.isDesktop(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 80,
      decoration: BoxDecoration(
        color: isScrolled ? AppColors.bg : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isScrolled ? AppColors.divider : Colors.transparent,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1440),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              children: [
                const _Logo(),
                const Spacer(),
                if (showFullNav) ...[
                  for (final link in _navLinks)
                    Padding(
                      padding: const EdgeInsets.only(right: 28),
                      child: _NavLink(
                        label: link['label']!,
                        route: link['route']!,
                      ),
                    ),
                  const SizedBox(width: 8),
                  AppButton(
                    label: 'Hire Me',
                    isSmall: true,
                    onPressed: () => _safeNavigate(AppRoute.contact),
                  ),
                ] else
                  IconButton(
                    onPressed: onToggleMobileMenu,
                    icon: Icon(
                      mobileMenuOpen ? Icons.close : Icons.menu,
                      color: AppColors.heading,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatefulWidget {
  const _Logo();

  @override
  State<_Logo> createState() => _LogoState();
}

class _LogoState extends State<_Logo> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () => _safeNavigate(AppRoute.home),
        child: AnimatedScale(
          scale: _hovering ? 1.04 : 1.0,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: _hovering
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : const [],
                ),
                child: const Center(
                  child: Text(
                    'MA',
                    style: TextStyle(
                      color: AppColors.bg,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              if (!isMobile) ...[
                const SizedBox(width: 12),
                const Text(
                  'Mughees Ahmad',
                  style: TextStyle(
                    color: AppColors.heading,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLinkController extends GetxController {
  final isHovering = false.obs;

  void setHovering(bool value) {
    if (isHovering.value == value) return;
    isHovering.value = value;
    update();
  }
}

/// Hover state lives in a per-instance [GetxController] (tagged by [route],
/// which is already unique per link) rather than a StatefulWidget.
class _NavLink extends StatelessWidget {
  final String label;
  final String route;
  const _NavLink({required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<_NavLinkController>(
      init: _NavLinkController(),
      tag: route,
      builder: (c) {
        final isActive = Get.currentRoute == route;
        final highlighted = isActive || c.isHovering.value;
        final color = isActive
            ? AppColors.primary
            : (c.isHovering.value ? AppColors.title : AppColors.muted);
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => c.setHovering(true),
          onExit: (_) => c.setHovering(false),
          child: GestureDetector(
            onTap: () => _safeNavigate(route),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 180),
                  style: TextStyle(
                    color: color,
                    fontSize: 13,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                  child: Text(label),
                ),
                const SizedBox(height: 5),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  height: 2,
                  width: highlighted ? 18 : 0,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Full-screen mobile nav overlay. Rendered by [AppLayout] as its own
/// sibling in the OUTER [Stack] (not nested inside [AppNav]'s own small
/// fixed-height box) so it actually covers the whole viewport.
class MobileNavOverlay extends StatelessWidget {
  final VoidCallback onNavigate;

  const MobileNavOverlay({super.key, required this.onNavigate});

  void _go(String route) {
    onNavigate();
    _safeNavigate(route);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg.withValues(alpha: 0.97),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: onNavigate,
                    icon: const Icon(Icons.close, color: AppColors.heading),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              for (final link in _navLinks) ...[
                GestureDetector(
                  onTap: () => _go(link['route']!),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      link['label']!,
                      style: TextStyle(
                        color: Get.currentRoute == link['route']
                            ? AppColors.primary
                            : AppColors.title,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1, color: AppColors.divider),
              ],
              const SizedBox(height: 24),
              AppButton(
                label: 'Hire Me',
                onPressed: () => _go(AppRoute.contact),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
