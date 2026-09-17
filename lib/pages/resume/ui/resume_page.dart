import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/core/constants/app_text_styles.dart';
import 'package:portfolio/pages/resume/viewmodel/resume_viewmodel.dart';
import 'package:portfolio/views/app_buttons.dart';
import 'package:portfolio/views/app_section_header.dart';
import 'package:portfolio/views/responsive_layout.dart';
import 'package:portfolio/views/scroll_reveal.dart';
import 'package:portfolio/views/tilt_card.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResumeViewModel>(
      init: ResumeViewModel(),
      builder: (viewModel) {
        final contact = viewModel.resumeData['contact'] as Map<String, dynamic>;
        return ResponsiveContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              const SectionHeader(
                eyebrow: 'RESUME',
                title: 'Download My Resume',
                description:
                    'Get a comprehensive overview of my professional background, skills, and experience.',
              ),
              const SizedBox(height: 32),
              ScrollReveal(
                id: 'resume-download',
                child: _buildDownloadCard(viewModel),
              ),
              const SizedBox(height: 32),
              ScrollReveal(
                id: 'resume-summary',
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.section, AppColors.card],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SUMMARY',
                        style: AppTextStyles.mono(
                          fontSize: 11,
                          color: AppColors.primary,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        viewModel.resumeData['summary'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.body,
                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'EXPERIENCE',
                        style: AppTextStyles.mono(
                          fontSize: 11,
                          color: AppColors.primary,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (viewModel.isLoading)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primary,
                            ),
                          ),
                        )
                      else
                        ...viewModel.experiences.map(
                          (exp) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${exp.role} · ${exp.company}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.heading,
                                  ),
                                ),
                                Text(
                                  exp.duration,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.muted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 12),
                      Text(
                        'SKILLS',
                        style: AppTextStyles.mono(
                          fontSize: 11,
                          color: AppColors.primary,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...viewModel.skillGroups.map(
                        (group) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${group.category}: ',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.title,
                                  ),
                                ),
                                TextSpan(
                                  text: group.skills.join(', '),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.body,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const SectionHeader(
                eyebrow: 'QUICK INFO',
                title: 'Contact Details',
              ),
              const SizedBox(height: 20),
              _buildContactInfo('Email', contact['email']),
              const SizedBox(height: 12),
              _buildContactInfo('Phone', contact['phone']),
              const SizedBox(height: 12),
              _buildContactInfo('Location', contact['location']),
              const SizedBox(height: 12),
              _buildContactInfo('GitHub', contact['website']),
              const SizedBox(height: 48),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDownloadCard(ResumeViewModel viewModel) {
    return TiltCard(
      maxTilt: 0.05,
      child: Container(
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
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.description,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mughees Ahmad - Resume',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.heading,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'PDF Document',
                        style: TextStyle(fontSize: 12, color: AppColors.muted),
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
              icon: const Icon(Icons.download, color: AppColors.bg, size: 18),
            ),
          ],
        ),
      ),
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
            style: const TextStyle(fontSize: 13, color: AppColors.title),
          ),
        ),
      ],
    );
  }
}
