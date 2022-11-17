part of 'tv_popular_bloc.dart';

abstract class TvPopularState extends Equatable{
  @override
  List<Object?> get props => [];
}

class TvPopularInitial extends TvPopularState {
  @override
  List<Object?> get props => [];
}

class TvPopularLoadingState extends TvPopularState{
  @override
  List<Object?> get props => [];
}

class TvPopularLoadedState extends TvPopularState{
  final List<Tv> tvPopularList;

  TvPopularLoadedState(this.tvPopularList);
  @override
  List<Object?> get props => [tvPopularList];
}

class TvPopularErrorState extends TvPopularState{
  final String msg;

  TvPopularErrorState(this.msg);

  @override
  List<Object?> get props => [msg];
}

