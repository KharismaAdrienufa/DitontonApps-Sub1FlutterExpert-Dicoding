import 'dart:convert';
import 'dart:io';
import 'package:ditonton/data/datasources/tv/tv_remote_data_source.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv/tv_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';
import '../../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Tv On The Air', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv/tv_on_the_air.json')))
        .TvList;

    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv/tv_on_the_air.json'), 200));
      // act
      final result = await dataSource.getTvOnTheAirApi();
      // assert
      expect(result, equals(tTvList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvOnTheAirApi();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tv Shows', () {
    final tTvList =
        TvResponse.fromJson(json.decode(readJson('dummy_data/tv/tv_popular.json')))
            .TvList;

    test('should return list of tv when response is success 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv/tv_popular.json'), 200));
      // act
      final result = await dataSource.getPopularTvShowsApi();
      // assert
      expect(result, equals(tTvList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTvShowsApi();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tv Shows', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv/tv_top_rated.json')))
        .TvList;

    test('should return list of tv when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv/tv_top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTvShowsApi();
      // assert
      expect(result, equals(tTvList));
    });

    test('should throw ServerException when response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTvShowsApi();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv detail', () {
    final tId = 1;
    final tTvDetail = TvDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv/tv_detail.json')));

    test('should return tv detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv/tv_detail.json'), 200, headers: {HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"}));
      // act
      final result = await dataSource.getTvDetailApi(tId);
      // assert
      expect(result, equals(tTvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvDetailApi(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv/tv_recommendations.json')))
        .TvList;
    final tId = 1;

    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv/tv_recommendations.json'), 200));
      // act
      final result = await dataSource.getTvRecommendationsApi(tId);
      // assert
      expect(result, equals(tTvList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvRecommendationsApi(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv shows', () {
    final tSearchResult = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv/search_the_boys_tv.json')))
        .TvList;
    final tQuery = 'The Boys';

    test('should return list of tv when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv/search_the_boys_tv.json'), 200));
      // act
      final result = await dataSource.searchTvShowsApi(tQuery);
      // assert
      expect(result, equals(tSearchResult));
    });

    test('should throw ServerException when response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTvShowsApi(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
