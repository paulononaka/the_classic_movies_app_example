import 'package:flutter/material.dart';
import 'package:movies/l10n/s.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';

class AboutMovieTabWidget extends StatelessWidget {
  final MovieDetailModel movieDetail;
  const AboutMovieTabWidget({super.key, required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16);
    final bodyStyle = Theme.of(context).textTheme.bodyMedium;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.of(context)!.movie_details_overview, style: titleStyle),
          const SizedBox(height: 8),
          Text(movieDetail.overview, style: bodyStyle),
          const SizedBox(height: 16),
          Text(S.of(context)!.movie_details_status, style: titleStyle),
          const SizedBox(height: 8),
          Text(movieDetail.status, style: bodyStyle),
        ],
      ),
    );
  }
}
