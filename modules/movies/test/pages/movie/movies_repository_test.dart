import 'package:flutter_test/flutter_test.dart';
import 'package:movies/pages/movie/movies.repository.dart';

void main() {
  group('MoviesRepository Tests', () {
    late MoviesRepository repository;

    setUp(() {
      repository = const MoviesRepository();
    });

    test('fetchMovies should return first page of movies when page is 1', () async {
      // When
      final result = await repository.fetchMovies(page: 1);

      // Then
      expect(result.page, equals(1));
      expect(result.results.length, equals(10));
      expect(result.totalPages, equals(10));
      expect(result.totalResults, equals(100));
      expect(result.results.first.id, equals(1));
      expect(result.results.last.id, equals(10));
    });

    test('fetchMovies should return second page of movies when page is 2', () async {
      // When
      final result = await repository.fetchMovies(page: 2);

      // Then
      expect(result.page, equals(2));
      expect(result.results.length, equals(10));
      expect(result.results.first.id, equals(11));
      expect(result.results.last.id, equals(20));
    });

    test('fetchMovies should default to page 1 when no page is provided', () async {
      // When
      final result = await repository.fetchMovies();

      // Then
      expect(result.page, equals(1));
      expect(result.results.first.id, equals(1));
      expect(result.results.last.id, equals(10));
    });
  });
}
