import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/header_controller.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/core/constants/app_route.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  final List<Map<String, String>> navLinks = const [
    {'route': AppRoute.home, 'label': 'Home'},
    {'route': AppRoute.experience, 'label': 'Experience'},
    {'route': AppRoute.projects, 'label': 'Projects'},
    {'route': AppRoute.skills, 'label': 'Skills'},
    {'route': AppRoute.resume, 'label': 'Resume'},
    {'route': AppRoute.contact, 'label': 'Contact'},
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HeaderController>(
      init: HeaderController(),
      builder: (controller) {
        final isMobile = MediaQuery.of(context).size.width < 1024;
        final isTablet = MediaQuery.of(context).size.width < 1280;

        return Container(
          color: AppColors.bgSecondary,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : isTablet ? 24 : 40,
            vertical: 16,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  // Logo
                  GestureDetector(
                    onTap: () => controller.navigateTo(AppRoute.home),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'MA',
                              style: TextStyle(
                                color: AppColors.bg,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
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
                              fontSize: 14,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Desktop Navigation
                  if (!isMobile)
                    Row(
                      children: [
                        for (var link in navLinks)
                          Padding(
                            padding: const EdgeInsets.only(right: 32),
                            child: GestureDetector(
                              onTap: () => controller.navigateTo(link['route']!),
                              child: Text(
                                link['label']!,
                                style: TextStyle(
                                  color: Get.currentRoute == link['route']
                                      ? AppColors.primary
                                      : AppColors.muted,
                                  fontSize: 13,
                                  fontWeight: Get.currentRoute == link['route']
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  // Desktop Buttons
                  if (!isMobile) ...[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.border),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.dark_mode_outlined,
                            size: 16,
                            color: AppColors.muted,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => controller.navigateTo(AppRoute.contact),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'Hire Me',
                            style: TextStyle(
                              color: AppColors.bg,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  // Mobile Menu Button
                  if (isMobile)
                    GestureDetector(
                      onTap: () => controller.toggleMobileMenu(),
                      child: Obx(
                        () => Icon(
                          controller.isMobileMenuOpen.value
                              ? Icons.close
                              : Icons.menu,
                          size: 24,
                          color: AppColors.heading,
                        ),
                      ),
                    ),
                ],
              ),
              // Mobile Menu
              Obx(
                () => controller.isMobileMenuOpen.value
                    ? Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Column(
                          children: [
                            for (var link in navLinks) ...[
                              GestureDetector(
                                onTap: () => controller.navigateTo(link['route']!),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Row(
                                    children: [
                                      Text(
                                        link['label']!,
                                        style: TextStyle(
                                          color: Get.currentRoute == link['route']
                                              ? AppColors.primary
                                              : AppColors.title,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: AppColors.divider,
                                thickness: 1,
                              ),
                            ],
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () =>
                                  controller.navigateTo(AppRoute.contact),
                              child: Container(
                                width: double.infinity,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Hire Me',
                                    style: TextStyle(
                                      color: AppColors.bg,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        );
      },
    );
  }
}

