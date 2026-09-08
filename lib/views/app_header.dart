import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';

class AppHeader extends StatelessWidget {
  final bool showAdminIcon;
  final VoidCallback? onAdminTap;
  final bool isScrolled;
  final String? currentRoute;

  const AppHeader({
    super.key,
    this.showAdminIcon = true,
    this.onAdminTap,
    this.isScrolled = false,
    this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      decoration: BoxDecoration(
        color: isScrolled ? AppColors.bgSecondary : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isScrolled ? AppColors.divider : Colors.transparent,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.toNamed('/home'),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'MA',
                      style: TextStyle(
                        color: AppColors.bg,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
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
                      fontSize: 16,
                    ),
                  ),
                ]
              ],
            ),
          ),
          if (showAdminIcon)
            GestureDetector(
              onTap: onAdminTap ?? () => Get.toNamed('/admin'),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.admin_panel_settings,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Admin',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
