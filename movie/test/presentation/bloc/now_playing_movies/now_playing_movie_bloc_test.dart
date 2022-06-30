import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'now_playing_movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMovieBloc nowPlayingMovieBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMovieBloc = NowPlayingMovieBloc(mockGetNowPlayingMovies);
  });

  test('initial state should be empty', () {
    expect(nowPlayingMovieBloc.state, NowPlayingMovieEmpty());
  });

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
    'Should emit [NowPlayingMovieLoading, NowPlayingMovieHasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer((_) async => Right(testMovieList));
      return nowPlayingMovieBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    expect: () => [
      NowPlayingMovieLoading(),
      NowPlayingMovieHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
    'Should emit [NowPlayingMovieLoading, NowPlayingMovieError] when get data is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingMovieBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    expect: () => [
      NowPlayingMovieLoading(),
      const NowPlayingMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}
