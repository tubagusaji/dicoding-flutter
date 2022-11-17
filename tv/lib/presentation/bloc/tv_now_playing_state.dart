part of 'tv_now_playing_bloc.dart';

abstract class TvNowPlayingState extends Equatable {
  const TvNowPlayingState();
  @override
  List<Object> get props => [];
}

class TvNowPlayingInitial extends TvNowPlayingState {
  @override
  List<Object> get props => [];
}

class TvNowPlayingLoadingState extends TvNowPlayingState {
  @override
  List<Object> get props => [];
}

class TvNowPlayingErrorState extends TvNowPlayingState {
  final String msg;

  const TvNowPlayingErrorState(this.msg);
  @override
  List<Object> get props => [msg];
}

class TvNowPlayingLoadedState extends TvNowPlayingState {
  final List<Tv> tvNowPlayingList;

  const TvNowPlayingLoadedState(this.tvNowPlayingList);
  @override
  List<Object> get props => [TvNowPlayingLoadedState];
}

