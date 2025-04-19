import 'package:flutter/material.dart';
import '../classic_movies_theme.dart';

typedef ClassicMoviesThemeBuilder = Widget Function(
  ThemeMode themeMode,
  ThemeData light,
  ThemeData dark,
);

class ClassicMoviesThemeProviderApp extends StatelessWidget {
  const ClassicMoviesThemeProviderApp({super.key, required this.themeMode, required this.builder});

  final ThemeMode themeMode;
  final ClassicMoviesThemeBuilder builder;

  @override
  Widget build(BuildContext context) => _ClassicMoviesTheme(
        themeMode: themeMode,
        child: builder(themeMode, ClassicMoviesTheme.theme, ClassicMoviesTheme.darkTheme),
      );
}

class _ClassicMoviesTheme extends InheritedWidget {
  const _ClassicMoviesTheme({required this.themeMode, required super.child});

  final ThemeMode themeMode;

  @override
  bool updateShouldNotify(_ClassicMoviesTheme oldWidget) => themeMode != oldWidget.themeMode;
}
