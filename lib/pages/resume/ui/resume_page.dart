import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/pages/resume/viewmodel/resume_viewmodel.dart';
import 'package:portfolio/pages/home/components/section_header.dart';
import 'package:portfolio/views/app_header.dart';
import 'package:portfolio/views/app_navigation_bar.dart';
import 'package:portfolio/views/app_footer.dart';
import 'package:portfolio/views/app_buttons.dart';
import 'package:portfolio/views/responsive_layout.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResumeViewModel>(
      init: ResumeViewModel(),
      builder: (viewModel) {
        return Scaffold(
          backgroundColor: AppColors.bg,
          body: SingleChildScrollView(
            child: Column(
              children: [
                AppHeader(currentRoute: '/resume'),
                AppNavigationBar(currentRoute: '/resume'),
                ResponsiveContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 48),
                      SectionHeader(
                        eyebrow: 'RESUME',
                        title: 'Download My Resume',
                        description:
                            'Get a comprehensive overview of my professional background, skills, and experience.',
                      ),
                      const SizedBox(height: 32),
                      Container(
                        width: double.infinity,
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
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.primary.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.description,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Mughees Ahmad - Resume',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.heading,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'PDF Document • 500 KB',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.muted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            AppButton(
                              label: 'Download Resume (PDF)',
                              onPressed: viewModel.downloadResume,
                              icon: const Icon(Icons.download,
                                  color: AppColors.bg, size: 18),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      SectionHeader(
                        eyebrow: 'QUICK INFO',
                        title: 'Contact Details',
                      ),
                      const SizedBox(height: 20),
                      _buildContactInfo('Email', viewModel.resumeData['contact']
                          ['email']),
                      const SizedBox(height: 12),
                      _buildContactInfo('Phone', viewModel.resumeData['contact']
                          ['phone']),
                      const SizedBox(height: 12),
                      _buildContactInfo('Location', viewModel.resumeData['contact']
                          ['location']),
                      const SizedBox(height: 12),
                      _buildContactInfo('Website', viewModel.resumeData['contact']
                          ['website']),
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

  Widget _buildContactInfo(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.muted,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.title,
            ),
          ),
        ),
      ],
    );
  }
}
