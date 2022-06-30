import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../../dummy_data/tv_dummy_object.dart';
import 'recommendation_tv_shows_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late TvShowsRecommendationsBloc tvShowsRecommendationsBloc;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    tvShowsRecommendationsBloc = TvShowsRecommendationsBloc(mockGetTvRecommendations);
  });

  const id = 1;

  test('initial state should be empty', () {
    expect(tvShowsRecommendationsBloc.state, TvShowsRecommendationsEmpty());
  });

  blocTest<TvShowsRecommendationsBloc, TvShowsRecommendationsState>(
    'Should emit [TvRecommendationsLoading, TvRecommendationsHasData] when data is gotten successfully',
    build: () {
      when(mockGetTvRecommendations.execute(id)).thenAnswer((_) async => Right(testTvList));
      return tvShowsRecommendationsBloc;
    },
    act: (bloc) => bloc.add(const FetchTvShowsRecommendations(id)),
    expect: () => [
      TvShowsRecommendationsLoading(),
      TvShowsRecommendationsHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(id));
    },
  );

  blocTest<TvShowsRecommendationsBloc, TvShowsRecommendationsState>(
    'Should emit [TvRecommendationsLoading, TvRecommendationsError] when get data is unsuccessful',
    build: () {
      when(mockGetTvRecommendations.execute(id)).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvShowsRecommendationsBloc;
    },
    act: (bloc) => bloc.add(const FetchTvShowsRecommendations(id)),
    expect: () => [
      TvShowsRecommendationsLoading(),
      const TvShowsRecommendationsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(id));
    },
  );
}
