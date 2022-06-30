import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_movie_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMovieBloc res;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    res = TopRatedMovieBloc(mockGetTopRatedMovies);
  });

  test('initial state should be empty', () {
    expect(res.state, TopRatedMovieEmpty());
  });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'Should emit [TopRatedMovieLoading, TopRatedMovieHasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Right(testMovieList));
      return res;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'Should emit [TopRatedMovieLoading, TopRatedMovieError] when get data is unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return res;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
