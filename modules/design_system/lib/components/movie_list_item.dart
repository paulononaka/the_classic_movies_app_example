import 'package:flutter/material.dart';
import 'package:design_system/components/info_row.dart';
import 'package:design_system/components/star_rating.dart';

class MovieListItem extends StatelessWidget {
  final String title;
  final String? posterUrl;
  final double rating;
  final String genre;
  final String releaseYear;
  final VoidCallback? onTap;

  const MovieListItem({
    super.key,
    required this.title,
    this.posterUrl,
    required this.rating,
    required this.genre,
    required this.releaseYear,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 95,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: posterUrl != null
                    ? DecorationImage(
                        image: NetworkImage(posterUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: Colors.grey[800],
              ),
              child: posterUrl == null ? const Icon(Icons.movie, color: Colors.grey, size: 40) : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  StarRating(rating: rating),
                  const SizedBox(height: 8),
                  InfoRow(icon: Icons.local_activity_outlined, text: genre),
                  const SizedBox(height: 4),
                  InfoRow(icon: Icons.calendar_today_outlined, text: releaseYear),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
