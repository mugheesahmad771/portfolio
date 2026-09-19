import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Full-screen image viewer — tap any thumbnail (admin form previews, public
/// screenshot grids) to see it at real size instead of squinting at a small
/// preview box. Supports pinch/scroll zoom and, when opened from a gallery
/// with more than one image, swiping between them.
class ImageLightbox extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const ImageLightbox({
    super.key,
    required this.images,
    this.initialIndex = 0,
  });

  /// Opens the lightbox over the current screen. No-ops on an empty list
  /// rather than showing a broken empty viewer.
  static void show(
    BuildContext context, {
    required List<String> images,
    int initialIndex = 0,
  }) {
    if (images.isEmpty) return;
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withValues(alpha: 0.92),
        pageBuilder: (context, animation, secondaryAnimation) =>
            FadeTransition(
              opacity: animation,
              child: ImageLightbox(
                images: images,
                initialIndex: initialIndex.clamp(0, images.length - 1),
              ),
            ),
      ),
    );
  }

  /// Convenience for the common single-image case (e.g. a thumbnail/cover
  /// preview) so callers don't need to wrap one URL in a list themselves.
  static void showSingle(BuildContext context, String imageUrl) =>
      show(context, images: [imageUrl]);

  @override
  State<ImageLightbox> createState() => _ImageLightboxState();
}

class _ImageLightboxState extends State<ImageLightbox> {
  late final PageController _controller = PageController(
    initialPage: widget.initialIndex,
  );
  late int _index = widget.initialIndex;
  final _focusNode = FocusNode();

  bool get _hasMultiple => widget.images.length > 1;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    if (index < 0 || index >= widget.images.length) return;
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _handleKey(KeyEvent event) {
    if (event is! KeyDownEvent) return;
    switch (event.logicalKey) {
      case LogicalKeyboardKey.escape:
        Navigator.of(context).pop();
      case LogicalKeyboardKey.arrowLeft:
        _goTo(_index - 1);
      case LogicalKeyboardKey.arrowRight:
        _goTo(_index + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: _handleKey,
        child: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: PageView.builder(
                controller: _controller,
                itemCount: widget.images.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (context, i) => Center(
                  child: InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 4,
                    child: Image.network(
                      widget.images[i],
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white54,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.white54,
                        size: 64,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 28),
                onPressed: () => Navigator.of(context).pop(),
                tooltip: 'Close',
              ),
            ),
            if (_hasMultiple) ...[
              // Arrow-key nav covers desktop already, but mouse users on a
              // non-touch device have no swipe gesture — these give them an
              // equivalent affordance instead of being stuck on one image.
              Positioned(
                left: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _NavArrowButton(
                    icon: Icons.chevron_left,
                    onPressed: _index > 0 ? () => _goTo(_index - 1) : null,
                  ),
                ),
              ),
              Positioned(
                right: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _NavArrowButton(
                    icon: Icons.chevron_right,
                    onPressed: _index < widget.images.length - 1
                        ? () => _goTo(_index + 1)
                        : null,
                  ),
                ),
              ),
              Positioned(
                bottom: 24,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        '${_index + 1} / ${widget.images.length}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NavArrowButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _NavArrowButton({required this.icon, required this.onPressed});

  @override
  State<_NavArrowButton> createState() => _NavArrowButtonState();
}

class _NavArrowButtonState extends State<_NavArrowButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;
    return MouseRegion(
      cursor: enabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withValues(
              alpha: !enabled ? 0.15 : (_hovering ? 0.55 : 0.35),
            ),
          ),
          child: Icon(
            widget.icon,
            color: Colors.white.withValues(alpha: enabled ? 1 : 0.3),
            size: 30,
          ),
        ),
      ),
    );
  }
}
