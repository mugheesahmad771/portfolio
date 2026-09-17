import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens the real CV PDF, served from the web build's root
/// (`web/Mughees_Ahmad_Flutter_CV-3.pdf`), in a new tab.
Future<void> downloadResumePdf() async {
  final base = kIsWeb ? Uri.base.origin : '';
  final url = Uri.parse('$base/Mughees_Ahmad_Flutter_CV-3.pdf');
  await launchUrl(url, webOnlyWindowName: '_blank');
}
