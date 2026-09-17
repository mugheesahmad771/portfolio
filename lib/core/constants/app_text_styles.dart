import 'package:flutter/painting.dart';

/// Small collection of text styles used for special-purpose text (e.g.
/// uppercase eyebrow/mono-label text) across the app.
///
/// The base body font (Inter, bundled locally as a variable font — see
/// pubspec.yaml) gets wired into the app's `ThemeData` separately in
/// `main.dart` by a later pass.
class AppTextStyles {
  AppTextStyles._();

  /// Monospace style (JetBrains Mono, bundled locally) used for
  /// eyebrow/section-label text, replacing hardcoded `fontFamily:
  /// 'monospace'` usages.
  static TextStyle mono({
    double fontSize = 13,
    FontWeight fontWeight = FontWeight.w500,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: 'JetBrains Mono',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }
}
