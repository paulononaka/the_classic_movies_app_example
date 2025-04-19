import 'package:flutter/material.dart';
import '../models/movie.model.dart';

class MovieTile extends StatelessWidget {
  final MovieModel movie;
  final bool isLoading;

  const MovieTile({
    super.key,
    required this.movie,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        // TODO: make Flutter version in the CI matches local setup
        // ignore: deprecated_member_use
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MovieTilePoster(movie: movie),
          const SizedBox(width: 12),
          MovieTileDetails(movie: movie),
        ],
      ),
    );
  }
}

class MovieTileDetails extends StatelessWidget {
  const MovieTileDetails({
    super.key,
    required this.movie,
  });

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movie.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(movie.releaseDate, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(movie.voteAverage.toString(), style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}

class MovieTilePoster extends StatelessWidget {
  const MovieTilePoster({
    super.key,
    required this.movie,
  });

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
        image: movie.posterPath != null ? DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w200${movie.posterPath}'), fit: BoxFit.cover) : null,
      ),
      child: movie.posterPath == null ? const Icon(Icons.movie, color: Colors.grey) : null,
    );
  }
}
