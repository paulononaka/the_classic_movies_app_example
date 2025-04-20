import 'package:flutter/material.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';
import 'package:core/env.dart';
import 'package:movies/dependencies.dart';

class ProducedByTabWidget extends StatelessWidget {
  ProducedByTabWidget({super.key, required this.movieDetail});

  final MovieDetailModel movieDetail;
  final env = di.get<Env>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: movieDetail.productionCompanies.length,
        itemBuilder: (context, index) {
          final company = movieDetail.productionCompanies[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: company.logoPath.isNotEmpty ? NetworkImage('${env.tmdbImageUrl}w200${company.logoPath}') : null,
              radius: 25,
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: company.logoPath.isEmpty ? const Icon(Icons.business) : null,
            ),
            title: Text(
              company.name,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'Origin: ${company.originCountry}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withAlpha(153)),
            ),
          );
        },
      ),
    );
  }
}
