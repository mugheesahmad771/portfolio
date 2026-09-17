import 'package:flutter/widgets.dart';

/// Canonical responsive breakpoints for the app — the single source of
/// truth. Every layout that branches on screen width should read from here
/// rather than hardcoding its own pixel thresholds.
class Breakpoints {
  Breakpoints._();

  static const double mobile = 600;
  static const double desktop = 1024;

  /// True when the viewport width is below [mobile].
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobile;
  }

  /// True when the viewport width is at least [mobile] but below [desktop].
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobile && width < desktop;
  }

  /// True when the viewport width is at least [desktop].
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktop;
  }
}
