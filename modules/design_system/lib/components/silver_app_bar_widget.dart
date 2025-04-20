import 'package:flutter/material.dart';

class SilverAppBarWidget extends StatelessWidget {
  const SilverAppBarWidget({super.key, required this.context, required this.title});

  final BuildContext context;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      title: Text(title, style: Theme.of(context).appBarTheme.titleTextStyle),
      actions: [IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {})],
    );
  }
}
