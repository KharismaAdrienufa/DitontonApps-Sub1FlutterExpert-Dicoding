import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies, SaveWatchlist, RemoveWatchlist, GetWatchListStatus])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockGetWatchListStatus mockGetWatchListStatus;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetWatchListStatus = MockGetWatchListStatus();
    watchlistMovieBloc = WatchlistMovieBloc(
      mockGetWatchlistMovies,
      mockSaveWatchlist,
      mockRemoveWatchlist,
      mockGetWatchListStatus,
    );
  });

  test('initial state should be empty', () {
    expect(watchlistMovieBloc.state, WatchlistMovieEmpty());
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [WatchlistMovieLoading, WatchlistMovieHasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer((_) async => Right(testMovieList));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [WatchlistMovieLoading, WatchlistMovieError] when get data is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    expect: () => [
      WatchlistMovieLoading(),
      const WatchlistMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}
