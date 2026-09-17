import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/core/constants/app_image_path.dart';
import 'package:portfolio/core/constants/app_route.dart';
import 'package:portfolio/core/constants/breakpoints.dart';
import 'package:portfolio/core/utils/resume_download.dart';
import 'package:portfolio/pages/home/viewmodel/home_viewmodel.dart';
import 'package:portfolio/views/app_badge.dart';
import 'package:portfolio/views/app_buttons.dart';
import 'package:portfolio/views/app_project_card.dart';
import 'package:portfolio/views/app_section_header.dart';
import 'package:portfolio/views/app_tech_chip.dart';
import 'package:portfolio/views/count_up.dart';
import 'package:portfolio/views/empty_state.dart';
import 'package:portfolio/views/fade_slide_in.dart';
import 'package:portfolio/views/floating.dart';
import 'package:portfolio/views/gradient_orbs.dart';
import 'package:portfolio/views/marquee.dart';
import 'package:portfolio/views/scroll_reveal.dart';
import 'package:portfolio/views/tilt_card.dart';

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
              _buildHeroSection(context, viewModel),
              _buildTechStackStrip(viewModel),
              _buildStatsSection(viewModel),
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
                        const Icon(
                          Icons.wifi_off_rounded,
                          size: 40,
                          color: AppColors.disabled,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Couldn't load the latest projects & experience.",
                          style: TextStyle(color: AppColors.muted),
                        ),
                        const SizedBox(height: 16),
                        AppButton(label: 'Retry', onPressed: viewModel.retry),
                      ],
                    ),
                  ),
                )
              else ...[
                _buildFeaturedProjects(viewModel),
                _buildExperiencePreview(viewModel),
              ],
              _buildCTASection(viewModel),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeroSection(BuildContext context, HomeViewModel viewModel) {
    final isMobile = Breakpoints.isMobile(context);
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeSlideIn(
          tag: 'hero-badge',
          child: AppBadge(label: viewModel.profile.availability),
        ),
        const SizedBox(height: 28),
        FadeSlideIn(
          tag: 'hero-name',
          delay: const Duration(milliseconds: 80),
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [AppColors.heading, AppColors.primary],
            ).createShader(bounds),
            child: Text(
              viewModel.profile.name,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        FadeSlideIn(
          tag: 'hero-title',
          delay: const Duration(milliseconds: 160),
          child: Text(
            viewModel.profile.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 24),
        FadeSlideIn(
          tag: 'hero-tagline',
          delay: const Duration(milliseconds: 240),
          child: Text(
            viewModel.profile.tagline,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.muted,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 28),
        FadeSlideIn(
          tag: 'hero-chips',
          delay: const Duration(milliseconds: 320),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: viewModel.profile.specialization
                .map((spec) => TechChip(label: spec))
                .toList(),
          ),
        ),
        const SizedBox(height: 36),
        FadeSlideIn(
          tag: 'hero-cta',
          delay: const Duration(milliseconds: 400),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              AppButton(
                label: 'View Projects',
                onPressed: () => Get.toNamed(AppRoute.projects),
              ),
              AppButton(
                label: 'Download Resume',
                isPrimary: false,
                onPressed: downloadResumePdf,
              ),
              AppIconButton(
                icon: Icons.code,
                onPressed: () => launchUrl(Uri.parse(viewModel.profile.github)),
              ),
              AppIconButton(
                icon: Icons.business_center,
                onPressed: () =>
                    launchUrl(Uri.parse(viewModel.profile.linkedin)),
              ),
            ],
          ),
        ),
      ],
    );

    final portrait = FadeSlideIn(
      tag: 'hero-portrait',
      delay: const Duration(milliseconds: 300),
      child: Floating(
        tag: 'hero-portrait-float',
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            AspectRatio(
              aspectRatio: 4 / 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.18),
                      blurRadius: 40,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  AppImagePath.profile,
                  fit: BoxFit.cover,
                  semanticLabel: 'Portrait photo of Mughees Ahmad',
                ),
              ),
            ),
            Positioned(
              bottom: -20,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.green.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.verified_outlined,
                        size: 16,
                        color: AppColors.green,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Ships production-ready code',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.title,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Container(
      color: AppColors.bg,
      child: Stack(
        children: [
          const Positioned.fill(
            child: GradientOrbsBackground(tag: 'home-hero'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 64,
              vertical: isMobile ? 40 : 72,
            ),
            child: isMobile
                ? Column(
                    children: [content, const SizedBox(height: 48), portrait],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 6, child: content),
                      const SizedBox(width: 48),
                      Expanded(flex: 4, child: portrait),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechStackStrip(HomeViewModel viewModel) {
    return Container(
      width: double.infinity,
      color: AppColors.bgSecondary,
      padding: const EdgeInsets.symmetric(vertical: 24),
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
          Marquee(
            height: 20,
            pixelsPerSecond: 28,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: viewModel.coreStack
                  .map(
                    (tech) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        tech,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.body,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : 4,
              childAspectRatio: isMobile ? 1.2 : 1.4,
              // These used to be 1px, which (combined with square corners)
              // made the whole row read as a plain spreadsheet grid rather
              // than a set of distinct stat cards.
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: viewModel.stats.length,
            itemBuilder: (context, index) {
              final stat = viewModel.stats[index];
              return TiltCard(
                maxTilt: 0.08,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CountUp(
                        tag: 'stat-$index',
                        rawValue: stat.value,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.heading,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        stat.label,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: SectionHeader(
                  eyebrow: 'Selected work',
                  title: 'Featured projects',
                  description:
                      'Production apps shipped to real users — including enterprise work shown NDA-safe.',
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoute.projects),
                child: const Text(
                  'All projects',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          if (viewModel.featuredProjects.isEmpty)
            const EmptyState(
              icon: Icons.workspace_premium_outlined,
              message:
                  'Featured projects are on the way — check back soon, or '
                  'browse everything shipped so far.',
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final cols = constraints.maxWidth < 700 ? 1 : 2;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: cols,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: viewModel.featuredProjects.length,
                  itemBuilder: (context, index) {
                    final project = viewModel.featuredProjects[index];
                    return ScrollReveal(
                      id: 'featured-project-${project.id}',
                      child: ProjectCard(project: project),
                    );
                  },
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
          const SectionHeader(
            eyebrow: 'Track record',
            title: 'Where I\'ve been building',
          ),
          const SizedBox(height: 32),
          if (viewModel.experiences.isEmpty)
            const EmptyState(
              icon: Icons.work_history_outlined,
              message: 'Work history is being added — the full timeline '
                  'will show up here shortly.',
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.experiences.length,
              itemBuilder: (context, index) {
                final exp = viewModel.experiences[index];
                return ScrollReveal(
                  id: 'home-exp-${exp.id.isEmpty ? index : exp.id}',
                  child: Container(
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
                              .map(
                                (tech) => TechChip(label: tech, isSmall: true),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          const SizedBox(height: 12),
          AppButton(
            label: 'Full experience',
            isPrimary: false,
            onPressed: () => Get.toNamed(AppRoute.experience),
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection(HomeViewModel viewModel) {
    return ScrollReveal(
      id: 'home-cta',
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        decoration: BoxDecoration(
          color: AppColors.section,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(24),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            const Positioned.fill(
              child: GradientOrbsBackground(tag: 'home-cta'),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
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
                  const Text(
                    'Ready to contribute to your engineering team from day one.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
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
                      AppButton(
                        label: 'Hire Me',
                        onPressed: () => Get.toNamed(AppRoute.contact),
                      ),
                      AppButton(
                        label: 'Download Resume',
                        isPrimary: false,
                        onPressed: downloadResumePdf,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
