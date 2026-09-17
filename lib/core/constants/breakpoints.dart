import 'package:flutter/widgets.dart';

/// Canonical responsive breakpoints for the app.
///
/// This is the single source of truth for breakpoints. A later pass will
/// replace the inconsistent hardcoded breakpoints currently scattered across
/// `app_header.dart` (600), `app_navigation_bar.dart` (768), and
/// `header.dart`/`app_footer.dart` (1024/1280) with these.
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
