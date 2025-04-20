import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/movies.dart';
import 'package:movies/pages/movie_details/movie_details_page.dart';

class MoviesHomeGoRoute extends GoRoute {
  MoviesHomeGoRoute({required super.path, required String super.name, super.routes})
      : super(pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: MoviesPage.create()));

  static void navigate(BuildContext context) {
    GoRouter.of(context).goNamed(MoviesNavigator.moviesHome);
  }
}

class MovieDetailsGoRoute extends GoRoute {
  MovieDetailsGoRoute({required super.path, required String super.name})
      : super(
          pageBuilder: (context, state) {
            final movieId = int.parse(state.pathParameters['movieId'] ?? '0');
            return MaterialPage(
              key: state.pageKey,
              child: MovieDetailsPage.create(movieId: movieId),
            );
          },
        );

  static void navigate(BuildContext context, int movieId) {
    GoRouter.of(context).goNamed(
      MoviesNavigator.moviesDetails,
      pathParameters: {'movieId': movieId.toString()},
    );
  }
}
