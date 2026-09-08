import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/pages/skills/viewmodel/skills_viewmodel.dart';
import 'package:portfolio/pages/home/components/section_header.dart';
import 'package:portfolio/views/app_header.dart';
import 'package:portfolio/views/app_navigation_bar.dart';
import 'package:portfolio/views/app_footer.dart';
import 'package:portfolio/views/responsive_layout.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;

    return GetBuilder<SkillsViewModel>(
      init: SkillsViewModel(),
      builder: (viewModel) {
        return Scaffold(
          backgroundColor: AppColors.bg,
          body: SingleChildScrollView(
            child: Column(
              children: [
                AppHeader(currentRoute: '/skills'),
                AppNavigationBar(currentRoute: '/skills'),
                ResponsiveContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 48),
                      SectionHeader(
                        eyebrow: 'EXPERTISE',
                        title: 'Technical Skills',
                        description:
                            'A comprehensive overview of my technical expertise across different domains.',
                      ),
                      const SizedBox(height: 32),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viewModel.getCategories().length,
                        itemBuilder: (context, index) {
                          final category =
                              viewModel.getCategories()[index];
                          final categorySkills =
                              viewModel.getSkillsByCategory(category);

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  category,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.heading,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  itemCount: categorySkills.length,
                                  itemBuilder: (context, skillIndex) {
                                    final skill =
                                        categorySkills[skillIndex];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: _buildSkillItem(
                                          skill, isMobile),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
                AppFooter(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkillItem(Map<String, dynamic> skill, bool isMobile) {
    final level = skill['level'] as int;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill['name'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.title,
              ),
            ),
            Text(
              '$level%',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: level / 100,
            minHeight: 6,
            backgroundColor: AppColors.elevated,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ],
    );
  }
}
