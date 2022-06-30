import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late GetTvOnTheAir usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvOnTheAir(mockTvRepository);
  });

  final tTvShows = <Tv>[];

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTvRepository.getTvOnTheAir())
        .thenAnswer((_) async => Right(tTvShows));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvShows));
  });
}