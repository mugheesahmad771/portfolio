import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/views/image_lightbox.dart';

/// One screenshot tile shared by the detail page's screenshot grid and its
/// per-app screenshot rows — hover lift + zoom-cue overlay so it reads as
/// clickable before the user ever taps, then opens the shared lightbox
/// scoped to [gallery] (so swiping moves through that app's/section's own
/// screenshots, not the whole project's).
class ScreenshotThumb extends StatefulWidget {
  final String url;
  final String semanticLabel;
  final List<String> gallery;
  final int index;
  final double borderRadius;

  const ScreenshotThumb({
    super.key,
    required this.url,
    required this.semanticLabel,
    required this.gallery,
    required this.index,
    this.borderRadius = 12,
  });

  @override
  State<ScreenshotThumb> createState() => _ScreenshotThumbState();
}

class _ScreenshotThumbState extends State<ScreenshotThumb> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () => ImageLightbox.show(
          context,
          images: widget.gallery,
          initialIndex: widget.index,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transformAlignment: Alignment.center,
          transform: Matrix4.identity()
            ..scaleByDouble(
              _hovering ? 1.03 : 1.0,
              _hovering ? 1.03 : 1.0,
              1.0,
              1.0,
            ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : const [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  widget.url,
                  fit: BoxFit.cover,
                  semanticLabel: widget.semanticLabel,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const ColoredBox(
                      color: AppColors.section,
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.disabled,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => const ColoredBox(
                    color: AppColors.section,
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.disabled,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _hovering ? 1 : 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.zoom_in_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
