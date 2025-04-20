import 'package:flutter/material.dart';

/// Theme extension for custom colors and text styles in Classic Movies App
class ClassicMoviesAppThemeExtension extends ThemeExtension<ClassicMoviesAppThemeExtension> {
  // Custom colors
  final Color primaryYellow;
  final Color canvasLight;
  final Color scaffoldBackground;
  final Color cardBackground;
  final Color inputFillBackground;
  final Color textLight;
  final Color textDark;
  final Color hintText;
  final Color border;
  final Color tabIndicator;
  final Color starRating;
  final Color secondary;
  final Color error;

  const ClassicMoviesAppThemeExtension({
    required this.primaryYellow,
    required this.canvasLight,
    required this.scaffoldBackground,
    required this.cardBackground,
    required this.inputFillBackground,
    required this.textLight,
    required this.textDark,
    required this.hintText,
    required this.border,
    required this.tabIndicator,
    required this.starRating,
    required this.secondary,
    required this.error,
  });

  // Create light theme extension
  static ClassicMoviesAppThemeExtension get light => const ClassicMoviesAppThemeExtension(
        primaryYellow: Color(0xFFF2C94C),
        canvasLight: Color(0xFFF5F5F0),
        scaffoldBackground: Color(0xFF242A32),
        cardBackground: Color(0xFF1A1A1A),
        inputFillBackground: Color(0xFF252525),
        textLight: Color(0xFFECECEC),
        textDark: Color(0xFF333333),
        hintText: Color(0xFF999999),
        border: Color(0xFF3C3C3C),
        tabIndicator: Color(0xFF3A3F47),
        starRating: Color(0xFFFF8700),
        secondary: Color(0xFF8C1D18),
        error: Color(0xFFE76F51),
      );

  // Create dark theme extension
  static ClassicMoviesAppThemeExtension get dark => const ClassicMoviesAppThemeExtension(
        primaryYellow: Color(0xFFF2C94C),
        canvasLight: Color(0xFF1A1A1A), // Darker in dark mode
        scaffoldBackground: Color(0xFF242A32),
        cardBackground: Color(0xFF1A1A1A),
        inputFillBackground: Color(0xFF252525),
        textLight: Color(0xFFECECEC),
        textDark: Color(0xFF333333),
        hintText: Color(0xFF999999),
        border: Color(0xFF3C3C3C),
        tabIndicator: Color(0xFF3A3F47),
        starRating: Color(0xFFFF8700),
        secondary: Color(0xFF8C1D18),
        error: Color(0xFFE76F51),
      );

  @override
  ThemeExtension<ClassicMoviesAppThemeExtension> copyWith({
    Color? primaryYellow,
    Color? canvasLight,
    Color? scaffoldBackground,
    Color? cardBackground,
    Color? inputFillBackground,
    Color? textLight,
    Color? textDark,
    Color? hintText,
    Color? border,
    Color? tabIndicator,
    Color? starRating,
    Color? secondary,
    Color? error,
  }) {
    return ClassicMoviesAppThemeExtension(
      primaryYellow: primaryYellow ?? this.primaryYellow,
      canvasLight: canvasLight ?? this.canvasLight,
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      cardBackground: cardBackground ?? this.cardBackground,
      inputFillBackground: inputFillBackground ?? this.inputFillBackground,
      textLight: textLight ?? this.textLight,
      textDark: textDark ?? this.textDark,
      hintText: hintText ?? this.hintText,
      border: border ?? this.border,
      tabIndicator: tabIndicator ?? this.tabIndicator,
      starRating: starRating ?? this.starRating,
      secondary: secondary ?? this.secondary,
      error: error ?? this.error,
    );
  }

  @override
  ThemeExtension<ClassicMoviesAppThemeExtension> lerp(
      ThemeExtension<ClassicMoviesAppThemeExtension>? other, double t) {
    if (other is! ClassicMoviesAppThemeExtension) {
      return this;
    }
    return ClassicMoviesAppThemeExtension(
      primaryYellow: Color.lerp(primaryYellow, other.primaryYellow, t)!,
      canvasLight: Color.lerp(canvasLight, other.canvasLight, t)!,
      scaffoldBackground: Color.lerp(scaffoldBackground, other.scaffoldBackground, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      inputFillBackground: Color.lerp(inputFillBackground, other.inputFillBackground, t)!,
      textLight: Color.lerp(textLight, other.textLight, t)!,
      textDark: Color.lerp(textDark, other.textDark, t)!,
      hintText: Color.lerp(hintText, other.hintText, t)!,
      border: Color.lerp(border, other.border, t)!,
      tabIndicator: Color.lerp(tabIndicator, other.tabIndicator, t)!,
      starRating: Color.lerp(starRating, other.starRating, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}
