import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/tv_top_rated_bloc.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';

class MockTvTopRatedBloc extends Mock implements TvTopRatedBloc{}
class TvTopRatedEventFake extends Fake implements TvTopRatedEvent{}
class TvTopRatedSateFake extends Fake implements TvTopRatedState{}

void main() {
  late TvTopRatedBloc tvTopRatedBloc;

  setUpAll((){
    registerFallbackValue(TvTopRatedEventFake());
    registerFallbackValue(TvTopRatedSateFake());
  });

  setUp(() {
    tvTopRatedBloc = MockTvTopRatedBloc();
  });

  Widget _makeTesttableWidget(Widget body) {
    return BlocProvider<TvTopRatedBloc>.value(
      value: tvTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      "seharusnya halaman menampilkan loading ketika sedang mendapatkan data",
      (WidgetTester tester) async {
        when(()=>tvTopRatedBloc.stream).thenAnswer((_) => Stream.value(TvTopRatedLoadingState()));
        when(()=>tvTopRatedBloc.state).thenReturn(TvTopRatedLoadingState());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFind = find.byType(Center);

    await tester.pumpWidget(_makeTesttableWidget(TopRatedTvPage()));

    expect(centerFind, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      "seharusnya halaman menampilkan data list tv top rated ketika berhasil mendapatkan data",
      (WidgetTester tester) async {
    when(()=>tvTopRatedBloc.stream).thenAnswer((_) => Stream.value(const TvTopRatedLoadedState(<Tv>[])));
    when(()=>tvTopRatedBloc.state).thenReturn(const TvTopRatedLoadedState(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTesttableWidget(TopRatedTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets(
      "seharusnya menampilkan pesan error ketika gagal mendapatkan data",
      (WidgetTester tester) async {

    when(()=>tvTopRatedBloc.stream).thenAnswer((_) => Stream.value(const TvTopRatedErrorState("Error Message")));
    when(()=>tvTopRatedBloc.state).thenReturn(const TvTopRatedErrorState("Error Message"));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTesttableWidget(TopRatedTvPage()));
    expect(textFinder, findsOneWidget);
  });
}
