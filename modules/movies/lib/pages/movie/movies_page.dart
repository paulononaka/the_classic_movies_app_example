import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:movies/dependencies.dart';
import 'package:movies/domain/repositories/movies_repository.dart';
import 'package:movies/l10n/s.dart';
import 'package:movies/movies.dart';
import 'package:provider/provider.dart';
import 'package:core/env.dart';
import 'models/movie.model.dart';
import 'movies.controller.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) => MoviesController(moviesRepository: di.get<IMoviesRepository>()),
      child: const MoviesPage(),
    );
  }

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  final scrollController = ScrollController();
  final navigator = di.get<MoviesNavigator>();
  final env = di.get<Env>();

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _setupScrollListener();
  }

  Future<void> _loadInitialData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<MoviesController>().fetchInitialData();
    });
  }

  void _setupScrollListener() {
    final controller = context.read<MoviesController>();
    scrollController.addListener(() {
      if (_isScrollAtThreshold() && !controller.isLoadingMore && !controller.hasReachedMax) {
        controller.fetchNextPage();
      }
    });
  }

  bool _isScrollAtThreshold() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.8);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MoviesController>();
    final themeExtension = Theme.of(context).extension<ClassicMoviesAppThemeExtension>();

    return Scaffold(
      backgroundColor: themeExtension?.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: themeExtension?.scaffoldBackground,
        elevation: 0,
        title: Text(S.of(context)!.movies_page_title, style: Theme.of(context).appBarTheme.titleTextStyle),
        centerTitle: true,
      ),
      body: _buildContent(controller),
    );
  }

  Widget _buildContent(MoviesController controller) {
    if (controller.status.isLoading) {
      return const LoadingWidget();
    }

    if (controller.status.isError) {
      return AppErrorWidget(message: S.of(context)!.movies_page_error_message, onRetry: () => controller.fetchInitialData());
    }

    if (controller.status.isEmpty) {
      return EmptyStateWidget(
        message: S.of(context)!.movies_page_no_movies,
        icon: Icons.movie_outlined,
        onAction: () => controller.fetchInitialData(),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      itemCount: controller.movies.length + (controller.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= controller.movies.length) {
          return const Padding(padding: EdgeInsets.symmetric(vertical: 16.0), child: LoadingWidget());
        }

        final movie = controller.movies[index];
        return _buildMovieListItem(movie);
      },
    );
  }

  Widget _buildMovieListItem(MovieModel movie) {
    final releaseYear = movie.releaseDate.isNotEmpty ? movie.releaseDate.substring(0, 4) : '';
    final posterUrl = movie.posterPath != null ? '${env.tmdbImageUrl}w200${movie.posterPath}' : null;

    return MovieListItem(
      title: movie.title,
      posterUrl: posterUrl,
      rating: movie.voteAverage,
      genre: S.of(context)!.movies_page_genre_action,
      releaseYear: releaseYear,
      onTap: () => navigator.navigateToMovieDetails(context, movie.id),
    );
  }
}
