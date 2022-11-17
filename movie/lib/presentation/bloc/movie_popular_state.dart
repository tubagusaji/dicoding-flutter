part of 'movie_popular_bloc.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();
}

class MoviePopularInitial extends MoviePopularState {
  @override
  List<Object> get props => [];
}

class MoviePopularLoading extends MoviePopularState{
  @override
  List<Object> get props => [];
}
class MoviePopularError extends MoviePopularState{
  final String msg;

  const MoviePopularError(this.msg);

  @override
  List<Object> get props => [msg];
}

class MoviePopularLoaded extends MoviePopularState{
  final List<Movie> popularMovies;

  const MoviePopularLoaded(this.popularMovies);
  @override
  List<Object> get props => [popularMovies];
}

