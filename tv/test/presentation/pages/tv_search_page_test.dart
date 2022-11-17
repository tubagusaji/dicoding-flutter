
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_search_bloc.dart';

class MockTvSearchBloc extends Mock implements TvSearchBloc{}
class TvSearchEventFake extends Fake implements TvSearchEvent{}
class TvSearchStateFake extends Fake implements TvSearchState{}


void main(){
  late TvSearchBloc tvSearchBloc;

  setUpAll((){
    registerFallbackValue(TvSearchEventFake());
    registerFallbackValue(TvSearchStateFake());
  });

  setUp((){
    tvSearchBloc = MockTvSearchBloc();
  });

  Widget _testableWidget(Widget body){
    return BlocProvider<TvSearchBloc>.value(value: tvSearchBloc,
    child: MaterialApp(
      home: body,
    ),
    );
  }


  // testWidgets("menampilkan loading ketika mulai mencari", (WidgetTester tester)async{
  //   when(() => tvSearchBloc.stream).thenAnswer((_) => Stream.value(TvSearchLoadingState()));
  //   when(()=> tvSearchBloc.state).thenReturn(TvSearchLoadingState());
  //
  //   final progressBarFinder = find.byType(CircularProgressIndicator);
  //   final centerFind = find.byType(Center);
  //
  //   await tester.pumpWidget(_testableWidget(SearchTvPage()));
  //
  //   await tester.enterText(find.byType(TextField), 'House of the Dragon');
  //   await tester.pump();
  //
  //   expect(centerFind, findsOneWidget);
  //   expect(progressBarFinder, findsOneWidget);
  // });
}