import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/presentation/bloc/movie_recommendations_bloc.dart';

import 'movie_recommendations_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieRecommendations
])
void main() {
  late MovieRecommendationsBloc movieRecommendationsBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationsBloc = MovieRecommendationsBloc(
        getMovieRecommendations: mockGetMovieRecommendations);
  });

  final tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  void _arrangeUsecase() {
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }


  group('Get Movie Recommendations', () {

    test('initial state', () {
      expect(movieRecommendationsBloc.state, MovieRecommendationsInitial());
    });

    blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
        'should get data from the usecase',
        build: () {
          _arrangeUsecase();
          return movieRecommendationsBloc;
        },
        act: (bloc) => bloc.add(FetchMovieRecommendationsEvent(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
              MovieRecommendationsLoadingState(),
              MovieRecommendationsLoadedState(tMovies)
            ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(tId));
        });

    blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
        'should return error when movie detail is unsuccessful',
        build: () {
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return movieRecommendationsBloc;
        },
        act: (bloc) => bloc.add(FetchMovieRecommendationsEvent(tId)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
              MovieRecommendationsLoadingState(),
              const MovieRecommendationsErrorState('Server Failure'),
            ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(tId));
        });
  });
}
