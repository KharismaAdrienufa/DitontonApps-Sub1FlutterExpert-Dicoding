import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMovieBloc popularMovieBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieBloc = PopularMovieBloc(mockGetPopularMovies);
  });

  test('initial state should be empty', () {
    expect(popularMovieBloc.state, PopularMovieEmpty());
  });

  blocTest<PopularMovieBloc, PopularMovieState>(
    'Should emit [PopularMovieLoading, PopularMovieHasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer((_) async => Right(testMovieList));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'Should emit [PopularMovieLoading, PopularMovieError] when get data is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );
}
