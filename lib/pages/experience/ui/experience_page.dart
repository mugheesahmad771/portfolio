import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/core/constants/breakpoints.dart';
import 'package:portfolio/core/models/experience_model.dart';
import 'package:portfolio/pages/experience/viewmodel/experience_viewmodel.dart';
import 'package:portfolio/views/app_buttons.dart';
import 'package:portfolio/views/app_section_header.dart';
import 'package:portfolio/views/app_tech_chip.dart';
import 'package:portfolio/views/pulsing_dot.dart';
import 'package:portfolio/views/responsive_layout.dart';
import 'package:portfolio/views/scroll_reveal.dart';
import 'package:portfolio/views/tilt_card.dart';
import 'package:get/get.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final showSpine = Breakpoints.isDesktop(context);

    return GetBuilder<ExperienceViewModel>(
      init: ExperienceViewModel(),
      builder: (viewModel) {
        return ResponsiveContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              const SectionHeader(
                eyebrow: 'CAREER',
                title: 'Work Experience',
                description:
                    'A timeline of my professional journey and the companies I\'ve worked with.',
              ),
              const SizedBox(height: 32),
              if (viewModel.isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 64),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ),
                )
              else if (viewModel.hasError)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: Center(
                    child: Column(
                      children: [
                        const Text(
                          'Couldn\'t load experience.',
                          style: TextStyle(color: AppColors.muted),
                        ),
                        const SizedBox(height: 16),
                        AppButton(
                          label: 'Retry',
                          onPressed: viewModel.loadExperiences,
                        ),
                      ],
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: viewModel.experiences.length,
                  itemBuilder: (context, index) {
                    final experience = viewModel.experiences[index];
                    return ScrollReveal(
                      id: 'exp-${experience.id.isEmpty ? index : experience.id}',
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: showSpine
                            ? _timelineRow(
                                experience,
                                index,
                                viewModel.experiences.length,
                              )
                            : _card(experience),
                      ),
                    );
                  },
                ),
              const SizedBox(height: 48),
            ],
          ),
        );
      },
    );
  }

  Widget _timelineRow(ExperienceModel experience, int index, int total) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: experience.current
                      ? PulsingDot(
                          tag: 'exp-current-${experience.id}',
                          size: 14,
                          color: AppColors.primary,
                        )
                      : Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                        ),
                ),
                if (index != total - 1)
                  Expanded(
                    child: Container(width: 1, color: AppColors.divider),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(child: _card(experience)),
        ],
      ),
    );
  }

  Widget _card(ExperienceModel experience) {
    return TiltCard(
      maxTilt: 0.04,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.green.withValues(alpha: 0.1),
                          border: Border.all(color: AppColors.green),
                          borderRadius: BorderRadius.circular(4),
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
            if (experience.responsibilities.isNotEmpty) ...[
              const SizedBox(height: 16),
              ...experience.responsibilities.map(
                (r) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Icon(
                          Icons.check,
                          size: 14,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          r,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.body,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: experience.technologies
                  .map((tech) => TechChip(label: tech, isSmall: true))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
