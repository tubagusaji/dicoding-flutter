import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/movie_list_bloc.dart';
import 'package:movie/presentation/bloc/movie_popular_bloc.dart';
import 'package:movie/presentation/bloc/movie_top_rated_bloc.dart';

import 'movie_list_bloc_test.mocks.dart';


@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main(){
  late MovieListBloc movieListBloc;
  late MoviePopularBloc moviePopularBloc;
  late MovieTopRatedBloc movieTopRatedBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp((){
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieListBloc = MovieListBloc(mockGetNowPlayingMovies, mockGetPopularMovies, mockGetTopRatedMovies);
    moviePopularBloc = MoviePopularBloc(mockGetPopularMovies);
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

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(movieListBloc.state, MovieListStateInitial());
    });

    blocTest<MovieListBloc, MovieListState>("should get data from the usecase",
        build: (){
      when(mockGetNowPlayingMovies.execute()).thenAnswer((_)async => Right(tMovieList));
      return movieListBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MovieListNowPlayingLoading(),
        MovieListNowPlayingLoaded(tMovieList)
      ],
      verify: (bloc){
      verify(mockGetNowPlayingMovies.execute());
      }
    );

    blocTest<MovieListBloc, MovieListState>("should return error when data is unsuccessful",
        build: (){
          when(mockGetNowPlayingMovies.execute()).thenAnswer((_)async =>  Left(ServerFailure('Server Failure')));
          return movieListBloc;
        },
        act: (bloc) => bloc.add(FetchNowPlayingMovies()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieListNowPlayingLoading(),
          const MovieListNowPlayingError('Server Failure')
        ],
        verify: (bloc){
          verify(mockGetNowPlayingMovies.execute());
        }
    );


  });

  group('popular movies', () {
    test('initialState should be Empty', () {
      expect(movieListBloc.state, MovieListStateInitial());
    });

    blocTest<MoviePopularBloc, MoviePopularState>("should get data from the usecase",
        build: (){
          when(mockGetPopularMovies.execute()).thenAnswer((_)async => Right(tMovieList));
          return moviePopularBloc;
        },
        act: (bloc) => bloc.add(FetchMoviePopular()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MoviePopularLoading(),
          MoviePopularLoaded(tMovieList)
        ],
        verify: (bloc){
          verify(mockGetPopularMovies.execute());
        }
    );

    blocTest<MoviePopularBloc, MoviePopularState>("should return error when data is unsuccessful",
        build: (){
          when(mockGetPopularMovies.execute()).thenAnswer((_)async =>  Left(ServerFailure('Server Failure')));
          return moviePopularBloc;
        },
        act: (bloc) => bloc.add(FetchMoviePopular()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MoviePopularLoading(),
          const MoviePopularError('Server Failure')
        ],
        verify: (bloc){
          verify(mockGetPopularMovies.execute());
        }
    );


  });

  group('top rated movies', () {
    test('initialState should be Empty', () {
      expect(movieListBloc.state, MovieListStateInitial());
    });

    blocTest<MovieTopRatedBloc, MovieTopRatedState>("should get data from the usecase",
        build: (){
          when(mockGetTopRatedMovies.execute()).thenAnswer((_)async => Right(tMovieList));
          return movieTopRatedBloc;
        },
        act: (bloc) => bloc.add(FetchMovieTopRatedEvent()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieTopRatedLoading(),
          MovieTopRatedLoaded(tMovieList)
        ],
        verify: (bloc){
          verify(mockGetTopRatedMovies.execute());
        }
    );

    blocTest<MovieTopRatedBloc, MovieTopRatedState>("should return error when data is unsuccessful",
        build: (){
          when(mockGetTopRatedMovies.execute()).thenAnswer((_)async =>  Left(ServerFailure('Server Failure')));
          return movieTopRatedBloc;
        },
        act: (bloc) => bloc.add(FetchMovieTopRatedEvent()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieTopRatedLoading(),
          const MovieTopRatedError('Server Failure')
        ],
        verify: (bloc){
          verify(mockGetTopRatedMovies.execute());
        }
    );


  });

}