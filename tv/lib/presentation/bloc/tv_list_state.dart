part of 'tv_list_bloc.dart';

 class TvListState extends Equatable {
   final RequestState nowPlayingTvState;
   final RequestState popularTvState;
   final RequestState topRatedTvState;

   final List<Tv> nowPlayingTvList;
   final List<Tv> popularTvList;
   final List<Tv> topRatedTvList;
   final String msg;

  const TvListState({
     required this.nowPlayingTvState,
     required this.popularTvState,
     required this.topRatedTvState,
     required this.nowPlayingTvList,
     required this.popularTvList,
     required this.topRatedTvList,
    required this.msg,
 });

  TvListState copyWith({
   RequestState? nowPlayingTvState,
   RequestState? popularTvState,
   RequestState? topRatedTvState,
    List<Tv>? nowPlayingTvList,
    List<Tv>? popularTvList,
    List<Tv>? topRatedTvList,
    String? msg
 }){
    return TvListState(nowPlayingTvState: nowPlayingTvState??this.nowPlayingTvState,
        popularTvState: popularTvState??this.popularTvState,
        topRatedTvState: topRatedTvState??this.topRatedTvState,
        nowPlayingTvList: nowPlayingTvList??this.nowPlayingTvList,
        popularTvList: popularTvList??this.popularTvList,
        topRatedTvList: topRatedTvList??this.topRatedTvList,
        msg: msg??this.msg);
  }

  factory TvListState.initial() => const TvListState(nowPlayingTvState: RequestState.Empty,
      popularTvState: RequestState.Empty,
      topRatedTvState: RequestState.Empty,
      nowPlayingTvList: <Tv>[], popularTvList: <Tv>[], topRatedTvList: <Tv>[], msg: '');

  @override
  List<Object> get props => [
    nowPlayingTvState,
    popularTvState,
    topRatedTvState,
    nowPlayingTvList,
    popularTvList,
    topRatedTvList,
    msg
  ];
}
