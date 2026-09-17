import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/pages/skills/viewmodel/skills_viewmodel.dart';
import 'package:portfolio/views/app_section_header.dart';
import 'package:portfolio/views/app_tech_chip.dart';
import 'package:portfolio/views/responsive_layout.dart';
import 'package:portfolio/views/scroll_reveal.dart';
import 'package:portfolio/views/tilt_card.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SkillsViewModel>(
      init: SkillsViewModel(),
      builder: (viewModel) {
        return ResponsiveContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              const SectionHeader(
                eyebrow: 'EXPERTISE',
                title: 'Technical Skills',
                description:
                    'A comprehensive overview of my technical expertise across different domains.',
              ),
              const SizedBox(height: 32),
              LayoutBuilder(
                builder: (context, constraints) {
                  final cols = constraints.maxWidth < 700
                      ? 1
                      : (constraints.maxWidth < 1100 ? 2 : 3);
                  // A fixed-aspect-ratio GridView forced every card to the
                  // same height regardless of how many chips it held,
                  // leaving categories with fewer skills mostly empty space.
                  // A Wrap of fixed-width cards lets each one hug its own
                  // content instead.
                  const spacing = 16.0;
                  final cardWidth =
                      (constraints.maxWidth - spacing * (cols - 1)) / cols;
                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      for (
                        var index = 0;
                        index < viewModel.skillGroups.length;
                        index++
                      )
                        SizedBox(
                          width: cardWidth,
                          child: ScrollReveal(
                            id: 'skill-group-$index',
                            child: TiltCard(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: AppColors.card,
                                  border: Border.all(color: AppColors.border),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      viewModel.skillGroups[index].category,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.heading,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: viewModel
                                          .skillGroups[index]
                                          .skills
                                          .map(
                                            (s) => TechChip(
                                              label: s,
                                              isSmall: true,
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
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
}
