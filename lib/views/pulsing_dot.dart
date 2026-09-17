import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _PulseController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> scale;
  late final Animation<double> opacity;

  @override
  void onInit() {
    super.onInit();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();
    scale = Tween<double>(
      begin: 1,
      end: 2.4,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    opacity = Tween<double>(
      begin: 0.5,
      end: 0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}

/// A solid dot of [size]/[color] with a continuously expanding, fading ring
/// pulsing outward behind it — used to mark "this one is live/current" (the
/// active role on the experience timeline).
class PulsingDot extends StatelessWidget {
  final String tag;
  final double size;
  final Color color;

  const PulsingDot({
    super.key,
    required this.tag,
    this.size = 14,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<_PulseController>(
      init: _PulseController(),
      tag: tag,
      global: false,
      builder: (c) {
        return SizedBox(
          width: size * 2.4,
          height: size * 2.4,
          child: RepaintBoundary(
            child: AnimatedBuilder(
              animation: c.controller,
              builder: (context, _) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.scale(
                      scale: c.scale.value,
                      child: Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color.withValues(alpha: c.opacity.value),
                        ),
                      ),
                    ),
                    Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                      ),
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
}
