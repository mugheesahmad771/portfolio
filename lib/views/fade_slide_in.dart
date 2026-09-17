import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _FadeSlideInController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Duration delay;
  final Duration duration;
  _FadeSlideInController({required this.delay, required this.duration});

  late final AnimationController controller;
  late final Animation<double> opacity;
  late final Animation<double> offsetY;

  @override
  void onInit() {
    super.onInit();
    controller = AnimationController(vsync: this, duration: duration);
    final curved = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutCubic,
    );
    opacity = Tween<double>(begin: 0, end: 1).animate(curved);
    offsetY = Tween<double>(begin: 16, end: 0).animate(curved);

    Future.delayed(delay, () {
      if (!isClosed) controller.forward();
    });
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}

/// Reusable implicit fade + slide-up-in animation wrapper.
///
/// Animates its [child] from opacity 0 / translated 16px down to opacity 1 /
/// its natural position, starting after [delay] elapses. Intended for
/// reproducing the reference site's fade-up-with-stagger hero animation
/// (via a list of increasing [delay] values) and for gating scroll-triggered
/// reveals via [ScrollReveal].
///
/// Backed by a per-instance [GetxController] (keyed by [tag], via
/// [GetSingleTickerProviderStateMixin] for the animation vsync) rather than a
/// StatefulWidget, so the whole app stays on one state-management approach.
/// [tag] must be unique among concurrently-mounted [FadeSlideIn]s (e.g. a
/// fixed string per hero element, or an id-derived string for list items).
class FadeSlideIn extends StatelessWidget {
  final Widget child;
  final String tag;
  final Duration delay;
  final Duration duration;

  const FadeSlideIn({
    super.key,
    required this.child,
    required this.tag,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<_FadeSlideInController>(
      init: _FadeSlideInController(delay: delay, duration: duration),
      tag: tag,
      builder: (c) {
        return RepaintBoundary(
          child: AnimatedBuilder(
            animation: c.controller,
            builder: (context, animatedChild) {
              return Opacity(
                opacity: c.opacity.value,
                child: Transform.translate(
                  offset: Offset(0, c.offsetY.value),
                  child: animatedChild,
                ),
              );
            },
            child: child,
          ),
        );
      },
    );
  }
}
