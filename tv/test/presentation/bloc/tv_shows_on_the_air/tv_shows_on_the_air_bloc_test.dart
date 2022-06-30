import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../../dummy_data/tv_dummy_object.dart';
import 'tv_shows_on_the_air_bloc_test.mocks.dart';

@GenerateMocks([GetTvOnTheAir])
void main() {
  late TvShowsOnTheAirBloc tvShowsOnTheAirBloc;
  late MockGetTvOnTheAir mockGetTvOnTheAir;

  setUp(() {
    mockGetTvOnTheAir = MockGetTvOnTheAir();
    tvShowsOnTheAirBloc = TvShowsOnTheAirBloc(mockGetTvOnTheAir);
  });

  test('initial state should be empty', () {
    expect(tvShowsOnTheAirBloc.state, TvShowsOnTheAirEmpty());
  });

  blocTest<TvShowsOnTheAirBloc, TvShowsOnTheAirState>(
    'Should emit [TvShowsOnTheAirLoading, TvShowsOnTheAirHasData] when data is gotten successfully',
    build: () {
      when(mockGetTvOnTheAir.execute()).thenAnswer((_) async => Right(testTvList));
      return tvShowsOnTheAirBloc;
    },
    act: (bloc) => bloc.add(FetchTvShowsOnTheAir()),
    expect: () => [
      TvShowsOnTheAirLoading(),
      TvShowsOnTheAirHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTvOnTheAir.execute());
    },
  );

  blocTest<TvShowsOnTheAirBloc, TvShowsOnTheAirState>(
    'Should emit [OnTheAirTvsLoading, OnTheAirTvsError] when get data is unsuccessful',
    build: () {
      when(mockGetTvOnTheAir.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvShowsOnTheAirBloc;
    },
    act: (bloc) => bloc.add(FetchTvShowsOnTheAir()),
    expect: () => [
      TvShowsOnTheAirLoading(),
      const TvShowsOnTheAirError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvOnTheAir.execute());
    },
  );
}
