import 'dart:convert';

import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath: '/path.jpg',
    genreIds: [1, 2],
    id: 1,
    name: 'The Boys',
    originalLanguage: 'en',
    originalName: 'The Boys',
    overview: 'overview',
    popularity: 1,
    posterPath: '/path.jpg',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvResponseModel = TvResponse(TvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv/tv_on_the_air.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            'backdrop_path': '/path.jpg',
            'genre_ids': [1, 2],
            'id': 1,
            'name': 'The Boys',
            'original_language': 'en',
            'original_name': 'The Boys',
            'overview': 'overview',
            'popularity': 1.0,
            'poster_path': '/path.jpg',
            'vote_average': 1,
            'vote_count': 1,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
