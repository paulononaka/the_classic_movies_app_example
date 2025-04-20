class MovieDetailModel {
  final bool adult;
  final int id;
  final String title;
  final String originalTitle;
  final String backdropPath;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final int runtime;
  final double voteAverage;
  final int voteCount;
  final List<Genre> genres;
  final String status;
  final String tagline;
  final List<ProductionCompany> productionCompanies;

  const MovieDetailModel({
    required this.adult,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.backdropPath,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.runtime,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,
    required this.status,
    required this.tagline,
    required this.productionCompanies,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      adult: json['adult'] ?? false,
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      originalTitle: json['original_title'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      posterPath: json['poster_path'] ?? '',
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      runtime: json['runtime'] ?? 0,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
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
      adult: false,
      id: 0,
      title: '',
      originalTitle: '',
      backdropPath: '',
      posterPath: '',
      overview: '',
      releaseDate: '',
      runtime: 0,
      voteAverage: 0.0,
      voteCount: 0,
      genres: [],
      status: '',
      tagline: '',
      productionCompanies: [],
    );
  }

  factory MovieDetailModel.fixture() {
    return MovieDetailModel(
      adult: false,
      id: 1197306,
      title: 'A Working Man',
      originalTitle: 'A Working Man',
      backdropPath: '',
      posterPath: '',
      overview:
          'Levon Cade left behind a decorated military career in the black ops to live a simple life working construction. But when his boss\'s daughter, who is like family to him, is taken by human traffickers, his search to bring her home uncovers a world of corruption far greater than he ever could have imagined.',
      releaseDate: '2025-03-26',
      runtime: 116,
      voteAverage: 6.271,
      voteCount: 321,
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

class Genre {
  final int id;
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

class ProductionCompany {
  final int id;
  final String name;
  final String logoPath;
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
