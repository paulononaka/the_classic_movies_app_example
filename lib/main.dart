import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies/l10n/s.dart';
import 'package:movies/dependencies.dart';
import 'package:movies/movies.dart';
import 'package:design_system/design_system.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dependencies = AppDependencies();
  await dependencies.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final navigator = dependencies.get<MoviesNavigator>();

  @override
  Widget build(BuildContext context) {
    return ClassicMoviesThemeProviderApp(
      initialThemeMode: ThemeMode.light,
      builder: (themeMode, light, dark) => MaterialApp.router(
        title: 'Classic Movies App',
        theme: light,
        darkTheme: dark,
        themeMode: themeMode,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.supportedLocales,
        routerConfig: navigator.config(),
      ),
    );
  }
}
