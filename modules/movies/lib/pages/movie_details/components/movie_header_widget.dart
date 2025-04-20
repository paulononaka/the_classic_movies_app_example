import 'package:flutter/material.dart';
import 'package:design_system/theme/extensions/classic_movies_app_theme_extension.dart';
import 'package:movies/pages/movie_details/components/movie_title_widget.dart';
import 'package:movies/pages/movie_details/components/tag_line_widget.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';

class MovieHeaderWidget extends StatelessWidget {
  const MovieHeaderWidget({super.key, required this.movieDetail});

  final MovieDetailModel movieDetail;

  @override
  Widget build(BuildContext context) {
    final themeExtension = Theme.of(context).extension<ClassicMoviesAppThemeExtension>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: movieDetail.backdropPath.isNotEmpty
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w500${movieDetail.backdropPath}',
                      fit: BoxFit.cover,
                    )
                  : Container(color: Theme.of(context).colorScheme.surface),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withAlpha(204),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8, bottom: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.surface, blurRadius: 10)],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: themeExtension?.starRating, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            movieDetail.voteAverage.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: themeExtension?.starRating,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              MovieTitleWidget(movieDetail: movieDetail),
              const SizedBox(height: 8),
              TagLineWidget(movieDetail: movieDetail),
            ],
          ),
        ),
      ],
    );
  }
}
