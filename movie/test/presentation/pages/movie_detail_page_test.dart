import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_recommendations_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

class MockMovieRecommendationsBloc
    extends MockBloc<MovieRecommendationsEvent, MovieRecommendationsState>
    implements MovieRecommendationsBloc {}

class MovieRecommendationsEventFake extends Fake
    implements MovieRecommendationsEvent {}

class MovieRecommendationsStateFake extends Fake
    implements MovieRecommendationsState {}

class MockWatchlistMovieBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}

class WatchlistMovieBlocEventFake extends Fake implements WatchlistMovieEvent {}

class WatchlistMovieBlocStateFake extends Fake implements WatchlistMovieState {}

void main() {
  late MockMovieDetailBloc mockDetailBloc;
  late MockMovieRecommendationsBloc mockMovieRecommendationsBloc;
  late MockWatchlistMovieBloc mockWatchlistMovieBloc;

  setUpAll(() {
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieDetailStateFake());
    registerFallbackValue(MovieRecommendationsEventFake());
    registerFallbackValue(MovieRecommendationsStateFake());
    registerFallbackValue(WatchlistMovieBlocEventFake());
    registerFallbackValue(WatchlistMovieBlocStateFake());
  });

  setUp(() {
    mockDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationsBloc = MockMovieRecommendationsBloc();
    mockWatchlistMovieBloc = MockWatchlistMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MovieDetailBloc>(create: (context) => mockDetailBloc),
          BlocProvider<MovieRecommendationsBloc>(
              create: (context) => mockMovieRecommendationsBloc),
          BlocProvider<WatchlistMovieBloc>(
              create: (context) => mockWatchlistMovieBloc)
        ],
        child: MaterialApp(
          home: body,
        ));
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailBloc.state)
        .thenReturn(MovieDetailLoadedState(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(const MovieRecommendationsLoadedState(<Movie>[]));
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(const LoadWatchListStatusState(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockDetailBloc.state)
        .thenReturn(MovieDetailLoadedState(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(const MovieRecommendationsLoadedState(<Movie>[]));
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(const LoadWatchListStatusState(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    whenListen(
        mockWatchlistMovieBloc,
        Stream<WatchlistMovieState>.fromIterable([
          WatchlistMovieInitial(),
          LoadWatchListStatusState(false),
          WatchListStatusSuccessMessageState('Added to Watchlist')
        ]));
    when(() => mockDetailBloc.state)
        .thenReturn(MovieDetailLoadedState(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(const MovieRecommendationsLoadedState(<Movie>[]));
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(const LoadWatchListStatusState(false));

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    final watchlistButton = find.byType(ElevatedButton);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    whenListen(
        mockWatchlistMovieBloc,
        Stream<WatchlistMovieState>.fromIterable([
          WatchlistMovieInitial(),
          LoadWatchListStatusState(false),
          WatchListStatusErrorMessageState('Failed')
        ]));
    when(() => mockDetailBloc.state)
        .thenReturn(MovieDetailLoadedState(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(const MovieRecommendationsLoadedState(<Movie>[]));
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(const LoadWatchListStatusState(false));

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    final watchlistButton = find.byType(ElevatedButton);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
