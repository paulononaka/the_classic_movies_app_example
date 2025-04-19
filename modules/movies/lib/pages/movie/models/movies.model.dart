import 'movie.model.dart';

class MoviesModel {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  const MoviesModel({required this.page, required this.results, required this.totalPages, required this.totalResults});

  MoviesModel copyWith({int? page, List<MovieModel>? results, int? totalPages, int? totalResults}) {
    return MoviesModel(
      page: page ?? this.page,
      results: results ?? this.results,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }

  factory MoviesModel.empty() => MoviesModel.fromJson({});
  factory MoviesModel.fixture() => MoviesModel(page: 1, results: List.generate(40, (_) => MovieModel.fixture()), totalPages: 10, totalResults: 100);

  static MoviesModel fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      page: json['page'] ?? 1,
      results: (json['results'] as List<dynamic>?)?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MoviesModel && other.page == page && other.totalPages == totalPages && other.totalResults == totalResults && other.results == results;
  }

  @override
  int get hashCode {
    return page.hashCode ^ totalPages.hashCode ^ totalResults.hashCode ^ results.hashCode;
  }

  @override
  String toString() {
    return 'MoviesModel(page: $page, results: ${results.length}, totalPages: $totalPages, totalResults: $totalResults)';
  }
}
