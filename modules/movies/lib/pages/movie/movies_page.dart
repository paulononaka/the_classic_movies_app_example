import 'package:flutter/material.dart';
import 'package:movies/dependencies.dart';
import 'package:movies/movies.dart';
import '../../l10n/s.dart';

class MoviesPage extends StatelessWidget {
  MoviesPage({super.key});

  final navigator = dependencies.get<MoviesNavigator>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context)!.hello), backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context)!.hello, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => navigator.navigateToMovieDetails(context),
              child: const Text('View Movie Details'),
            ),
          ],
        ),
      ),
    );
  }
}
