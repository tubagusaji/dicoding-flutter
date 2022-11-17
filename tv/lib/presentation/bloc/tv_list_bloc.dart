import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';

import '../../domain/entities/tv.dart';

part 'tv_list_event.dart';
part 'tv_list_state.dart';

class TvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetNowPlayingTv getNowPlayingTv;
  final GetPopularTv getPopularTv;
  final GetTopRatedTv getTopRatedTv;

  TvListBloc(
      {required this.getNowPlayingTv,
      required this.getPopularTv,
      required this.getTopRatedTv})
      : super(TvListState.initial()) {
    on<FetchTvNowPlaying>((event, emit) async {
      emit(state.copyWith(nowPlayingTvState: RequestState.Loading));
      final result = await getNowPlayingTv.execute();

      result.fold(
          (l) => emit(state.copyWith(
              nowPlayingTvState: RequestState.Error, msg: l.message)),
          (r) => emit(state.copyWith(
              nowPlayingTvState: RequestState.Loaded, nowPlayingTvList: r)));
    });

    on<FetchTvPopular>((event, emit) async {
      emit(state.copyWith(popularTvState: RequestState.Loading));
      final result = await getPopularTv.execute();
      result.fold(
          (l) => emit(state.copyWith(
              popularTvState: RequestState.Error, msg: l.message)),
          (r) => emit(state.copyWith(
              popularTvState: RequestState.Loaded, popularTvList: r)));
    });

    on<FetchTvTopRated>((event, emit) async {
      emit(state.copyWith(topRatedTvState: RequestState.Loading));
      final result = await getTopRatedTv.execute();
      result.fold(
              (l) => emit(state.copyWith(
              topRatedTvState: RequestState.Error, msg: l.message)),
              (r) => emit(state.copyWith(
              topRatedTvState: RequestState.Loaded, topRatedTvList: r)));
    });
  }
}
