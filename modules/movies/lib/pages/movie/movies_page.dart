import 'package:flutter/material.dart';
import 'package:movies/dependencies.dart';
import 'package:movies/movies.dart';
import 'package:movies/repositories/movies.repository.dart';
import 'package:provider/provider.dart';
import '../../l10n/s.dart';
import 'components/movie_tile.dart';
import 'movies.controller.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) => MoviesController(moviesRepository: dependencies.get<MoviesRepository>()),
      child: const MoviesPage(),
    );
  }

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  final scrollController = ScrollController();
  final navigator = dependencies.get<MoviesNavigator>();

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

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context)!.movies_page_app_bar), backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.all(16.0), child: Text(S.of(context)!.movies_page_title, style: Theme.of(context).textTheme.headlineMedium)),
          Expanded(child: _buildContent(controller)),
        ],
      ),
    );
  }

  Widget _buildContent(MoviesController controller) {
    if (controller.status.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.status.isError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 60),
            const SizedBox(height: 16),
            Text(
              S.of(context)!.movies_page_error_message, 
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
              textAlign: TextAlign.center
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      itemCount: controller.movies.length + (controller.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= controller.movies.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return MovieTile(movie: controller.movies[index], isLoading: false);
      },
    );
  }
}
