import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/routes/movies_routes.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class MoviesNavigator {
  static const moviesHome = '/';
  static const moviesDetails = '/details/:movieId';

  RouterConfig<Object> config() {
    final router = GoRouter(
      observers: [SentryNavigatorObserver()],
      initialLocation: moviesHome,
      routes: [
        MoviesHomeGoRoute(
          path: moviesHome,
          name: moviesHome,
          routes: [MovieDetailsGoRoute(path: 'details/:movieId', name: moviesDetails)],
        ),
      ],
    );

    return router;
  }

  void navigateToMovieDetails(BuildContext context, int movieId) {
    MovieDetailsGoRoute.navigate(context, movieId);
  }
}
