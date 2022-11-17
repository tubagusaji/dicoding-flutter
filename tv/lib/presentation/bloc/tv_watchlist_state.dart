part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();
  @override
  List<Object> get props => [];
}

class TvWatchlistInitial extends TvWatchlistState {
  @override
  List<Object> get props => [];
}

class TvWatchListLoadingState extends TvWatchlistState{
  @override
  List<Object> get props => [];
}

class TvWatchListErrorState extends TvWatchlistState{
  final String msg;

  const TvWatchListErrorState(this.msg);
  @override
  List<Object> get props => [msg];
}

class TvWatchListLoadedState extends TvWatchlistState{
  final List<Tv> tvWatchList;

  const TvWatchListLoadedState(this.tvWatchList);
  @override
  List<Object> get props => [tvWatchList];
}