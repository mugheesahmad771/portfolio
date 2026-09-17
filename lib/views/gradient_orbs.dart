import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';

class _GradientOrbsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void onInit() {
    super.onInit();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}

/// Purely decorative: two large, softly-blurred color blobs that drift in a
/// slow loop. Meant to sit behind hero content via `Positioned.fill` inside
/// an outer [Stack] (it fills whatever bounded space it's given, rather than
/// sizing itself). Ignores pointer events and carries no semantic meaning.
class GradientOrbsBackground extends StatelessWidget {
  final String tag;
  const GradientOrbsBackground({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<_GradientOrbsController>(
      init: _GradientOrbsController(),
      tag: tag,
      global: false,
      builder: (c) {
        return IgnorePointer(
          child: RepaintBoundary(
            child: AnimatedBuilder(
              animation: c.controller,
              builder: (context, _) {
                final t = c.controller.value * 2 * math.pi;
                return Stack(
                  children: [
                    _orb(
                      color: AppColors.primary,
                      alignmentX: 0.75 + 0.1 * math.sin(t),
                      alignmentY: -0.7 + 0.08 * math.cos(t),
                      size: 420,
                    ),
                    _orb(
                      color: AppColors.purple,
                      alignmentX: -0.85 + 0.1 * math.cos(t * 0.82),
                      alignmentY: 0.6 + 0.08 * math.sin(t * 0.82),
                      size: 380,
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _orb({
    required Color color,
    required double alignmentX,
    required double alignmentY,
    required double size,
  }) {
    return Align(
      alignment: Alignment(alignmentX, alignmentY),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // A 2-stop gradient falls off linearly from center to edge, which
          // reads as a flat colored disc with a visible rim rather than a
          // soft ambient glow. A gradual middle stop fixes that without the
          // cost of an actual blur filter.
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: 0.16),
              color.withValues(alpha: 0.05),
              color.withValues(alpha: 0.0),
            ],
            stops: const [0.0, 0.55, 1.0],
          ),
        ),
      ),
    );
  }
}
