import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(
        getMovieDetail: mockGetMovieDetail);
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
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
  }


  group('Get Movie Detail', () {

    test('initial state', () {
      expect(movieDetailBloc.state, MovieDetailInitial());
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'should get data from the usecase',
        build: () {
          _arrangeUsecase();
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(FetchMovieDetail(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
              MovieDetailLoadingState(),
              MovieDetailLoadedState(testMovieDetail)
            ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'should return error when movie detail is unsuccessful',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(FetchMovieDetail(tId)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
              MovieDetailLoadingState(),
              const MovieDetailErrorState('Server Failure'),
            ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
        });
  });
}
