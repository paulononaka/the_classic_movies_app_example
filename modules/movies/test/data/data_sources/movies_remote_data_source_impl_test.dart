import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/data/data_sources/movies_remote_data_source_impl.dart';
import 'package:movies/pages/movie/models/movie.model.dart';
import 'package:movies/pages/movie/models/movies.model.dart';

import '../../helpers/mocks.dart';

void main() {
  group('MoviesRepository Tests', () {
    late MoviesRemoteDataSourceImpl repository;
    late DioMock mockDio;

    setUp(() {
      mockDio = DioMock();
      repository = MoviesRemoteDataSourceImpl(dio: mockDio, env: EnvMock());
    });

    test('fetchMovies should return movies from API when page is 1', () async {
      // Given
      final mockResponse = MoviesModel.fixture().copyWith(page: 1, results: List.generate(10, (index) => MovieModel.fixture().copyWith(id: index + 1))).toJson();

      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer((_) async => Response(
            data: mockResponse,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ));

      // When
      final result = await repository.fetchMovies(page: 1);

      // Then
      expect(result.page, equals(1));
      expect(result.results.length, equals(10));
      expect(result.totalPages, equals(10));
      expect(result.totalResults, equals(100));
      expect(result.results.first.id, equals(1));
      expect(result.results.last.id, equals(10));
      verify(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters'))).called(1);
    });

    test('fetchMovies should return second page of movies when page is 2', () async {
      // Given
      final mockResponse = MoviesModel.fixture().copyWith(page: 2, results: List.generate(10, (index) => MovieModel.fixture().copyWith(id: index + 11))).toJson();

      when(() => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer((_) async => Response(
            data: mockResponse,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ));

      // When
      final result = await repository.fetchMovies(page: 2);

      // Then
      expect(result.page, equals(2));
      expect(result.results.length, equals(10));
      expect(result.results.first.id, equals(11));
      expect(result.results.last.id, equals(20));
      verify(() => mockDio.get(
            any(),
            queryParameters: captureAny(named: 'queryParameters'),
          )).called(1);
    });

    test('fetchMovies should default to page 1 when no page is provided', () async {
      // Given
      final mockResponse = MoviesModel.fixture().copyWith(page: 1, results: List.generate(10, (index) => MovieModel.fixture().copyWith(id: index + 1))).toJson();

      when(() => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer((_) async => Response(
            data: mockResponse,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ));

      // When
      final result = await repository.fetchMovies();

      // Then
      expect(result.page, equals(1));
      expect(result.results.first.id, equals(1));
      expect(result.results.last.id, equals(10));
      verify(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters'))).called(1);
    });

    test('fetchMovies should throw exception when API call fails', () async {
      // Given
      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: ''), error: 'API error'));

      // When/Then
      expect(() => repository.fetchMovies(page: 1), throwsA(isA<Exception>()));
    });
  });
}
