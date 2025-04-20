import 'package:hive/hive.dart';

part 'movie_detail.model.g.dart';

@HiveType(typeId: 2)
class MovieDetailModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String backdropPath;
  @HiveField(3)
  final String posterPath;
  @HiveField(4)
  final String overview;
  @HiveField(5)
  final String releaseDate;
  @HiveField(6)
  final int runtime;
  @HiveField(7)
  final double voteAverage;
  @HiveField(8)
  final List<Genre> genres;
  @HiveField(9)
  final String status;
  @HiveField(10)
  final String tagline;
  @HiveField(11)
  final List<ProductionCompany> productionCompanies;

  const MovieDetailModel({
    required this.id,
    required this.title,
    required this.backdropPath,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.runtime,
    required this.voteAverage,
    required this.genres,
    required this.status,
    required this.tagline,
    required this.productionCompanies,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      posterPath: json['poster_path'] ?? '',
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      runtime: json['runtime'] ?? 0,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      genres: (json['genres'] as List<dynamic>?)?.map((e) => Genre.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      status: json['status'] ?? '',
      tagline: json['tagline'] ?? '',
      productionCompanies: (json['production_companies'] as List<dynamic>?)?.map((e) => ProductionCompany.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  String get genreNames {
    return genres.map((genre) => genre.name).join(', ');
  }

  factory MovieDetailModel.empty() {
    return const MovieDetailModel(
      id: 0,
      title: '',
      backdropPath: '',
      posterPath: '',
      overview: '',
      releaseDate: '',
      runtime: 0,
      voteAverage: 0.0,
      genres: [],
      status: '',
      tagline: '',
      productionCompanies: [],
    );
  }

  factory MovieDetailModel.fixture() {
    return MovieDetailModel(
      id: 1197306,
      title: 'A Working Man',
      backdropPath: '',
      posterPath: '',
      overview:
          'Levon Cade left behind a decorated military career in the black ops to live a simple life working construction. But when his boss\'s daughter, who is like family to him, is taken by human traffickers, his search to bring her home uncovers a world of corruption far greater than he ever could have imagined.',
      releaseDate: '2025-03-26',
      runtime: 116,
      voteAverage: 6.271,
      genres: [
        Genre(id: 28, name: 'Action'),
        Genre(id: 80, name: 'Crime'),
        Genre(id: 53, name: 'Thriller'),
      ],
      status: 'Released',
      tagline: 'Human traffickers beware.',
      productionCompanies: [
        ProductionCompany(
          id: 118475,
          name: 'Cedar Park Entertainment',
          logoPath: '',
          originCountry: 'US',
        ),
        ProductionCompany(
          id: 219295,
          name: 'BlockFilm',
          logoPath: '',
          originCountry: 'US',
        ),
      ],
    );
  }
}

@HiveType(typeId: 3)
class Genre {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

@HiveType(typeId: 4)
class ProductionCompany {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String logoPath;
  @HiveField(3)
  final String originCountry;

  ProductionCompany({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      logoPath: json['logo_path'] ?? '',
      originCountry: json['origin_country'] ?? '',
    );
  }
}
