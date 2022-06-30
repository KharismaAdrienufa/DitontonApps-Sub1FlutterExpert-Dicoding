import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv_dummy_object.dart';

class MockWatchlistTvShowsBloc extends MockBloc<WatchlistTvShowsEvent, WatchlistTvShowsState> implements WatchlistTvShowsBloc {}

class WatchlistTvShowsEventFake extends Fake implements WatchlistTvShowsEvent {}

class WatchlistTvShowsStateFake extends Fake implements WatchlistTvShowsState {}

@GenerateMocks([WatchlistTvShowsBloc])
void main() {
  late MockWatchlistTvShowsBloc mockWatchlistTvShowsBloc;

  setUp(() {
    mockWatchlistTvShowsBloc = MockWatchlistTvShowsBloc();
  });

  setUpAll(() {
    registerFallbackValue(WatchlistTvShowsEventFake());
    registerFallbackValue(WatchlistTvShowsStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvShowsBloc>.value(
      value: mockWatchlistTvShowsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => mockWatchlistTvShowsBloc.state).thenReturn(WatchlistTvShowsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(() => mockWatchlistTvShowsBloc.state).thenReturn(WatchlistTvShowsHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(() => mockWatchlistTvShowsBloc.state).thenReturn(const WatchlistTvShowsError('error_message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
