import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/tv_popular_bloc.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';


class MockPopularTvBloc extends Mock implements TvPopularBloc{}
class TvPopularEventFake extends Fake implements TvPopularEvent{}
class TvPopularStateFake extends Fake implements TvPopularState{}

void main() {
  late TvPopularBloc tvPopularBloc;

  setUpAll((){
    registerFallbackValue(TvPopularEventFake());
    registerFallbackValue(TvPopularStateFake());
  });

  setUp(() {
    tvPopularBloc = MockPopularTvBloc();
  });

  Widget _makeTesttableWidget(Widget body) {
    return BlocProvider<TvPopularBloc>.value(
      value: tvPopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      "seharusnya halaman menampilkan loading ketika sedang mendapatkan data",
      (WidgetTester tester) async {
    when(()=>tvPopularBloc.stream).thenAnswer((_) => Stream.value(TvPopularLoadingState()));
    when(()=>tvPopularBloc.state).thenReturn(TvPopularLoadingState());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFind = find.byType(Center);

    await tester.pumpWidget(_makeTesttableWidget(PopularTvPage()));

    expect(centerFind, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      "seharusnya halaman menampilkan data list tv popular ketika berhasil mendapatkan data",
      (WidgetTester tester) async {
    when(()=>tvPopularBloc.stream).thenAnswer((_) => Stream.value(TvPopularLoadedState(const <Tv>[])));
    when(()=>tvPopularBloc.state).thenReturn(TvPopularLoadedState(const <Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTesttableWidget(PopularTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets(
      "seharusnya menampilkan pesan error ketika gagal mendapatkan data",
      (WidgetTester tester) async {
        when(()=>tvPopularBloc.stream).thenAnswer((_) => Stream.value(TvPopularErrorState("Error Message")));
        when(()=>tvPopularBloc.state).thenReturn(TvPopularErrorState("Error Message"));


    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTesttableWidget(PopularTvPage()));
    expect(textFinder, findsOneWidget);
  });
}
