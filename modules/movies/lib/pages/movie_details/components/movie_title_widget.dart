import 'package:flutter/material.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';

class MovieTitleWidget extends StatelessWidget {
  const MovieTitleWidget({super.key, required this.movieDetail});

  final MovieDetailModel movieDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 136, right: 29, top: 25),
      child: Text(
        movieDetail.title,
        style: Theme.of(context).textTheme.titleLarge,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
