import 'package:hive/hive.dart';

part 'movie.model.g.dart';

@HiveType(typeId: 1)
class MovieModel {
  @HiveField(0)
  final String? backdropPath;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String? posterPath;
  @HiveField(3)
  final String releaseDate;
  @HiveField(4)
  final String title;
  @HiveField(5)
  final double voteAverage;

  const MovieModel({
    this.backdropPath,
    required this.id,
    this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
  });

  MovieModel copyWith({
    String? backdropPath,
    int? id,
    String? posterPath,
    String? releaseDate,
    String? title,
    double? voteAverage,
  }) {
    return MovieModel(
      backdropPath: backdropPath ?? this.backdropPath,
      id: id ?? this.id,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      title: title ?? this.title,
      voteAverage: voteAverage ?? this.voteAverage,
    );
  }

  factory MovieModel.empty() => MovieModel.fromJson({});

  factory MovieModel.fixture() => const MovieModel(
        id: 550,
        posterPath: null,
        releaseDate: '1999-10-15',
        title: 'Fight Club',
        voteAverage: 8.4,
      );

  static MovieModel fromJson(Map<String, dynamic> json) {
    return MovieModel(
      backdropPath: json['backdrop_path'],
      id: json['id'] ?? 0,
      posterPath: json['poster_path'],
      releaseDate: json['release_date'] ?? '',
      title: json['title'] ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'backdrop_path': backdropPath,
      'id': id,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'vote_average': voteAverage,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MovieModel &&
        other.backdropPath == backdropPath &&
        other.id == id &&
        other.posterPath == posterPath &&
        other.releaseDate == releaseDate &&
        other.title == title &&
        other.voteAverage == voteAverage;
  }

  @override
  int get hashCode {
    return backdropPath.hashCode ^
        id.hashCode ^
        posterPath.hashCode ^
        releaseDate.hashCode ^
        title.hashCode ^
        voteAverage.hashCode;
  }

  @override
  String toString() {
    return 'MovieModel(title: $title, id: $id)';
  }
}
