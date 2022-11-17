part of 'movie_top_rated_bloc.dart';

abstract class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();
  @override
  List<Object> get props => [];
}

class MovieTopRatedInitial extends MovieTopRatedState {
  @override
  List<Object> get props => [];
}

class MovieTopRatedLoading extends MovieTopRatedState{

}

class  MovieTopRatedError extends MovieTopRatedState{
  final String msg;

  const MovieTopRatedError(this.msg);
  @override
  List<Object> get props => [msg];

}

class MovieTopRatedLoaded extends MovieTopRatedState{
  final List<Movie> movies;

  const MovieTopRatedLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}
