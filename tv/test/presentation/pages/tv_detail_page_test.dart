import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../../dummy_data/tv_dummy_object.dart';

class MockTvDetailBloc extends MockBloc<TvShowsDetailEvent, TvShowsDetailState>
    implements TvShowsDetailBloc {}

class TvShowsDetailEventFake extends Fake implements TvShowsDetailEvent {}

class TvShowsDetailStateFake extends Fake implements TvShowsDetailState {}

class MockTvRecommendationsBloc
    extends MockBloc<TvShowsRecommendationsEvent, TvShowsRecommendationsState>
    implements TvShowsRecommendationsBloc {}

class TvShowsRecommendationsEventFake extends Fake
    implements TvShowsRecommendationsEvent {}

class TvShowsRecommendationsStateFake extends Fake
    implements TvShowsRecommendationsState {}

class MockWatchlistTvShowsBloc
    extends MockBloc<WatchlistTvShowsEvent, WatchlistTvShowsState>
    implements WatchlistTvShowsBloc {}

class WatchlistTvShowsEventFake extends Fake implements WatchlistTvShowsEvent {}

class WatchlistTvShowsStateFake extends Fake implements WatchlistTvShowsState {}

@GenerateMocks([TvShowsDetailBloc])
void main() {
  late MockTvDetailBloc mockTvDetailBloc;
  late MockTvRecommendationsBloc mockTvRecommendationsBloc;
  late MockWatchlistTvShowsBloc mockWatchlistTvShowsBloc;

  setUpAll(() {
    registerFallbackValue(TvShowsDetailEventFake());
    registerFallbackValue(TvShowsDetailStateFake());
    registerFallbackValue(TvShowsRecommendationsEventFake());
    registerFallbackValue(TvShowsRecommendationsStateFake());
    registerFallbackValue(WatchlistTvShowsEventFake());
    registerFallbackValue(WatchlistTvShowsStateFake());
  });

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
    mockTvRecommendationsBloc = MockTvRecommendationsBloc();
    mockWatchlistTvShowsBloc = MockWatchlistTvShowsBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvShowsDetailBloc>(create: (context) => mockTvDetailBloc),
        BlocProvider<TvShowsRecommendationsBloc>(
            create: (context) => mockTvRecommendationsBloc),
        BlocProvider<WatchlistTvShowsBloc>(
            create: (context) => mockWatchlistTvShowsBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvShowsDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvShowsRecommendationsHasData(testTvList));
    when(() => mockWatchlistTvShowsBloc.state)
        .thenReturn(const WatchlistTvShowsStatus(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvShowsDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvShowsRecommendationsHasData(testTvList));
    when(() => mockWatchlistTvShowsBloc.state).thenReturn(const WatchlistTvShowsStatus(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
