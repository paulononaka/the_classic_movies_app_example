import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static Future<void> load() async {
    await dotenv.load(fileName: '.env');
  }

  static String get _tmdbApiKeyEnv => dotenv.get('TMDB_API_KEY', fallback: const String.fromEnvironment('TMDB_API_KEY', defaultValue: 'your_tmdb_api_key'));
  static String get _tmdbBaseUrlEnv => dotenv.get('TMDB_BASE_URL', fallback: const String.fromEnvironment('TMDB_BASE_URL', defaultValue: 'https://api.themoviedb.org/3'));
  static String get _tmdbImageUrlEnv => dotenv.get('TMDB_IMAGE_URL', fallback: const String.fromEnvironment('TMDB_IMAGE_URL', defaultValue: 'https://image.tmdb.org/t/p/'));

  String get tmdbApiKey => Env._tmdbApiKeyEnv;
  String get tmdbBaseUrl => Env._tmdbBaseUrlEnv;
  String get tmdbImageUrl => Env._tmdbImageUrlEnv;
}
