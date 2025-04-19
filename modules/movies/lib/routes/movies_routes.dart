import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/movies.dart';
import 'package:movies/pages/movie_details/movie_details_page.dart';

class MoviesHomeGoRoute extends GoRoute {
  MoviesHomeGoRoute({required super.path, required String super.name, super.routes})
      : super(pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: MoviesPage()));

  static void navigate(BuildContext context) {
    GoRouter.of(context).goNamed(MoviesNavigator.moviesHome);
  }
}

class MovieDetailsGoRoute extends GoRoute {
  MovieDetailsGoRoute({required super.path, required String super.name})
      : super(pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const MovieDetailsPage()));

  static void navigate(BuildContext context) {
    GoRouter.of(context).goNamed(MoviesNavigator.moviesDetails);
  }
}
