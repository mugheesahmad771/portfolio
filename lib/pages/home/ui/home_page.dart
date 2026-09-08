
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/pages/home/components/badge.dart';
import 'package:portfolio/pages/home/components/project_card.dart';
import 'package:portfolio/pages/home/components/section_header.dart';
import 'package:portfolio/pages/home/components/tech_chip.dart';
import 'package:portfolio/pages/home/viewmodel/home_viewmodel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (viewModel) {
        return Container(
          color: AppColors.bg,
          child: Column(
            children: [
              // Hero Section
              _buildHeroSection(viewModel),

              // Tech Stack Strip
              _buildTechStackStrip(viewModel),

              // Stats Section
              _buildStatsSection(viewModel),

              // Featured Projects
              _buildFeaturedProjects(viewModel),

              // Experience Preview
              _buildExperiencePreview(viewModel),

              // Final CTA
              _buildCTASection(viewModel),

              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeroSection(HomeViewModel viewModel) {
    return Container(
      color: AppColors.bg,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          AppBadge(label: viewModel.profile.availability),
          const SizedBox(height: 28),
          Text(
            viewModel.profile.name,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: AppColors.heading,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            viewModel.profile.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            viewModel.profile.tagline,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.muted,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: viewModel.profile.specialization
                .map((spec) => TechChip(label: spec))
                .toList(),
          ),
          const SizedBox(height: 36),
          // Action buttons
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildButton('View Projects', AppColors.primary, true),
              _buildButton('Download Resume', AppColors.primary, false),
              _buildIconButton(),
              _buildIconButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, Color color, bool isPrimary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isPrimary ? color : Colors.transparent,
        border: Border.all(
          color: isPrimary ? Colors.transparent : AppColors.border,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isPrimary ? AppColors.bg : AppColors.title,
        ),
      ),
    );
  }

  Widget _buildIconButton() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(
        Icons.location_on,
        size: 20,
        color: AppColors.muted,
      ),
    );
  }

  Widget _buildTechStackStrip(HomeViewModel viewModel) {
    return Container(
      width: double.infinity,
      color: AppColors.bgSecondary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          const Text(
            'CORE STACK',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.disabled,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 24,
            runSpacing: 12,
            children: viewModel.coreStack
                .map(
                  (tech) => Text(
                    tech,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.body,
                      fontFamily: 'monospace',
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemCount: viewModel.stats.length,
        itemBuilder: (context, index) {
          final stat = viewModel.stats[index];
          return Container(
            decoration: BoxDecoration(
              color: AppColors.card,
              border: Border.all(color: AppColors.divider),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat.value,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: AppColors.heading,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  stat.label,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedProjects(HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            eyebrow: 'Selected work',
            title: 'Featured projects',
            description:
                'Production apps shipped to real users — including enterprise work shown NDA-safe.',
          ),
          const SizedBox(height: 32),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: viewModel.featuredProjects.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ProjectCard(project: viewModel.featuredProjects[index]),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExperiencePreview(HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            eyebrow: 'Track record',
            title: 'Where I\'ve been building',
          ),
          const SizedBox(height: 32),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: viewModel.experiences.length,
            itemBuilder: (context, index) {
              final exp = viewModel.experiences[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
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
                        Text(
                          exp.duration,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                            fontFamily: 'monospace',
                          ),
                        ),
                        if (exp.current)
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
                    ),
                    const SizedBox(height: 12),
                    Text(
                      exp.role,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.heading,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${exp.company} · ${exp.location}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.muted,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: exp.technologies
                          .take(3)
                          .map((tech) => TechChip(label: tech, isSmall: true))
                          .toList(),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection(HomeViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.section,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Text(
            'OPEN TO OPPORTUNITIES',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Ready to contribute to your engineering team from day one.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: AppColors.heading,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            viewModel.profile.relocation,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.muted,
            ),
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _buildButton('Hire Me', AppColors.primary, true),
              _buildButton('Download Resume', AppColors.primary, false),
            ],
          ),
        ],
      ),
    );
  }
}
