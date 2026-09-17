import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:portfolio/views/fade_slide_in.dart';

class _ScrollRevealController extends GetxController {
  final _visible = false.obs;
  bool get visible => _visible.value;

  void reveal() {
    if (_visible.value) return;
    _visible.value = true;
    update();
  }
}

/// Wraps [child] so it fades/slides in the first time it becomes at least
/// ~15% visible while scrolling, then stays visible. [id] must be unique
/// within the page (e.g. `'skill-card-$index'`) — it also tags the backing
/// per-instance [GetxController], so no StatefulWidget is needed here.
class ScrollReveal extends StatelessWidget {
  final String id;
  final Widget child;

  const ScrollReveal({super.key, required this.id, required this.child});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<_ScrollRevealController>(
      init: _ScrollRevealController(),
      tag: id,
      builder: (c) {
        return VisibilityDetector(
          key: Key('scroll-reveal-$id'),
          onVisibilityChanged: (info) {
            if (info.visibleFraction > 0.15) c.reveal();
          },
          child: c.visible
              ? FadeSlideIn(tag: 'reveal-fade-$id', child: child)
              : Opacity(opacity: 0, child: child),
        );
      },
    );
  }
}
