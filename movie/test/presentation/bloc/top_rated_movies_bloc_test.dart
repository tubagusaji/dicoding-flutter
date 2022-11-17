
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/movie_top_rated_bloc.dart';

import 'movie_list_bloc_test.mocks.dart';

void main(){
  late MovieTopRatedBloc movieTopRatedBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp((){
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieTopRatedBloc = MovieTopRatedBloc(mockGetTopRatedMovies);
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
    expect(movieTopRatedBloc.state, MovieTopRatedInitial());
  });

  blocTest<MovieTopRatedBloc, MovieTopRatedState>('should change movies data when data is gotten successfully', build: (){
    when(mockGetTopRatedMovies.execute()).thenAnswer((_)async => Right(tMovieList));
    return movieTopRatedBloc;
  },
      act: (bloc) => bloc.add(FetchMovieTopRatedEvent()),
      expect: ()=>[
        MovieTopRatedLoading(),
        MovieTopRatedLoaded(tMovieList)
      ],
      verify: (bloc){
        verify(mockGetTopRatedMovies.execute());
      }
  );

  blocTest<MovieTopRatedBloc, MovieTopRatedState>('should return error when data is unsuccessful', build: (){
    when(mockGetTopRatedMovies.execute()).thenAnswer((_)async => Left(ServerFailure('Server Failure')));
    return movieTopRatedBloc;
  },
      act: (bloc) => bloc.add(FetchMovieTopRatedEvent()),
      expect: ()=>[
        MovieTopRatedLoading(),
        const MovieTopRatedError('Server Failure')
      ],
      verify: (bloc){
        verify(mockGetTopRatedMovies.execute());
      }
  );


}