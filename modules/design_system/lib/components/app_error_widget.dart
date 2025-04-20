import 'package:flutter/material.dart';
import 'package:design_system/theme/extensions/classic_movies_app_theme_extension.dart';
import 'package:design_system/l10n/s.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key, required this.message, this.onRetry, this.onBack});

  final String message;
  final VoidCallback? onRetry;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeExtension = theme.extension<ClassicMoviesAppThemeExtension>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 60),
          const SizedBox(height: 16),
          Text(message, style: TextStyle(color: themeExtension?.textLight, fontSize: 16), textAlign: TextAlign.center),
          if (onRetry != null) ...[const SizedBox(height: 24), ElevatedButton(onPressed: onRetry, child: Text(S.of(context)!.retry))],
          if (onBack != null) ...[
            const SizedBox(height: 16),
            TextButton(
              onPressed: onBack,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_back),
                  const SizedBox(width: 8),
                  Text(S.of(context)!.go_back, style: TextStyle(color: themeExtension?.textLight)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
