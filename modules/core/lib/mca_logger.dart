import 'package:flutter/foundation.dart';

class CMALogger {
  bool get _enabled => !kReleaseMode;

  void _log(String level, dynamic message) {
    if (_enabled) {
      debugPrint("$level: $message");
    }
  }

  CMALogger.d(String message) {
    _log('DEBUG', message);
  }

  CMALogger.e(String message, {required dynamic ex, required dynamic stacktrace}) {
    if (ex == null) return;
    _log('ERROR', '$message\n$ex: $stacktrace');
  }
}
