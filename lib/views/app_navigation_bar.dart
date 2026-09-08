import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';

class AppNavigationBar extends StatelessWidget {
  final String currentRoute;

  const AppNavigationBar({
    super.key,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    if (isMobile) {
      return _buildMobileNav();
    }

    return _buildDesktopNav();
  }

  Widget _buildMobileNav() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        border: Border(
          top: BorderSide(color: AppColors.divider),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            _buildNavItem('Home', '/home'),
            _buildNavItem('Projects', '/projects'),
            _buildNavItem('Experience', '/experience'),
            _buildNavItem('Skills', '/skills'),
            _buildNavItem('Contact', '/contact'),
            _buildNavItem('Resume', '/resume'),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopNav() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        border: Border(
          bottom: BorderSide(color: AppColors.divider),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavItem('Home', '/home'),
          const SizedBox(width: 32),
          _buildNavItem('Projects', '/projects'),
          const SizedBox(width: 32),
          _buildNavItem('Experience', '/experience'),
          const SizedBox(width: 32),
          _buildNavItem('Skills', '/skills'),
          const SizedBox(width: 32),
          _buildNavItem('Contact', '/contact'),
          const SizedBox(width: 32),
          _buildNavItem('Resume', '/resume'),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, String route) {
    final isActive = currentRoute == route;
    return GestureDetector(
      onTap: () => Get.toNamed(route),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isActive ? AppColors.primary : AppColors.muted,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              fontSize: 14,
            ),
          ),
          if (isActive) ...[
            const SizedBox(height: 8),
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
