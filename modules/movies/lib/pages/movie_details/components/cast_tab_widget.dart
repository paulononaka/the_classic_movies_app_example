import 'package:flutter/material.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';

class CastTabWidget extends StatelessWidget {
  final MovieDetailModel movieDetail;
  const CastTabWidget({super.key, required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: movieDetail.cast.length,
        itemBuilder: (context, index) {
          final cast = movieDetail.cast[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://image.tmdb.org/t/p/w200${cast.profilePath}'),
              radius: 25,
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: cast.profilePath.isEmpty ? const Icon(Icons.person) : null,
            ),
            title: Text(
              cast.name,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              cast.character,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withAlpha(153)),
            ),
          );
        },
      ),
    );
  }
}
