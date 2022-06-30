import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../../dummy_data/tv_dummy_object.dart';
import 'watchlist_tv_shows_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTvShows,
  SaveTvWatchlist,
  RemoveTvWatchlist,
  GetWatchlistTvStatus
])
void main() { 
  late WatchlistTvShowsBloc watchlistTvShowsBloc;
  late MockGetWatchlistTvShows mockGetWatchlistTvShows;
  late MockSaveTvWatchlist mockSaveTvWatchlist;
  late MockRemoveTvWatchlist mockRemoveTvWatchlist;
  late MockGetWatchListTvStatus mockGetWatchListTvStatus;

  setUp(() {
    mockGetWatchlistTvShows = MockGetWatchlistTvShows();
    mockSaveTvWatchlist = MockSaveTvWatchlist();
    mockRemoveTvWatchlist = MockRemoveTvWatchlist();
    mockGetWatchListTvStatus = MockGetWatchListTvStatus();
    watchlistTvShowsBloc = WatchlistTvShowsBloc(
      mockGetWatchlistTvShows,
      mockSaveTvWatchlist,
      mockRemoveTvWatchlist,
      mockGetWatchListTvStatus,
    );
  });

  test('initial state should be empty', () {
    expect(watchlistTvShowsBloc.state, WatchlistTvShowsEmpty());
  });

  blocTest<WatchlistTvShowsBloc, WatchlistTvShowsState>(
    'Should emit [WatchlistTvShowsLoading, WatchlistTvShowsHasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => Right(testTvList));
      return watchlistTvShowsBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvShows()),
    expect: () => [
      WatchlistTvShowsLoading(),
      WatchlistTvShowsHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvShows.execute());
    },
  );

  blocTest<WatchlistTvShowsBloc, WatchlistTvShowsState>(
    'Should emit [WatchlistTvShowsLoading, WatchlistTvShowsError] when get data is unsuccessful',
    build: () {
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return watchlistTvShowsBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvShows()),
    expect: () => [
      WatchlistTvShowsLoading(),
      const WatchlistTvShowsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvShows.execute());
    },
  );
}
