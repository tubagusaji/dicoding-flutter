part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();
  @override
  List<Object> get props => [];
}

class FetchWatchListMovie extends WatchlistMovieEvent{
  @override
  List<Object> get props => [];
}


class AddToWatchListMovie extends WatchlistMovieEvent{
  final MovieDetail movieDetail;

  const AddToWatchListMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveToWatchListMovie extends WatchlistMovieEvent{
  final MovieDetail movieDetail;

  const RemoveToWatchListMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class LoadWatchListStatus extends WatchlistMovieEvent{
  final int id;

  const LoadWatchListStatus(this.id);
  @override
  List<Object> get props => [id];

}
