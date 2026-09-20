import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/core/models/project_model.dart';
import 'package:portfolio/views/fade_slide_in.dart';
import 'package:portfolio/views/screenshot_thumb.dart';
import 'package:portfolio/views/video_preview_card.dart';

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

/// Segmented tab switcher for a project that ships several distinct
/// apps/platforms (e.g. a customer app, a driver app, an admin web
/// dashboard) — lets a visitor pick which one's screenshots to browse
/// instead of scrolling past every app's gallery stacked vertically, which
/// stops scaling once a project ships more than two or three of them.
class AppScreenshotTabs extends StatefulWidget {
  final List<ProjectApp> apps;
  final String projectTitle;

  const AppScreenshotTabs({
    super.key,
    required this.apps,
    required this.projectTitle,
  });

  @override
  State<AppScreenshotTabs> createState() => _AppScreenshotTabsState();
}

bool _hasContent(ProjectApp app) =>
    app.screenshots.isNotEmpty || (app.videoUrl?.isNotEmpty ?? false);

class _AppScreenshotTabsState extends State<AppScreenshotTabs> {
  // Lands the visitor on the first app that actually has a screenshot or a
  // video rather than defaulting to index 0 and possibly opening on an
  // empty tab while a populated one sits unnoticed further along.
  late int _selected = () {
    final withContent = widget.apps.indexWhere(_hasContent);
    return withContent == -1 ? 0 : withContent;
  }();

  @override
  Widget build(BuildContext context) {
    final apps = widget.apps;
    final selectedApp = apps[_selected];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (apps.length > 1)
          // Wrap (not a horizontal-scrolling row) so a project with many
          // apps flows onto extra lines on narrow screens instead of
          // hiding tabs behind a swipe a visitor might not discover.
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(apps.length, (i) {
              final app = apps[i];
              return _AppTabChip(
                label: app.platform.isNotEmpty
                    ? '${app.label} · ${app.platform}'
                    : app.label,
                icon: _platformIcon(app.platform),
                count: app.screenshots.length,
                hasVideo: app.videoUrl?.isNotEmpty ?? false,
                selected: i == _selected,
                onTap: () => setState(() => _selected = i),
              );
            }),
          )
        else
          // A single app isn't worth a clickable tab — just label what
          // the gallery below belongs to, same as before this widget
          // existed.
          Row(
            children: [
              Icon(
                _platformIcon(selectedApp.platform),
                size: 18,
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                selectedApp.platform.isNotEmpty
                    ? '${selectedApp.label} · ${selectedApp.platform}'
                    : selectedApp.label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.heading,
                ),
              ),
            ],
          ),
        const SizedBox(height: 20),
        KeyedSubtree(
          key: ValueKey('${selectedApp.label}-${selectedApp.platform}'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (selectedApp.videoUrl?.isNotEmpty ?? false) ...[
                VideoPreviewCard(videoUrl: selectedApp.videoUrl!),
                const SizedBox(height: 20),
              ],
              _buildGallery(context, selectedApp),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGallery(BuildContext context, ProjectApp app) {
    if (app.screenshots.isEmpty) {
      // A video-only app doesn't need an apologetic empty box beneath its
      // player — only show the "nothing here" state when there's truly
      // nothing (no screenshots and no video) to look at.
      if (app.videoUrl?.isNotEmpty ?? false) return const SizedBox.shrink();
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.card,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.image_not_supported_outlined,
              color: AppColors.disabled,
              size: 26,
            ),
            const SizedBox(height: 10),
            Text(
              'No screenshots yet for ${app.label}',
              style: const TextStyle(color: AppColors.disabled, fontSize: 13),
            ),
          ],
        ),
      );
    }

    // A phone app's screenshots are portrait captures — a landscape-ish
    // tile crops most of the screen away under BoxFit.contain's
    // letterboxing. A tile shaped closer to a real phone screen keeps that
    // letterboxing small instead.
    final isMobile = app.platform == 'iOS' || app.platform == 'Android';
    final tileAspectRatio = isMobile ? 9 / 16 : 4 / 3;

    // Wrap + fixed-size tiles (not GridView) purely so every tile keeps a
    // consistent aspect ratio regardless of how many end up in the last
    // row.
    return LayoutBuilder(
      builder: (context, constraints) {
        final columnWidth = constraints.maxWidth;
        final cols = columnWidth < 560 ? 1 : (columnWidth < 900 ? 2 : 3);
        const spacing = 14.0;
        final tileWidth = (columnWidth - spacing * (cols - 1)) / cols;
        final tileHeight = tileWidth / tileAspectRatio;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(app.screenshots.length, (i) {
            return SizedBox(
              width: tileWidth,
              height: tileHeight,
              child: FadeSlideIn(
                tag:
                    'app-tab-screenshot-${widget.projectTitle}-${app.label}-${app.platform}-$i',
                delay: Duration(milliseconds: 30 * (i % 12)),
                child: ScreenshotThumb(
                  url: app.screenshots[i],
                  semanticLabel:
                      '${app.label} ${app.platform} screenshot ${i + 1}',
                  gallery: app.screenshots,
                  index: i,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class _AppTabChip extends StatefulWidget {
  final String label;
  final IconData icon;
  final int count;
  final bool hasVideo;
  final bool selected;
  final VoidCallback onTap;

  const _AppTabChip({
    required this.label,
    required this.icon,
    required this.count,
    required this.hasVideo,
    required this.selected,
    required this.onTap,
  });

  @override
  State<_AppTabChip> createState() => _AppTabChipState();
}

class _AppTabChipState extends State<_AppTabChip> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.selected;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: active
                ? AppColors.primary.withValues(alpha: 0.12)
                : (_hovering
                      ? AppColors.primary.withValues(alpha: 0.05)
                      : Colors.transparent),
            border: Border.all(
              color: active ? AppColors.primary : AppColors.border,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: active ? AppColors.primary : AppColors.title,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                  color: active ? AppColors.primary : AppColors.title,
                ),
              ),
              if (widget.count > 0) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: active
                        ? AppColors.primary.withValues(alpha: 0.2)
                        : AppColors.section,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${widget.count}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: active ? AppColors.primary : AppColors.muted,
                    ),
                  ),
                ),
              ],
              if (widget.hasVideo) ...[
                const SizedBox(width: 6),
                Icon(
                  Icons.play_circle_fill_rounded,
                  size: 15,
                  color: active ? AppColors.primary : AppColors.muted,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
