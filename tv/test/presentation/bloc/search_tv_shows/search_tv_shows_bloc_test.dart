import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import 'package:dartz/dartz.dart';

import 'search_tv_shows_bloc_test.mocks.dart';

final tTvModel = Tv(
  backdropPath: '/path.jpg',
  genreIds: const [1],
  id: 1,
  name: 'name',
  originalLanguage: 'en',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.0,
  posterPath: '/path.jpg',
  voteAverage: 1.0,
  voteCount: 1,
);

final tTvList = <Tv>[tTvModel];
const tQuery = 'Moon Knight';

@GenerateMocks([SearchTvShows])
void main() {
  late TvShowsSearchBloc tvShowsSearchBloc;
  late MockSearchTvShows mockTvSearch;

  setUp(() {
    mockTvSearch = MockSearchTvShows();
    tvShowsSearchBloc = TvShowsSearchBloc(mockTvSearch);
  });

  test('initial state should be empty', () {
    expect(tvShowsSearchBloc.state, TvShowsSearchEmpty());
  });

  blocTest<TvShowsSearchBloc, TvShowsSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockTvSearch.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return tvShowsSearchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowsSearchLoading(),
      TvShowsSearchHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockTvSearch.execute(tQuery));
    },
  );

  blocTest<TvShowsSearchBloc, TvShowsSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockTvSearch.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvShowsSearchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowsSearchLoading(),
      const TvShowsSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockTvSearch.execute(tQuery));
    },
  );
}
