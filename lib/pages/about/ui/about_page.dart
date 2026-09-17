import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/core/constants/app_image_path.dart';
import 'package:portfolio/core/constants/breakpoints.dart';
import 'package:portfolio/pages/about/viewmodel/about_viewmodel.dart';
import 'package:portfolio/views/app_section_header.dart';
import 'package:portfolio/views/responsive_layout.dart';
import 'package:portfolio/views/scroll_reveal.dart';
import 'package:portfolio/views/tilt_card.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Breakpoints.isDesktop(context);

    return GetBuilder<AboutViewModel>(
      init: AboutViewModel(),
      builder: (viewModel) {
        return ResponsiveContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              isDesktop
                  ? IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 6, child: _buildSummary()),
                          const SizedBox(width: 40),
                          Expanded(flex: 4, child: _buildQuickFacts()),
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSummary(),
                        const SizedBox(height: 32),
                        _buildQuickFacts(),
                      ],
                    ),
              const SizedBox(height: 56),
              const SectionHeader(eyebrow: 'HIGHLIGHTS', title: 'How I work'),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  final cols = constraints.maxWidth < Breakpoints.mobile
                      ? 1
                      : (constraints.maxWidth < Breakpoints.desktop ? 2 : 4);
                  // A fixed-aspect-ratio GridView forced every card to the
                  // same tall height regardless of how much text it held,
                  // leaving most cards mostly empty space below their text.
                  // A Wrap of fixed-width cards lets each hug its content.
                  const spacing = 16.0;
                  final cardWidth =
                      (constraints.maxWidth - spacing * (cols - 1)) / cols;
                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      for (
                        var index = 0;
                        index < viewModel.highlights.length;
                        index++
                      )
                        SizedBox(
                          width: cardWidth,
                          child: ScrollReveal(
                            id: 'about-highlight-$index',
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
                                      viewModel.highlights[index].title,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.heading,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      viewModel.highlights[index].detail,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.muted,
                                        height: 1.5,
                                      ),
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
              const SizedBox(height: 56),
              const SectionHeader(eyebrow: 'BACKGROUND', title: 'Education'),
              const SizedBox(height: 20),
              ScrollReveal(
                id: 'about-education',
                child: TiltCard(
                  maxTilt: 0.05,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.purple.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.school_outlined,
                            color: AppColors.purple,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ADS / ADP in Computer Science',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.heading,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Pakistan — 14 Years of Education',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.muted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummary() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(eyebrow: 'ABOUT', title: 'A bit about me'),
        SizedBox(height: 20),
        Text(
          'I\'m a Flutter developer with 3+ years of professional experience building high-quality, cross-platform mobile applications for iOS and Android. I work across the whole stack — from Flutter and React Native clients to C# ASP.NET Web APIs and Angular admin dashboards — and I take features from a UI sketch to a released, production app.',
          style: TextStyle(fontSize: 15, color: AppColors.body, height: 1.7),
        ),
        SizedBox(height: 16),
        Text(
          'Alongside mobile and full-stack work, I\'ve been hands-on with AI-powered features, machine learning integrations and intelligent automation — always with an eye on clean, maintainable code and a smooth user experience.',
          style: TextStyle(fontSize: 15, color: AppColors.body, height: 1.7),
        ),
      ],
    );
  }

  Widget _buildQuickFacts() {
    return TiltCard(
      maxTilt: 0.05,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.card,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                  AppImagePath.profile,
                  fit: BoxFit.cover,
                  semanticLabel: 'Portrait photo of Mughees Ahmad',
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'QUICK FACTS',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.disabled,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 16),
            _fact('Location', 'Multan, Pakistan'),
            _fact('Experience', '3+ Years'),
            _fact('Current', 'HBit Technology LLC'),
            _fact('Languages', 'Urdu (Native), English (Professional)'),
          ],
        ),
      ),
    );
  }

  Widget _fact(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: AppColors.muted),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
