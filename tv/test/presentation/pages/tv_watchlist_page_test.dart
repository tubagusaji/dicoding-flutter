
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc.dart';
import 'package:tv/presentation/pages/watchlist_tv_page.dart';

import '../../dummy_data/dummy_object.dart';

class MockTvWatchListBloc extends Mock implements TvWatchlistBloc{}
class TvWatchListEventFake extends Fake implements TvWatchlistEvent{}
class TvWatchListStateFake extends Fake implements TvWatchlistState{}

void main(){
  late TvWatchlistBloc tvWatchlistBloc;

  setUpAll((){
    registerFallbackValue(TvWatchListEventFake());
    registerFallbackValue(TvWatchListStateFake());
  });

  setUp((){
    tvWatchlistBloc = MockTvWatchListBloc();
  });

  Widget _makeTestableWidget(Widget body){
    return BlocProvider<TvWatchlistBloc>.value(value: tvWatchlistBloc,
    child: MaterialApp(home: body,),
    );
  }

  testWidgets("loading  diawal", (WidgetTester tester)async{
    when(()=> tvWatchlistBloc.stream).thenAnswer((_) => Stream.value(TvWatchListLoadingState()));
    when(()=> tvWatchlistBloc.state).thenReturn(TvWatchListLoadingState());

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));

    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("menampilkan list setelah berhasil mndapatkan data ", (WidgetTester tester)async{
    when(()=> tvWatchlistBloc.stream).thenAnswer((_) => Stream.value(TvWatchListLoadedState(tTvList)));
    when(()=> tvWatchlistBloc.state).thenReturn(TvWatchListLoadedState(tTvList));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets("menampilkan list setelah berhasil mndapatkan data ", (WidgetTester tester)async{
    when(()=> tvWatchlistBloc.stream).thenAnswer((_) => Stream.value(const TvWatchListErrorState("failed")));
    when(()=> tvWatchlistBloc.state).thenReturn(const TvWatchListErrorState("failed"));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));

    expect(find.byKey(Key('error_message')), findsOneWidget);
  });
}