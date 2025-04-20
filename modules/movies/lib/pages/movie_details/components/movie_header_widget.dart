import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movies/pages/movie_details/components/movie_title_widget.dart';
import 'package:movies/pages/movie_details/components/tag_line_widget.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';

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
            Container(
              height: 211,
              width: double.infinity,
              decoration: BoxDecoration(
                image: movieDetail.backdropPath.isNotNullOrEmpty
                    ? DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w500${movieDetail.backdropPath}'), fit: BoxFit.cover)
                    : null,
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
                        const Icon(Icons.star, color: Color(0xFFFF8700), size: 16),
                        const SizedBox(width: 4),
                        Text(
                          movieDetail.voteAverage.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFFFF8700),
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
            Positioned(
              top: 150,
              left: 29,
              child: Container(
                width: 95,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: movieDetail.posterPath.isNotNullOrEmpty
                      ? DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w200${movieDetail.posterPath}'), fit: BoxFit.cover)
                      : null,
                ),
              ),
            ),
          ],
        ),
        MovieTitleWidget(movieDetail: movieDetail),
        if (movieDetail.tagline.isNotEmpty) TagLineWidget(movieDetail: movieDetail),
      ],
    );
  }
}
