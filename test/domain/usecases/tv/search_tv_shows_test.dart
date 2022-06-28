import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/search_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvShows usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTvShows(mockTvRepository);
  });

  final tTvShows = <Tv>[];
  final tQuery = 'The Boys';

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTvRepository.searchTvShows(tQuery))
        .thenAnswer((_) async => Right(tTvShows));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvShows));
  });
}
