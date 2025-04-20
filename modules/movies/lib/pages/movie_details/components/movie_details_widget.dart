import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:movies/l10n/s.dart';
import 'package:movies/pages/movie_details/components/info_item_widget.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';

class MovieDetailsWidget extends StatelessWidget {
  const MovieDetailsWidget({super.key, required this.movieDetail});

  final MovieDetailModel movieDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Container(
        margin: const EdgeInsets.only(top: 0),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface.withAlpha(128), borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InfoItemWidget(icon: Icons.calendar_today_outlined, text: movieDetail.releaseDate),
              const DividerWidget(),
              InfoItemWidget(icon: Icons.access_time, text: '${movieDetail.runtime} ${S.of(context)!.movie_details_minutes}'),
              const DividerWidget(),
              InfoItemWidget(icon: Icons.local_movies_outlined, text: movieDetail.genreNames),
            ],
          ),
        ),
      ),
    );
  }
}
