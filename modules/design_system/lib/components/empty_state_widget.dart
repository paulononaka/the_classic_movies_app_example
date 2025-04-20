import 'package:flutter/material.dart';
import 'package:design_system/theme/extensions/classic_movies_app_theme_extension.dart';
import 'package:design_system/l10n/s.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key, required this.message, this.icon = Icons.inbox_outlined, this.iconSize = 60, this.iconColor, this.onAction});

  final String message;
  final IconData icon;
  final double iconSize;
  final Color? iconColor;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeExtension = theme.extension<ClassicMoviesAppThemeExtension>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: iconSize, color: iconColor ?? themeExtension?.textLight),
          const SizedBox(height: 16),
          Text(message, style: TextStyle(color: themeExtension?.textLight, fontSize: 16), textAlign: TextAlign.center),
          if (onAction != null) ...[
            const SizedBox(height: 24),
            ElevatedButton(onPressed: onAction, child: Text(S.of(context)!.empty_state_action)),
          ],
        ],
      ),
    );
  }
}
