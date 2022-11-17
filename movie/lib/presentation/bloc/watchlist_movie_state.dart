part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();
  @override
  List<Object> get props => [];
}

class WatchlistMovieInitial extends WatchlistMovieState {
  @override
  List<Object> get props => [];
}

class WatchListMovieLoadingState extends WatchlistMovieState{
  @override
  List<Object> get props => [];
}

class WatchListMovieErrorState extends WatchlistMovieState{
  final String msg;

  const WatchListMovieErrorState(this.msg);
  @override
  List<Object> get props => [msg];
}

class WatchListMovieLoadedState extends WatchlistMovieState{
  final List<Movie> movies;

  const WatchListMovieLoadedState(this.movies);
  @override
  List<Object> get props => [movies];
}



class WatchListStatusErrorMessageState extends WatchlistMovieState{
  final String msg;

  const WatchListStatusErrorMessageState(this.msg);
  @override
  List<Object> get props => [msg];
}


class WatchListStatusSuccessMessageState extends WatchlistMovieState{
  final String msg;

  const WatchListStatusSuccessMessageState(this.msg);
  @override
  List<Object> get props => [msg];
}

class LoadWatchListStatusState extends WatchlistMovieState{
  final bool status;

  const LoadWatchListStatusState(this.status);

  @override
  List<Object> get props => [status];
}