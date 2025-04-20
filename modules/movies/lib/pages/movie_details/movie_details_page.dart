import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:movies/dependencies.dart';
import 'package:movies/domain/repositories/movies_repository.dart';
import 'package:movies/pages/movie_details/components/movie_details_widget.dart';
import 'package:movies/pages/movie_details/components/movie_header_widget.dart';
import 'package:movies/pages/movie_details/components/tab_bar_widget.dart';
import 'package:movies/pages/movie_details/components/tab_content_widget.dart';
import 'package:provider/provider.dart';
import 'movie_details.controller.dart';
import 'package:movies/l10n/s.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  static Widget create({required int movieId}) {
    return ChangeNotifierProvider(
      create: (context) => MovieDetailsController(moviesRepository: di.get<IMoviesRepository>()),
      child: MovieDetailsPage(movieId: movieId),
    );
  }

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadMovieData();
  }

  Future<void> _loadMovieData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<MovieDetailsController>().fetchMovieDetails(context, movieId: widget.movieId);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MovieDetailsController>();
    final movieDetail = controller.movieDetail;

    return Scaffold(
      body: controller.status.isLoading
          ? const LoadingWidget()
          : controller.status.isError
              ? AppErrorWidget(
                  message: controller.errorMessage.isNotEmpty ? controller.errorMessage : S.of(context)!.movie_details_error_loading,
                  onRetry: () => controller.fetchMovieDetails(context, movieId: widget.movieId),
                  onBack: () => Navigator.of(context).pop(),
                )
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MovieHeaderWidget(movieDetail: movieDetail),
                          MovieDetailsWidget(movieDetail: movieDetail),
                          TabBarWidget(tabController: _tabController),
                          TabContentWidget(tabController: _tabController, movieDetail: movieDetail),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
