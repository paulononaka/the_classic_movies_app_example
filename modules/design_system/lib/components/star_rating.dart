import 'package:flutter/material.dart';
import 'package:design_system/theme/extensions/classic_movies_app_theme_extension.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double iconSize;
  final double spacing;
  final TextStyle? textStyle;

  const StarRating({
    super.key,
    required this.rating,
    this.iconSize = 16,
    this.spacing = 4,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeExtension = theme.extension<ClassicMoviesAppThemeExtension>();

    return Row(
      children: [
        Icon(Icons.star, color: themeExtension?.starRating, size: iconSize),
        SizedBox(width: spacing),
        Text(
          rating.toStringAsFixed(1),
          style: textStyle ??
              theme.textTheme.bodySmall?.copyWith(
                color: themeExtension?.starRating,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.12,
              ),
        ),
      ],
    );
  }
}
