import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class _CountUpController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final int target;
  final Duration duration;
  _CountUpController({required this.target, required this.duration});

  late final AnimationController controller;
  late final Animation<double> value;
  bool _started = false;

  @override
  void onInit() {
    super.onInit();
    controller = AnimationController(vsync: this, duration: duration);
    value = Tween<double>(
      begin: 0,
      end: target.toDouble(),
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutCubic));
  }

  void start() {
    if (_started) return;
    _started = true;
    controller.forward();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}

/// Renders [rawValue] (e.g. `"15+"`, `"100%"`, `"3 yrs"`) with its leading
/// number counting up from 0 the first time it scrolls into view. Anything
/// after the digits (`+`, `%`, ` yrs`, ...) is preserved verbatim. Falls
/// back to rendering [rawValue] as-is if it has no leading digits.
class CountUp extends StatelessWidget {
  final String tag;
  final String rawValue;
  final TextStyle? style;
  final Duration duration;

  const CountUp({
    super.key,
    required this.tag,
    required this.rawValue,
    this.style,
    this.duration = const Duration(milliseconds: 1400),
  });

  @override
  Widget build(BuildContext context) {
    final match = RegExp(r'^([\d,]+)').firstMatch(rawValue.trim());
    if (match == null) {
      return Text(rawValue, style: style);
    }
    final numeric = int.parse(match.group(1)!.replaceAll(',', ''));
    final suffix = rawValue.substring(match.end);

    return GetBuilder<_CountUpController>(
      init: _CountUpController(target: numeric, duration: duration),
      tag: tag,
      global: false,
      builder: (c) {
        return VisibilityDetector(
          key: Key('count-up-$tag'),
          onVisibilityChanged: (info) {
            if (info.visibleFraction > 0.3) c.start();
          },
          child: RepaintBoundary(
            child: AnimatedBuilder(
              animation: c.controller,
              builder: (context, _) =>
                  Text('${c.value.value.round()}$suffix', style: style),
            ),
          ),
        );
      },
    );
  }
}
