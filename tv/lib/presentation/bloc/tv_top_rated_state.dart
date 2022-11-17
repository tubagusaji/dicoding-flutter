part of 'tv_top_rated_bloc.dart';

abstract class TvTopRatedState extends Equatable {
  const TvTopRatedState();
  @override
  List<Object> get props => [];
}

class TvTopRatedInitial extends TvTopRatedState {
  @override
  List<Object> get props => [];
}

class TvTopRatedLoadingState extends TvTopRatedState{
  @override
  List<Object> get props => [];
}

class TvTopRatedErrorState extends TvTopRatedState{
  final String msg;

  const TvTopRatedErrorState(this.msg);
  @override
  List<Object> get props => [msg];
}

class TvTopRatedLoadedState extends TvTopRatedState{
  final List<Tv> tvTopRatedList;

  const TvTopRatedLoadedState(this.tvTopRatedList);
  @override
  List<Object> get props => [tvTopRatedList];
}
