import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistMoviesBloc extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}

class WatchlistMoviesEventFake extends Fake implements WatchlistMovieEvent {}

class WatchlistMoviesStateFake extends Fake implements WatchlistMovieState {}

@GenerateMocks([WatchlistMovieBloc])
void main() {
  late MockWatchlistMoviesBloc mockWatchlistMoviesBloc;

  setUp(() {
    mockWatchlistMoviesBloc = MockWatchlistMoviesBloc();
  });

  setUpAll(() {
    registerFallbackValue(WatchlistMoviesEventFake());
    registerFallbackValue(WatchlistMoviesStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMovieBloc>.value(
      value: mockWatchlistMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => mockWatchlistMoviesBloc.state).thenReturn(WatchlistMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(() => mockWatchlistMoviesBloc.state).thenReturn(WatchlistMovieHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(() => mockWatchlistMoviesBloc.state).thenReturn(const WatchlistMovieError('error_message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
