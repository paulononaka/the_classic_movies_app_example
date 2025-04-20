import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeExtension = Theme.of(context).extension<ClassicMoviesAppThemeExtension>();
    return Center(child: CircularProgressIndicator(color: themeExtension?.primaryYellow));
  }
}
