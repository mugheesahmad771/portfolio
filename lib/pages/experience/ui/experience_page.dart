import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/pages/experience/viewmodel/experience_viewmodel.dart';
import 'package:portfolio/pages/home/components/section_header.dart';
import 'package:portfolio/pages/home/components/tech_chip.dart';
import 'package:portfolio/views/app_header.dart';
import 'package:portfolio/views/app_navigation_bar.dart';
import 'package:portfolio/views/app_footer.dart';
import 'package:portfolio/views/responsive_layout.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExperienceViewModel>(
      init: ExperienceViewModel(),
      builder: (viewModel) {
        return Scaffold(
          backgroundColor: AppColors.bg,
          body: SingleChildScrollView(
            child: Column(
              children: [
                AppHeader(currentRoute: '/experience'),
                AppNavigationBar(currentRoute: '/experience'),
                ResponsiveContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 48),
                      SectionHeader(
                        eyebrow: 'CAREER',
                        title: 'Work Experience',
                        description:
                            'A timeline of my professional journey and the companies I\'ve worked with.',
                      ),
                      const SizedBox(height: 32),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viewModel.experiences.length,
                        itemBuilder: (context, index) {
                          final experience = viewModel.experiences[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: AppColors.card,
                                border: Border.all(color: AppColors.border),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              experience.role,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.heading,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '${experience.company} • ${experience.location}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: AppColors.muted,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            experience.duration,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: AppColors.primary,
                                              fontFamily: 'monospace',
                                            ),
                                          ),
                                          if (experience.current) ...[
                                            const SizedBox(height: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColors.green
                                                    .withValues(alpha: 0.1),
                                                border: Border.all(
                                                  color: AppColors.green,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: const Text(
                                                'Current',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.green,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: experience.technologies
                                        .map((tech) => TechChip(
                                            label: tech, isSmall: true))
                                        .toList(),
                                  ),
                                ],
                              ),
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
}
