import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_now_playing_bloc.dart';
import 'package:tv/presentation/pages/now_playing_tv_page.dart';

import '../../dummy_data/dummy_object.dart';

class MockTvNowPlayingBloc extends Mock implements TvNowPlayingBloc{}
class TvNowPlayingEventFake extends Fake implements TvNowPlayingEvent{}
class TvNowPlayingStateFake extends Fake implements TvNowPlayingState{}

void main() {
  late TvNowPlayingBloc tvNowPlayingBloc;

  setUpAll((){
    registerFallbackValue(TvNowPlayingEventFake());
    registerFallbackValue(TvNowPlayingStateFake());
  });

  setUp(() {
   tvNowPlayingBloc = MockTvNowPlayingBloc();
  });

  Widget _makeTesttableWidget(Widget body) {
    return BlocProvider<TvNowPlayingBloc>.value(
      value: tvNowPlayingBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      "seharusnya halaman menampilkan loading ketika sedang mendapatkan data",
      (WidgetTester tester) async {
        when(()=> tvNowPlayingBloc.stream).thenAnswer((_) => Stream.value(TvNowPlayingLoadingState()));
        when(()=>tvNowPlayingBloc.state).thenReturn(TvNowPlayingLoadingState());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFind = find.byType(Center);

    await tester.pumpWidget(_makeTesttableWidget(NowPlayingTvPage()));

    expect(centerFind, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      "seharusnya halaman menampilkan data list tv on air ketika berhasil mendapatkan data",
      (WidgetTester tester) async {
        when(()=> tvNowPlayingBloc.stream).thenAnswer((_) => Stream.value(TvNowPlayingLoadedState(tTvList)));
        when(()=>tvNowPlayingBloc.state).thenReturn(TvNowPlayingLoadedState(tTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTesttableWidget(NowPlayingTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets(
      "seharusnya menampilkan pesan error ketika gagal mendapatkan data",
      (WidgetTester tester) async {
        when(()=> tvNowPlayingBloc.stream).thenAnswer((_) => Stream.value(const TvNowPlayingErrorState("Error Message")));
        when(()=>tvNowPlayingBloc.state).thenReturn(const TvNowPlayingErrorState("Error Message"));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTesttableWidget(NowPlayingTvPage()));
    expect(textFinder, findsOneWidget);
  });
}
