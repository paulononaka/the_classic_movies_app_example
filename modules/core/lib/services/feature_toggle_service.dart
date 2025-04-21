import 'package:core/core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

enum FeatureToggle {
  showRatingDisplay('show_rating_display');

  final String key;
  const FeatureToggle(this.key);
}

class FeatureToggleService {
  final FirebaseRemoteConfig _remoteConfig;

  FeatureToggleService(this._remoteConfig);

  Future<void> initialize() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: kReleaseMode ? const Duration(hours: 1) : const Duration(seconds: 0),
        ),
      );

      await _remoteConfig.setDefaults({
        FeatureToggle.showRatingDisplay.key: false,
      });

      final fetchStatus = await _remoteConfig.fetchAndActivate();
      CMALogger.d('Remote config fetch and activate status: $fetchStatus');

      final showRating = _remoteConfig.getBool(FeatureToggle.showRatingDisplay.key);
      CMALogger.d('Feature toggle ${FeatureToggle.showRatingDisplay.key} value: $showRating');
    } catch (e, stacktrace) {
      CMALogger.e('Error initializing remote config', ex: e, stacktrace: stacktrace);
    }
  }

  Future<bool> refreshConfig() async {
    try {
      await _remoteConfig.fetch();
      final activated = await _remoteConfig.activate();

      final showRating = _remoteConfig.getBool(FeatureToggle.showRatingDisplay.key);
      CMALogger.d('After refresh: Feature toggle ${FeatureToggle.showRatingDisplay.key} value: $showRating');

      return activated;
    } catch (e, stacktrace) {
      CMALogger.e('Error refreshing remote config', ex: e, stacktrace: stacktrace);
      return false;
    }
  }

  bool isFeatureEnabled(FeatureToggle feature) {
    final isEnabled = _remoteConfig.getBool(feature.key);
    CMALogger.d('Checking feature ${feature.key}: $isEnabled');
    return isEnabled;
  }

  FirebaseRemoteConfig get remoteConfig => _remoteConfig;
}
