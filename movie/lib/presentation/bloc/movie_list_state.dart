part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class MovieListStateInitial extends MovieListState {}

class MovieListNowPlayingEmpty extends MovieListState {}

class MovieListNowPlayingLoading extends MovieListState {}

class MovieListNowPlayingError extends MovieListState {
  final String msg;

  const MovieListNowPlayingError(this.msg);

  @override
  List<Object> get props => [msg];
}

class MovieListNowPlayingLoaded extends MovieListState {
  final List<Movie> result;

  const MovieListNowPlayingLoaded(this.result);

  @override
  List<Object> get props => [result];
}

// class MovieListPopularEmpty extends MovieListState {}
//
// class MovieListPopularLoading extends MovieListState {}
//
// class MovieListPopularError extends MovieListState {
//   final String msg;
//
//   const MovieListPopularError(this.msg);
//
//   @override
//   List<Object> get props => [msg];
// }
//
// class MovieListPopularLoaded extends MovieListState {
//   final List<Movie> result;
//
//   const MovieListPopularLoaded(this.result);
//
//   @override
//   List<Object> get props => [result];
// }
// class MovieListTopRatedEmpty extends MovieListState {}
//
// class MovieListTopRatedLoading extends MovieListState {}
//
// class MovieListTopRatedError extends MovieListState {
//   final String msg;
//
//   const MovieListTopRatedError(this.msg);
//
//   @override
//   List<Object> get props => [msg];
// }
//
// class MovieListTopRatedLoaded extends MovieListState {
//   final List<Movie> result;
//
//   const MovieListTopRatedLoaded(this.result);
//
//   @override
//   List<Object> get props => [result];
// }

