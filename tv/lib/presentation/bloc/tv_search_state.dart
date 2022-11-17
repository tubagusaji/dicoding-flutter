part of 'tv_search_bloc.dart';

abstract class TvSearchState extends Equatable {
  const TvSearchState();
  @override
  List<Object?> get props => [];
}

class TvSearchInitial extends TvSearchState {
  @override
  List<Object> get props => [];
}

class TvSearchLoadingState extends TvSearchState{
  @override
  List<Object?> get props => [];

}

class TvSearchErrorState extends TvSearchState{
  final String msg;

  const TvSearchErrorState(this.msg);
  @override
  List<Object?> get props => [msg];

}

class TvSearchLoadedState extends TvSearchState{
  final List<Tv> tvList;

  const TvSearchLoadedState(this.tvList);
  @override
  List<Object?> get props => [tvList];

}