import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _FloatController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> offset;

  @override
  void onInit() {
    super.onInit();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    offset = Tween<double>(
      begin: -6,
      end: 6,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}

/// Wraps [child] in a slow, continuous vertical bob — subtle ambient motion
/// for hero art so the page doesn't feel static. Purely decorative.
class Floating extends StatelessWidget {
  final String tag;
  final Widget child;

  const Floating({super.key, required this.tag, required this.child});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<_FloatController>(
      init: _FloatController(),
      tag: tag,
      global: false,
      builder: (c) {
        return RepaintBoundary(
          child: AnimatedBuilder(
            animation: c.controller,
            builder: (context, cachedChild) => Transform.translate(
              offset: Offset(0, c.offset.value),
              child: cachedChild,
            ),
            child: child,
          ),
        );
      },
    );
  }
}
