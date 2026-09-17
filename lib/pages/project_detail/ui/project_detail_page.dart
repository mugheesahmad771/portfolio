import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/core/constants/app_route.dart';
import 'package:portfolio/core/constants/app_text_styles.dart';
import 'package:portfolio/core/constants/breakpoints.dart';
import 'package:portfolio/core/models/project_model.dart';
import 'package:portfolio/pages/project_detail/viewmodel/project_detail_viewmodel.dart';
import 'package:portfolio/views/app_badge.dart';
import 'package:portfolio/views/app_project_card.dart';
import 'package:portfolio/views/app_section_header.dart';
import 'package:portfolio/views/app_tech_chip.dart';
import 'package:portfolio/views/project_media_fallback.dart';
import 'package:portfolio/views/responsive_layout.dart';
import 'package:portfolio/views/scroll_reveal.dart';
import 'package:portfolio/views/tilt_card.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectDetailViewModel>(
      init: ProjectDetailViewModel(),
      builder: (viewModel) {
        if (viewModel.isLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 120),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          );
        }
        if (viewModel.isNotFound || viewModel.project == null) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 120),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'Project not found',
                    style: TextStyle(fontSize: 20, color: AppColors.heading),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoute.projects),
                    child: const Text(
                      'Back to projects',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final project = viewModel.project!;
        final isDesktop = Breakpoints.isDesktop(context);

        return ResponsiveContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoute.projects),
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back, color: AppColors.primary, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'All projects',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 8,
                children: [
                  if (project.featured)
                    const AppBadge(
                      label: 'Featured',
                      showDot: false,
                      backgroundColor: AppColors.orange,
                    ),
                  if (project.privateProject)
                    const AppBadge(
                      label: 'NDA',
                      showDot: false,
                      backgroundColor: AppColors.purple,
                    ),
                  if (project.currentlyWorking)
                    const AppBadge(
                      label: 'Ongoing',
                      backgroundColor: AppColors.green,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                project.title,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: AppColors.heading,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                project.shortDescription.isNotEmpty
                    ? project.shortDescription
                    : project.fullDescription,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.muted,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 24),
              _buildMetaRow(project),
              const SizedBox(height: 16),
              _buildLinksRow(project),
              const SizedBox(height: 32),
              ScrollReveal(
                id: 'project-cover-${project.id}',
                child: _buildCoverOrMetrics(project),
              ),
              const SizedBox(height: 40),
              isDesktop
                  ? IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 16, child: _buildMainColumn(project)),
                          const SizedBox(width: 40),
                          Expanded(flex: 10, child: _buildSidebar(project)),
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMainColumn(project),
                        const SizedBox(height: 32),
                        _buildSidebar(project),
                      ],
                    ),
              const SizedBox(height: 48),
              if (viewModel.relatedProjects.isNotEmpty) ...[
                const SectionHeader(
                  eyebrow: 'More work',
                  title: 'Related projects',
                ),
                const SizedBox(height: 24),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final cols = constraints.maxWidth < 700
                        ? 1
                        : (constraints.maxWidth < 1100 ? 2 : 3);
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: cols,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: viewModel.relatedProjects.length,
                      itemBuilder: (context, index) => ProjectCard(
                        project: viewModel.relatedProjects[index],
                      ),
                    );
                  },
                ),
              ],
              const SizedBox(height: 48),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMetaRow(ProjectModel project) {
    // Role/Company are always meaningful, but Duration/Timeline depend on
    // data that isn't always known (e.g. an undated project) — dropping
    // them when blank avoids two redundant "—" fields sitting side by side.
    final items = <MapEntry<String, String>>[
      MapEntry('Role', project.role),
      MapEntry(
        'Company',
        project.canShowCompanyName
            ? (project.company ?? '—')
            : 'Confidential client',
      ),
      if (project.duration.isNotEmpty) MapEntry('Duration', project.duration),
      if (_timeline(project) != '—') MapEntry('Timeline', _timeline(project)),
    ];
    return Wrap(
      spacing: 40,
      runSpacing: 16,
      children: items
          .map(
            (e) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  e.key.toUpperCase(),
                  style: AppTextStyles.mono(
                    fontSize: 11,
                    color: AppColors.disabled,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  e.value,
                  style: const TextStyle(fontSize: 14, color: AppColors.title),
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  String _timeline(ProjectModel project) {
    final start = project.startDate?.year.toString() ?? '';
    if (project.currentlyWorking) {
      return start.isEmpty ? 'Ongoing' : '$start — Present';
    }
    final end = project.endDate?.year.toString() ?? '';
    if (start.isEmpty && end.isEmpty) return '—';
    return '$start${end.isNotEmpty ? ' — $end' : ''}';
  }

  Widget _buildLinksRow(ProjectModel project) {
    final links = <Widget>[];
    void addLink(String? url, String label, IconData icon) {
      if (url != null && url.isNotEmpty) {
        links.add(
          _LinkChip(
            label: label,
            icon: icon,
            onTap: () => launchUrl(Uri.parse(url)),
          ),
        );
      }
    }

    addLink(project.githubLink, 'Source', Icons.code);
    addLink(project.liveLink, 'Live', Icons.public);
    addLink(project.playStoreUrl, 'Google Play', Icons.shop);
    addLink(project.appStoreUrl, 'App Store', Icons.apple);
    addLink(project.videoUrl, 'Watch Demo', Icons.play_circle_outline);

    if (links.isEmpty) return const SizedBox.shrink();
    return Wrap(spacing: 12, runSpacing: 12, children: links);
  }

  Widget _buildCoverOrMetrics(ProjectModel project) {
    final showCover =
        project.canShowScreenshots && (project.coverImage?.isNotEmpty ?? false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: showCover
            ? Image.network(
                project.coverImage!,
                fit: BoxFit.cover,
                semanticLabel: '${project.title} cover image',
                errorBuilder: (context, error, stackTrace) =>
                    ProjectMediaFallback(project: project),
              )
            : ProjectMediaFallback(project: project),
      ),
    );
  }

  Widget _buildMainColumn(ProjectModel project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (project.fullDescription.isNotEmpty)
          _buildBlock('Overview', project.fullDescription),
        if (project.problemStatement.isNotEmpty) ...[
          const SizedBox(height: 32),
          _buildBlock('The problem', project.problemStatement),
        ],
        if (project.solution.isNotEmpty) ...[
          const SizedBox(height: 32),
          _buildBlock('The solution', project.solution),
        ],
        if (project.responsibilities.isNotEmpty) ...[
          const SizedBox(height: 32),
          Text(
            'RESPONSIBILITIES',
            style: AppTextStyles.mono(
              fontSize: 12,
              color: AppColors.primary,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 16),
          ...project.responsibilities.map(
            (r) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Icon(
                      Icons.check,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      r,
                      style: const TextStyle(
                        fontSize: 14,
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
        if (project.canShowScreenshots && project.apps.isNotEmpty) ...[
          const SizedBox(height: 32),
          Text(
            "WHAT'S INCLUDED",
            style: AppTextStyles.mono(
              fontSize: 12,
              color: AppColors.primary,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 16),
          ..._buildAppSections(project),
        ] else if (project.canShowScreenshots &&
            project.screenshots.isNotEmpty) ...[
          const SizedBox(height: 32),
          Text(
            'SCREENSHOTS',
            style: AppTextStyles.mono(
              fontSize: 12,
              color: AppColors.primary,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 16),
          _buildScreenshotGrid(project.screenshots, project.title),
        ],
      ],
    );
  }

  /// One project can ship several distinct apps (e.g. a customer app, a
  /// driver app and an admin dashboard). Each [ProjectApp] gets its own
  /// platform-tagged card so a visitor can tell what's actually included —
  /// a plain flat screenshot grid can't express that.
  List<Widget> _buildAppSections(ProjectModel project) {
    return project.apps
        .map(
          (app) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _platformIcon(app.platform),
                      size: 18,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      app.platform.isNotEmpty
                          ? '${app.label} · ${app.platform}'
                          : app.label,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.heading,
                      ),
                    ),
                  ],
                ),
                if (app.screenshots.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 220,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: app.screenshots.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 12),
                      itemBuilder: (context, i) => ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          app.screenshots[i],
                          fit: BoxFit.cover,
                          semanticLabel:
                              '${app.label} ${app.platform} screenshot ${i + 1}',
                          errorBuilder: (c, e, s) => const SizedBox.shrink(),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        )
        .toList();
  }

  Widget _buildScreenshotGrid(List<String> screenshots, String title) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth < 500 ? 1 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 4 / 3,
          ),
          itemCount: screenshots.length,
          itemBuilder: (context, i) => ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              screenshots[i],
              fit: BoxFit.cover,
              semanticLabel: '$title screenshot ${i + 1}',
            ),
          ),
        );
      },
    );
  }

  Widget _buildBlock(String title, String body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: AppTextStyles.mono(
            fontSize: 12,
            color: AppColors.primary,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          body,
          style: const TextStyle(
            fontSize: 15,
            color: AppColors.body,
            height: 1.7,
          ),
        ),
      ],
    );
  }

  Widget _buildSidebar(ProjectModel project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sidebarCard(
          'Technology',
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: project.technologies
                .map((t) => TechChip(label: t, isSmall: true))
                .toList(),
          ),
        ),
        const SizedBox(height: 20),
        _sidebarCard(
          'Platforms',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: project.platforms
                .map(
                  (p) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          _platformIcon(p),
                          size: 18,
                          color: AppColors.muted,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          p,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.title,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        if (project.keyFeatures.isNotEmpty) ...[
          const SizedBox(height: 20),
          _sidebarCard(
            'Key Features',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: project.keyFeatures
                  .map(
                    (f) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: SizedBox(
                              width: 6,
                              height: 6,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              f,
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
                  )
                  .toList(),
            ),
          ),
        ],
      ],
    );
  }

  Widget _sidebarCard(String title, Widget child) {
    return TiltCard(
      maxTilt: 0.04,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.card,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.heading,
              ),
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }

  IconData _platformIcon(String platform) {
    switch (platform) {
      case 'Android':
        return Icons.android;
      case 'iOS':
        return Icons.apple;
      case 'Web':
        return Icons.public;
      default:
        return Icons.devices_other;
    }
  }
}

class _LinkChip extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _LinkChip({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_LinkChip> createState() => _LinkChipState();
}

class _LinkChipState extends State<_LinkChip> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovering ? -2 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _hovering
                ? AppColors.primary.withValues(alpha: 0.08)
                : Colors.transparent,
            border: Border.all(
              color: _hovering ? AppColors.primary : AppColors.border,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: _hovering ? AppColors.primary : AppColors.title,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 13,
                  color: _hovering ? AppColors.primary : AppColors.title,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
