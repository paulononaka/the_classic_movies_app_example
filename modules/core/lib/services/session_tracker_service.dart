import 'dart:math';

import 'package:core/logger/mca_logger.dart';

class SessionTrackerService {
  static final SessionTrackerService _instance = SessionTrackerService._();

  SessionTrackerService._() {
    setSessionId();
  }

  factory SessionTrackerService() => _instance;

  String? _sessionId;

  String get sessionId => _sessionId ?? '';

  void setSessionId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    _sessionId = List.generate(10, (_) => chars[random.nextInt(chars.length)]).join();
    CMALogger.d('Session: $sessionId');
  }
}
