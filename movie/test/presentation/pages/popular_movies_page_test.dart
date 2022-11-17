import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/movie_popular_bloc.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';

class MockMoviePopularBloc extends MockBloc<MoviePopularEvent, MoviePopularState> implements MoviePopularBloc{}
class MoviePopularEventFake extends Fake implements MoviePopularEvent{}
class MoviePopularStateFake extends Fake implements MoviePopularState{}

void main() {
  late MockMoviePopularBloc mockMoviePopularBloc;

  setUpAll(() {
    registerFallbackValue(MoviePopularEventFake());
    registerFallbackValue(MoviePopularStateFake());
  });

  setUp(() {
    mockMoviePopularBloc = MockMoviePopularBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MoviePopularBloc>.value(
      value: mockMoviePopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(()=>mockMoviePopularBloc.state).thenReturn(MoviePopularLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(()=>mockMoviePopularBloc.state).thenReturn(const MoviePopularLoaded(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
        when(()=>mockMoviePopularBloc.state).thenReturn(const MoviePopularError('Failed'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
