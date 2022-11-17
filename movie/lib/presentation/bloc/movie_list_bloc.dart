import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

import '../../domain/entities/movie.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  final GetPopularMovies _getPopularMovies;
  final GetTopRatedMovies _getTopRatedMovies;

  MovieListBloc(this._getNowPlayingMovies, this._getPopularMovies,
      this._getTopRatedMovies)
      : super(MovieListStateInitial()) {

    on<FetchNowPlayingMovies>((event, emit) async {
      emit(MovieListNowPlayingLoading());
      final result = await _getNowPlayingMovies.execute();
      result.fold((failure) {
        emit(MovieListNowPlayingError(failure.message));
      }, (moviesData) => emit(MovieListNowPlayingLoaded(moviesData)));
    });

    // on<FetchPopularMovies>((event, emit)async{
    //   emit(MovieListPopularLoading());
    //   final result = await _getPopularMovies.execute();
    //   result.fold((l) => emit(MovieListPopularError(l.message)), (moviesData) => emit(MovieListPopularLoaded(moviesData)));
    // });
    //
    // on<FetchTopRatedMovies>((event, emit)async{
    //   emit(MovieListTopRatedLoading());
    //   final result = await _getTopRatedMovies.execute();
    //   result.fold((l) => emit(MovieListTopRatedError(l.message)), (moviesData) => emit(MovieListTopRatedLoaded(moviesData)));
    // });
  }
}
