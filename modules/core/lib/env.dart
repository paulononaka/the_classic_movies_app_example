import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static Future<void> load() async {
    await dotenv.load(fileName: '.env');
  }

  static String get _tmdbApiKeyEnv => dotenv.get('TMDB_API_KEY', fallback: const String.fromEnvironment('TMDB_API_KEY', defaultValue: 'your_tmdb_api_key'));
  static String get _tmdbBaseUrlEnv => dotenv.get('TMDB_BASE_URL', fallback: const String.fromEnvironment('TMDB_BASE_URL', defaultValue: 'https://api.themoviedb.org/3'));
  static String get _tmdbImageUrlEnv => dotenv.get('TMDB_IMAGE_URL', fallback: const String.fromEnvironment('TMDB_IMAGE_URL', defaultValue: 'https://image.tmdb.org/t/p/'));
  static String get _sentryDsnEnv => dotenv.get('SENTRY_DSN', fallback: const String.fromEnvironment('SENTRY_DSN', defaultValue: ''));

  // Firebase Web Configuration
  static String get _firebaseWebApiKeyEnv => dotenv.get('FIREBASE_WEB_API_KEY', fallback: const String.fromEnvironment('FIREBASE_WEB_API_KEY', defaultValue: ''));
  static String get _firebaseWebAppIdEnv => dotenv.get('FIREBASE_WEB_APP_ID', fallback: const String.fromEnvironment('FIREBASE_WEB_APP_ID', defaultValue: ''));
  static String get _firebaseAuthDomainEnv => dotenv.get('FIREBASE_AUTH_DOMAIN', fallback: const String.fromEnvironment('FIREBASE_AUTH_DOMAIN', defaultValue: ''));
  static String get _firebaseMeasurementIdEnv => dotenv.get('FIREBASE_MEASUREMENT_ID', fallback: const String.fromEnvironment('FIREBASE_MEASUREMENT_ID', defaultValue: ''));

  // Firebase Android Configuration
  static String get _firebaseAndroidApiKeyEnv => dotenv.get('FIREBASE_ANDROID_API_KEY', fallback: const String.fromEnvironment('FIREBASE_ANDROID_API_KEY', defaultValue: ''));
  static String get _firebaseAndroidAppIdEnv => dotenv.get('FIREBASE_ANDROID_APP_ID', fallback: const String.fromEnvironment('FIREBASE_ANDROID_APP_ID', defaultValue: ''));

  // Firebase iOS Configuration
  static String get _firebaseIosApiKeyEnv => dotenv.get('FIREBASE_IOS_API_KEY', fallback: const String.fromEnvironment('FIREBASE_IOS_API_KEY', defaultValue: ''));
  static String get _firebaseIosAppIdEnv => dotenv.get('FIREBASE_IOS_APP_ID', fallback: const String.fromEnvironment('FIREBASE_IOS_APP_ID', defaultValue: ''));
  static String get _firebaseIosBundleIdEnv => dotenv.get('FIREBASE_IOS_BUNDLE_ID', fallback: const String.fromEnvironment('FIREBASE_IOS_BUNDLE_ID', defaultValue: ''));

  // Firebase Common Configuration
  static String get _firebaseProjectIdEnv => dotenv.get('FIREBASE_PROJECT_ID', fallback: const String.fromEnvironment('FIREBASE_PROJECT_ID', defaultValue: ''));
  static String get _firebaseMessagingSenderIdEnv => dotenv.get('FIREBASE_MESSAGING_SENDER_ID', fallback: const String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID', defaultValue: ''));
  static String get _firebaseStorageBucketEnv => dotenv.get('FIREBASE_STORAGE_BUCKET', fallback: const String.fromEnvironment('FIREBASE_STORAGE_BUCKET', defaultValue: ''));

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
