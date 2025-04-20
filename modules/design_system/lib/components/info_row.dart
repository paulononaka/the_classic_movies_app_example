import 'package:flutter/material.dart';
import 'package:design_system/theme/extensions/classic_movies_app_theme_extension.dart';

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextStyle? textStyle;
  final Color? iconColor;
  final double iconSize;
  final double spacing;

  const InfoRow({
    super.key,
    required this.icon,
    required this.text,
    this.textStyle,
    this.iconColor,
    this.iconSize = 16,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeExtension = theme.extension<ClassicMoviesAppThemeExtension>();
    
    return Row(
      children: [
        Icon(
          icon, 
          color: iconColor ?? themeExtension?.textLight, 
          size: iconSize
        ),
        SizedBox(width: spacing),
        Text(
          text,
          style: textStyle ?? theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
