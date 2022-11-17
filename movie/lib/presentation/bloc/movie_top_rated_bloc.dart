import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies _getTopRatedMovies;
  MovieTopRatedBloc(this._getTopRatedMovies) : super(MovieTopRatedInitial()) {
    on<FetchMovieTopRatedEvent>((event, emit)async {
      emit(MovieTopRatedLoading());
      final result = await _getTopRatedMovies.execute();
      result.fold((l) => emit(MovieTopRatedError(l.message)), (r) => emit(MovieTopRatedLoaded(r)));
    });
  }
}
