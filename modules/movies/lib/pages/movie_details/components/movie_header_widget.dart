import 'package:flutter/material.dart';
import 'package:movies/dependencies.dart';
import 'package:movies/pages/movie_details/components/movie_title_widget.dart';
import 'package:movies/pages/movie_details/components/tag_line_widget.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';
import 'package:core/env.dart';

class MovieHeaderWidget extends StatelessWidget {
  const MovieHeaderWidget({super.key, required this.movieDetail});

  final MovieDetailModel movieDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            BackdropImageWidget(movieDetail: movieDetail),
            TopNavigationBarWidget(context: context),
            RatingDisplayWidget(movieDetail: movieDetail, context: context),
            MoviePosterWidget(movieDetail: movieDetail),
          ],
        ),
        TitleAndTaglineWidget(movieDetail: movieDetail),
      ],
    );
  }
}

class BackdropImageWidget extends StatelessWidget {
  BackdropImageWidget({super.key, required this.movieDetail});

  final MovieDetailModel movieDetail;
  final env = di.get<Env>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        image: movieDetail.backdropPath.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(
                  '${env.tmdbImageUrl}w500${movieDetail.backdropPath}',
                ),
                fit: BoxFit.cover,
              )
            : null,
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withAlpha(102),
              Colors.black.withAlpha(179),
            ],
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
      ),
    );
  }
}

class TopNavigationBarWidget extends StatelessWidget {
  const TopNavigationBarWidget({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(76),
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.amber,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(76),
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.bookmark_border,
                  color: Colors.amber,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingDisplayWidget extends StatelessWidget {
  const RatingDisplayWidget({super.key, required this.movieDetail, required this.context});

  final MovieDetailModel movieDetail;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(137),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 16),
            const SizedBox(width: 4),
            Text(
              movieDetail.voteAverage.toStringAsFixed(1),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.amber,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoviePosterWidget extends StatelessWidget {
  MoviePosterWidget({super.key, required this.movieDetail});

  final MovieDetailModel movieDetail;
  final env = di.get<Env>();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 24,
      bottom: -80,
      child: Container(
        width: 120,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(77),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: movieDetail.posterPath.isNotEmpty
            ? Image.network(
                '${env.tmdbImageUrl}w300${movieDetail.posterPath}',
                fit: BoxFit.cover,
              )
            : Container(color: Colors.grey.shade800),
      ),
    );
  }
}

class TitleAndTaglineWidget extends StatelessWidget {
  const TitleAndTaglineWidget({super.key, required this.movieDetail});

  final MovieDetailModel movieDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 24, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MovieTitleWidget(movieDetail: movieDetail),
          const SizedBox(height: 8),
          TagLineWidget(movieDetail: movieDetail),
        ],
      ),
    );
  }
}
