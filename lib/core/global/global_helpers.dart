import 'package:flutter/foundation.dart' show kIsWeb;

import '../sessions/session_helper.dart';

/// Cross-platform connection-error detector.
/// Avoids importing dart:io (unavailable on web) while still catching
/// SocketException on native and browser network errors on web.
bool isConnectionError(Object e) {
  if (kIsWeb) {
    final msg = e.toString().toLowerCase();
    return msg.contains('failed to fetch') ||
        msg.contains('networkerror') ||
        msg.contains('xmlhttprequest') ||
        msg.contains('connection refused') ||
        msg.contains('socket');
  }
  return e.runtimeType.toString().contains('SocketException');
}

/// Single shared session instance — the admin JWT and login state live
/// here, read by [MainClient]'s auth interceptor and [AuthService].
final sessionHelper = SessionHelper();
