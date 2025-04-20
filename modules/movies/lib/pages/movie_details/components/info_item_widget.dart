import 'package:flutter/material.dart';

class InfoItemWidget extends StatelessWidget {
  const InfoItemWidget({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(153),
        );

    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.onSurface.withAlpha(153), size: 16),
        const SizedBox(width: 4),
        Text(text, style: textStyle),
      ],
    );
  }
}
