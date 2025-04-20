import 'package:flutter/material.dart';
import '../classic_movies_app_theme.dart';

typedef ClassicMoviesThemeBuilder = Widget Function(
  ThemeMode themeMode,
  ThemeData light,
  ThemeData dark,
);

class ClassicMoviesThemeProviderApp extends StatefulWidget {
  const ClassicMoviesThemeProviderApp({super.key, required this.initialThemeMode, required this.builder});

  final ThemeMode initialThemeMode;
  final ClassicMoviesThemeBuilder builder;

  @override
  State<ClassicMoviesThemeProviderApp> createState() => ClassicMoviesThemeProviderAppState();

  static ClassicMoviesThemeProviderAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<ClassicMoviesThemeProviderAppState>();
  }
}

class ClassicMoviesThemeProviderAppState extends State<ClassicMoviesThemeProviderApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
  }

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      setState(() {
        _themeMode = mode;
      });
    }
  }

  void toggleTheme() {
    setThemeMode(_themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) => _ClassicMoviesTheme(
        themeMode: _themeMode,
        child: widget.builder(_themeMode, ClassicMoviesAppTheme.theme, ClassicMoviesAppTheme.darkTheme),
      );
}

class _ClassicMoviesTheme extends InheritedWidget {
  const _ClassicMoviesTheme({required this.themeMode, required super.child});

  final ThemeMode themeMode;

  @override
  bool updateShouldNotify(_ClassicMoviesTheme oldWidget) => themeMode != oldWidget.themeMode;
}

/// Helper class to provide theme switching functionality throughout the app
class ClassicMoviesTheme {
  static ThemeData getTheme(BuildContext context) {
    final _ClassicMoviesTheme? inheritedTheme = context.dependOnInheritedWidgetOfExactType<_ClassicMoviesTheme>();
    final themeMode = inheritedTheme?.themeMode ?? ThemeMode.system;

    final brightness = switch (themeMode) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system => MediaQuery.platformBrightnessOf(context),
    };

    return brightness == Brightness.light ? ClassicMoviesAppTheme.theme : ClassicMoviesAppTheme.darkTheme;
  }

  static void toggleTheme(BuildContext context) {
    ClassicMoviesThemeProviderApp.of(context)?.toggleTheme();
  }

  static ThemeMode getThemeMode(BuildContext context) {
    final inheritedTheme = context.dependOnInheritedWidgetOfExactType<_ClassicMoviesTheme>();
    return inheritedTheme?.themeMode ?? ThemeMode.system;
  }
}
