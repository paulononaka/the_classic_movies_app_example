import 'package:flutter/material.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';

class TagLineWidget extends StatelessWidget {
  const TagLineWidget({super.key, required this.movieDetail});

  final MovieDetailModel movieDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 136, right: 29, top: 8),
      child: Text(
        movieDetail.tagline,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(153),
              fontStyle: FontStyle.italic,
            ),
      ),
    );
  }
}
