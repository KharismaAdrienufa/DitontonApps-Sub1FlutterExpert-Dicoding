import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'recommendations_movie_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late RecommendationsMovieBloc recommendationsMovieBloc;
  late MockGetMovieRecommendations mockGetRecommendationMovies;

  setUp(() {
    mockGetRecommendationMovies = MockGetMovieRecommendations();
    recommendationsMovieBloc = RecommendationsMovieBloc(mockGetRecommendationMovies);
  });

  const id = 1;

  test('initial state should be empty', () {
    expect(recommendationsMovieBloc.state, RecommendationsMovieEmpty());
  });

  blocTest<RecommendationsMovieBloc, RecommendationsMovieState>(
    'Should emit [RecommendationsMovieLoading, RecommendationsMovieHasData] when data is gotten successfully',
    build: () {
      when(mockGetRecommendationMovies.execute(id)).thenAnswer((_) async => Right(testMovieList));
      return recommendationsMovieBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationsMovies(id)),
    expect: () => [
      RecommendationsMovieLoading(),
      RecommendationsMovieHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationMovies.execute(id));
    },
  );

  blocTest<RecommendationsMovieBloc, RecommendationsMovieState>(
    'Should emit [RecommendationsMovieLoading, RecommendationsMovieError] when get data is unsuccessful',
    build: () {
      when(mockGetRecommendationMovies.execute(id)).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return recommendationsMovieBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationsMovies(id)),
    expect: () => [
      RecommendationsMovieLoading(),
      const RecommendationsMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationMovies.execute(id));
    },
  );
}
