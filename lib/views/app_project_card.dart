import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/core/models/project_model.dart';
import 'package:portfolio/views/app_badge.dart';
import 'package:portfolio/views/app_tech_chip.dart';
import 'package:portfolio/views/project_media_fallback.dart';

class _ProjectCardController extends GetxController {
  final isHovering = false.obs;

  void setHovering(bool value) {
    if (isHovering.value == value) return;
    isHovering.value = value;
    update();
  }
}

/// Project card used on Home, Projects and ProjectDetail's related section.
///
/// Hover state is held in a per-instance [GetxController] (tagged by the
/// project's id) rather than a StatefulWidget, consistent with the rest of
/// the app's GetX-only state management.
class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback? onTap;

  const ProjectCard({super.key, required this.project, this.onTap});

  @override
  Widget build(BuildContext context) {
    final resolvedOnTap =
        onTap ?? () => Get.toNamed('/projects/${project.slug}');

    return GetBuilder<_ProjectCardController>(
      init: _ProjectCardController(),
      tag: project.id,
      builder: (c) {
        final hovering = c.isHovering.value;
        return MouseRegion(
          onEnter: (_) => c.setHovering(true),
          onExit: (_) => c.setHovering(false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: resolvedOnTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              transform: Matrix4.translationValues(0, hovering ? -4 : 0, 0),
              decoration: BoxDecoration(
                color: AppColors.card,
                border: Border.all(
                  color: hovering ? AppColors.primary : AppColors.border,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: hovering
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ]
                    : const [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildMedia(project),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                project.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: hovering
                                      ? AppColors.primary
                                      : AppColors.heading,
                                ),
                              ),
                            ),
                            AnimatedSlide(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOut,
                              offset: hovering
                                  ? const Offset(0.15, -0.15)
                                  : Offset.zero,
                              child: Icon(
                                Icons.arrow_outward,
                                size: 18,
                                color: hovering
                                    ? AppColors.primary
                                    : AppColors.muted,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          project.canShowCompanyName &&
                                  (project.company?.isNotEmpty ?? false)
                              ? '${project.role} · ${project.company}'
                              : project.role,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.muted,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          project.shortDescription.isNotEmpty
                              ? project.shortDescription
                              : project.fullDescription,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.body,
                            height: 1.5,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: project.technologies
                              .take(4)
                              .map(
                                (tech) =>
                                    TechChip(label: tech, isSmall: true),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMedia(ProjectModel project) {
    final showImage =
        project.canShowScreenshots && (project.thumbnail?.isNotEmpty ?? false);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (showImage)
              Image.network(
                project.thumbnail!,
                fit: BoxFit.cover,
                semanticLabel: '${project.title} thumbnail',
                errorBuilder: (context, error, stackTrace) =>
                    ProjectMediaFallback(project: project, compact: true),
              )
            else
              ProjectMediaFallback(project: project, compact: true),
            if (project.featured || project.privateProject)
              Positioned(
                top: 12,
                left: 12,
                // AppBadge's own background is only 15%-alpha tinted —
                // fine against the app's dark page background, but
                // thumbnails vary (some have bright logo art in this exact
                // corner), so without a backdrop the badges can read as
                // nearly invisible or clash with whatever's underneath.
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.bg.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Wrap(
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
                    ],
                  ),
                ),
              ),
            if (project.videoUrl?.isNotEmpty ?? false)
              const Center(
                child: _PlayBadge(),
              ),
          ],
        ),
      ),
    );
  }
}

/// Small translucent play-button overlay shown on a project card's
/// thumbnail when the project has a demo video — the standard visual cue
/// that a video is available, without crowding the Featured/NDA badges.
class _PlayBadge extends StatelessWidget {
  const _PlayBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.bg.withValues(alpha: 0.55),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: const Icon(
        Icons.play_arrow_rounded,
        color: Colors.white,
        size: 26,
      ),
    );
  }
}
