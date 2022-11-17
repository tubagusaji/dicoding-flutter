

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/movie_popular_bloc.dart';

import 'movie_list_bloc_test.mocks.dart';

void main(){
  late MoviePopularBloc moviePopularBloc;
  late MockGetPopularMovies mockGetPopularMovies;


  setUp((){
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = MoviePopularBloc(mockGetPopularMovies);
  });

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

  final tMovieList = <Movie>[tMovie];

  test('initialState should be Empty', () {
    expect(moviePopularBloc.state, MoviePopularInitial());
  });

  blocTest<MoviePopularBloc, MoviePopularState>('should change movies data when data is gotten successfully', build: (){
    when(mockGetPopularMovies.execute()).thenAnswer((_)async => Right(tMovieList));
    return moviePopularBloc;
  },
  act: (bloc) => bloc.add(FetchMoviePopular()),
    expect: ()=>[
      MoviePopularLoading(),
      MoviePopularLoaded(tMovieList)
    ],
    verify: (bloc){
    verify(mockGetPopularMovies.execute());
    }
  );

  blocTest<MoviePopularBloc, MoviePopularState>('should return error when data is unsuccessful', build: (){
    when(mockGetPopularMovies.execute()).thenAnswer((_)async => Left(ServerFailure('Server Failure')));
    return moviePopularBloc;
  },
      act: (bloc) => bloc.add(FetchMoviePopular()),
      expect: ()=>[
        MoviePopularLoading(),
        const MoviePopularError('Server Failure')
      ],
      verify: (bloc){
        verify(mockGetPopularMovies.execute());
      }
  );
}