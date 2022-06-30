import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../../dummy_data/tv_dummy_object.dart';
import 'tv_shows_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late TvShowsDetailBloc tvShowsDetailBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvShowsDetailBloc = TvShowsDetailBloc(mockGetTvDetail);
  });

  const int id = 1;

  test('initial state should be empty', () {
    expect(tvShowsDetailBloc.state, TvShowsDetailEmpty());
  });

  blocTest<TvShowsDetailBloc, TvShowsDetailState>(
    'Should emit [TvShowsDetailLoading, TvShowsDetailHasData] when data is gotten successfully',
    build: () {
      when(mockGetTvDetail.execute(id)).thenAnswer((_) async => Right(testTvDetail));
      return tvShowsDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTvShowsDetail(id)),
    expect: () => [
      TvShowsDetailLoading(),
      TvShowsDetailHasData(testTvDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(id));
    },
  );

  blocTest<TvShowsDetailBloc, TvShowsDetailState>(
    'Should emit [TvShowsDetailLoading, TvShowsDetailError] when get data is unsuccessful',
    build: () {
      when(mockGetTvDetail.execute(id)).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowsDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTvShowsDetail(id)),
    expect: () => [
      TvShowsDetailLoading(),
      TvShowsDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(id));
    },
  );
}
