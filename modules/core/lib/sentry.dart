import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:core/core.dart';

class SentryService {
  static Future<void> initialize(Future<void> Function() appRunner) async {
    final env = Env();
    final dsn = env.sentryDsn;

    if (dsn.isEmpty) {
      await appRunner();
      return;
    }

    await SentryFlutter.init(
      (options) {
        options.dsn = dsn;
        options.tracesSampleRate = 1.0;
        options.enableAutoSessionTracking = true;
        options.attachScreenshot = true;
        options.reportSilentFlutterErrors = true;
        options.experimental.replay.sessionSampleRate = 1.0;
        options.experimental.replay.onErrorSampleRate = 1.0;
        options.debug = true;
        options.maxRequestBodySize = MaxRequestBodySize.small;
        options.environment = kReleaseMode ? 'production' : 'development';
      },
      appRunner: appRunner,
    );
  }

  static void configureScope(SessionTrackerService sessionTracker) {
    Sentry.configureScope((scope) {
      scope.setTag('session_id', sessionTracker.sessionId);
    });
  }
}
