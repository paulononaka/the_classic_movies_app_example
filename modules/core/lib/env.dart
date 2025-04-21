class Env {
  // TMDB Configuration
  static String get _tmdbApiKeyEnv => const String.fromEnvironment('TMDB_API_KEY', defaultValue: 'your_tmdb_api_key');
  static String get _tmdbBaseUrlEnv => const String.fromEnvironment('TMDB_BASE_URL', defaultValue: 'https://api.themoviedb.org/3');
  static String get _tmdbImageUrlEnv => const String.fromEnvironment('TMDB_IMAGE_URL', defaultValue: 'https://image.tmdb.org/t/p/');
  static String get _sentryDsnEnv => const String.fromEnvironment('SENTRY_DSN', defaultValue: '');

  // Firebase Web Configuration
  static String get _firebaseWebApiKeyEnv => const String.fromEnvironment('FIREBASE_WEB_API_KEY', defaultValue: '');
  static String get _firebaseWebAppIdEnv => const String.fromEnvironment('FIREBASE_WEB_APP_ID', defaultValue: '');
  static String get _firebaseAuthDomainEnv => const String.fromEnvironment('FIREBASE_AUTH_DOMAIN', defaultValue: '');
  static String get _firebaseMeasurementIdEnv => const String.fromEnvironment('FIREBASE_MEASUREMENT_ID', defaultValue: '');

  // Firebase Android Configuration
  static String get _firebaseAndroidApiKeyEnv => const String.fromEnvironment('FIREBASE_ANDROID_API_KEY', defaultValue: '');
  static String get _firebaseAndroidAppIdEnv => const String.fromEnvironment('FIREBASE_ANDROID_APP_ID', defaultValue: '');

  // Firebase iOS Configuration
  static String get _firebaseIosApiKeyEnv => const String.fromEnvironment('FIREBASE_IOS_API_KEY', defaultValue: '');
  static String get _firebaseIosAppIdEnv => const String.fromEnvironment('FIREBASE_IOS_APP_ID', defaultValue: '');
  static String get _firebaseIosBundleIdEnv => const String.fromEnvironment('FIREBASE_IOS_BUNDLE_ID', defaultValue: '');

  // Firebase Common Configuration
  static String get _firebaseProjectIdEnv => const String.fromEnvironment('FIREBASE_PROJECT_ID', defaultValue: '');
  static String get _firebaseMessagingSenderIdEnv => const String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID', defaultValue: '');
  static String get _firebaseStorageBucketEnv => const String.fromEnvironment('FIREBASE_STORAGE_BUCKET', defaultValue: '');

  // TMDB Getters
  String get tmdbApiKey => Env._tmdbApiKeyEnv;
  String get tmdbBaseUrl => Env._tmdbBaseUrlEnv;
  String get tmdbImageUrl => Env._tmdbImageUrlEnv;
  String get sentryDsn => Env._sentryDsnEnv;

  // Firebase Web Getters
  String get firebaseWebApiKey => Env._firebaseWebApiKeyEnv;
  String get firebaseWebAppId => Env._firebaseWebAppIdEnv;
  String get firebaseAuthDomain => Env._firebaseAuthDomainEnv;
  String get firebaseMeasurementId => Env._firebaseMeasurementIdEnv;

  // Firebase Android Getters
  String get firebaseAndroidApiKey => Env._firebaseAndroidApiKeyEnv;
  String get firebaseAndroidAppId => Env._firebaseAndroidAppIdEnv;

  // Firebase iOS Getters
  String get firebaseIosApiKey => Env._firebaseIosApiKeyEnv;
  String get firebaseIosAppId => Env._firebaseIosAppIdEnv;
  String get firebaseIosBundleId => Env._firebaseIosBundleIdEnv;

  // Firebase Common Getters
  String get firebaseProjectId => Env._firebaseProjectIdEnv;
  String get firebaseMessagingSenderId => Env._firebaseMessagingSenderIdEnv;
  String get firebaseStorageBucket => Env._firebaseStorageBucketEnv;
}
