import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:movie/movie.dart';
import 'package:mocktail/src/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockDetailMovieBloc extends MockBloc<DetailMovieEvent, DetailMovieState> implements DetailMovieBloc {}

class DetailMovieEventFake extends Fake implements DetailMovieEvent {}

class DetailMovieStateFake extends Fake implements DetailMovieState {}

class MockRecommendationMoviesBloc extends MockBloc<RecommendationsMovieEvent, RecommendationsMovieState>
    implements RecommendationsMovieBloc {}

class RecommendationMoviesEventFake extends Fake implements RecommendationsMovieEvent {}

class RecommendationMoviesStateFake extends Fake implements RecommendationsMovieState {}

class MockWatchlistMoviesBloc extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}

class WatchlistMoviesEventFake extends Fake implements WatchlistMovieEvent {}

class WatchlistMoviesStateFake extends Fake implements WatchlistMovieState {}

@GenerateMocks([DetailMovieBloc])
void main() {
  late MockDetailMovieBloc mockDetailMovieBloc;
  late MockRecommendationMoviesBloc mockRecommendationMoviesBloc;
  late MockWatchlistMoviesBloc mockWatchlistMoviesBloc;

  setUpAll(() {
    registerFallbackValue(DetailMovieEventFake());
    registerFallbackValue(DetailMovieStateFake());
    registerFallbackValue(RecommendationMoviesEventFake());
    registerFallbackValue(RecommendationMoviesStateFake());
    registerFallbackValue(WatchlistMoviesEventFake());
    registerFallbackValue(WatchlistMoviesStateFake());
  });

  setUp(() {
    mockDetailMovieBloc = MockDetailMovieBloc();
    mockRecommendationMoviesBloc = MockRecommendationMoviesBloc();
    mockWatchlistMoviesBloc = MockWatchlistMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailMovieBloc>(create: (context) => mockDetailMovieBloc),
        BlocProvider<RecommendationsMovieBloc>(create: (context) => mockRecommendationMoviesBloc),
        BlocProvider<WatchlistMovieBloc>(create: (context) => mockWatchlistMoviesBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Watchlist button should display add icon when Movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailMovieBloc.state).thenReturn(DetailMovieHasData(testMovieDetail));
    when(() => mockRecommendationMoviesBloc.state).thenReturn(RecommendationsMovieHasData(testMovieList));
    when(() => mockWatchlistMoviesBloc.state).thenReturn(WatchlistStatus(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('Watchlist button should dispay check icon when Movie is added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailMovieBloc.state).thenReturn(DetailMovieHasData(testMovieDetail));
    when(() => mockRecommendationMoviesBloc.state).thenReturn(RecommendationsMovieHasData(testMovieList));
    when(() => mockWatchlistMoviesBloc.state).thenReturn(WatchlistStatus(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
