import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/core/models/project_model.dart';

/// Shared placeholder for a project's cover media when no screenshot is
/// available — shown on both [ProjectCard] and the project detail page
/// instead of each rolling its own near-identical empty box. Falls back to
/// showing [ProjectModel.statistics] (if any) so the space still carries
/// information instead of sitting empty.
class ProjectMediaFallback extends StatelessWidget {
  final ProjectModel project;

  /// Tighter padding/type scale for the smaller card context; the detail
  /// page uses the roomier default.
  final bool compact;

  const ProjectMediaFallback({
    super.key,
    required this.project,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final stats = project.statistics.take(3).toList();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.section, AppColors.bgSecondary],
        ),
      ),
      padding: EdgeInsets.all(compact ? 16 : 24),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            project.privateProject
                ? Icons.lock_outline
                : Icons.image_not_supported_outlined,
            size: compact ? 28 : 32,
            color: AppColors.disabled,
          ),
          const SizedBox(height: 8),
          Text(
            project.privateProject
                ? 'Screenshots kept private for this engagement'
                : 'Preview coming soon',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: compact ? 11 : 12,
              color: AppColors.disabled,
            ),
          ),
          if (stats.isNotEmpty) ...[
            SizedBox(height: compact ? 16 : 24),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: compact ? 24 : 32,
              runSpacing: compact ? 12 : 16,
              children: stats
                  .map(
                    (s) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          s.value,
                          style: TextStyle(
                            fontSize: compact ? 20 : 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.heading,
                          ),
                        ),
                        Text(
                          s.label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: compact ? 11 : 12,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
