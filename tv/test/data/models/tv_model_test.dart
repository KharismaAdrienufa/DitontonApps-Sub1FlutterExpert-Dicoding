import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvModel(
      backdropPath: 'backdropPath',
      genreIds: const [1, 2],
      id: 1,
      name: 'name',
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      voteAverage: 1,
      voteCount: 1,
  );

  final tTv = Tv(
        backdropPath: 'backdropPath',
        genreIds: const [1, 2],
        id: 1,
        name: 'name',
        originalLanguage: 'originalLanguage',
        originalName: 'originalName',
        overview: 'overview',
        popularity: 1,
        posterPath: 'posterPath',
        voteAverage: 1,
        voteCount: 1,
  );

  test('should be a subclass of Tv entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
