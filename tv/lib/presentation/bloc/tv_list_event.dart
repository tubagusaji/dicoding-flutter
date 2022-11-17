part of 'tv_list_bloc.dart';

abstract class TvListEvent extends Equatable {
  const TvListEvent();
  @override
  List<Object?> get props => [];
}

class FetchTvNowPlaying extends TvListEvent{
  @override
  List<Object?> get props => [];

}

class FetchTvPopular extends TvListEvent{
  @override
  List<Object?> get props => [];

}

class FetchTvTopRated extends TvListEvent{
  @override
  List<Object?> get props => [];

}