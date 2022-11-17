import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

import '../../dummy_data/dummy_object.dart';

class MockTvDetailBloc extends Mock implements TvDetailBloc{}
class TvDetailEventFake extends Fake implements TvDetailEvent{}
class TvDetailStateFake extends Fake implements TvDetailState{}

void main() {
  late TvDetailBloc tvDetailBloc;
  final tvDetailStateInit = TvDetailState.initial();

  setUpAll((){
    registerFallbackValue(TvDetailEventFake);
    registerFallbackValue(TvDetailStateFake);
  });

  setUp(() {
    tvDetailBloc = MockTvDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvDetailBloc>.value(
      value: tvDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(()=>tvDetailBloc.stream).thenAnswer((_) => Stream.value(
      tvDetailStateInit.copyWith(
       tvDetailState: RequestState.Loaded,
        tvRecommendationsState: RequestState.Loaded,
        isInTvWatchList: false
      )
    ));
    when(()=>tvDetailBloc.state).thenReturn(tvDetailStateInit.copyWith(
      tvDetailState: RequestState.Loaded,
      tvRecommendationsState: RequestState.Loaded,
      isInTvWatchList: false
    ));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1399)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
        when(()=>tvDetailBloc.stream).thenAnswer((_) => Stream.value(
            tvDetailStateInit.copyWith(
                tvDetailState: RequestState.Loaded,
                tvRecommendationsState: RequestState.Loaded,
                isInTvWatchList: true
            )
        ));
        when(()=>tvDetailBloc.state).thenReturn(tvDetailStateInit.copyWith(
            tvDetailState: RequestState.Loaded,
            tvRecommendationsState: RequestState.Loaded,
            isInTvWatchList: true
        ));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1399)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
        whenListen(tvDetailBloc, Stream.value(tvDetailStateInit.copyWith(
          tvDetailState: RequestState.Loaded,
          tvDetail: testTvDetail,
          tvRecommendationsState: RequestState.Loaded,
          tvRecommendations: <Tv>[],
          isInTvWatchList: true,
          tvWatchlistMessage: 'Added Tv to Watchlist'
        )));
        when(()=>tvDetailBloc.state).thenReturn(tvDetailStateInit.copyWith(
          tvDetail: testTvDetail,
          tvDetailState: RequestState.Loaded,
          tvRecommendationsState: RequestState.Loaded
        ));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1399)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added Tv to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
        whenListen(tvDetailBloc, Stream.value(tvDetailStateInit.copyWith(
            tvDetailState: RequestState.Loaded,
            tvDetail: testTvDetail,
            tvRecommendationsState: RequestState.Loaded,
            tvRecommendations: <Tv>[],
            tvWatchlistMessage: 'Failed'
        )));
        when(()=>tvDetailBloc.state).thenReturn(tvDetailStateInit.copyWith(
            tvDetail: testTvDetail,
            tvDetailState: RequestState.Loaded,
            tvRecommendationsState: RequestState.Loaded
        ));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1399)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
