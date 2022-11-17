import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recomendations.dart';
import 'package:tv/domain/usecases/get_tv_watchlist_status.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_wacthlist_tv.dart';

import '../../domain/entities/created_by.dart';
import '../../domain/entities/genre.dart';
import '../../domain/entities/last_episode_to_air.dart';
import '../../domain/entities/network.dart';
import '../../domain/entities/production_country.dart';
import '../../domain/entities/season.dart';
import '../../domain/entities/spoken_language.dart';
import '../../domain/entities/tv.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetTvWatchListStatus getTvWatchListStatus;
  final SaveWatchListTv saveWatchListTv;
  final RemoveWatchListTv removeWatchListTv;

  TvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getTvWatchListStatus,
    required this.saveWatchListTv,
    required this.removeWatchListTv,
  }) : super(TvDetailState.initial()) {
    on<FetchTvDetail>((event, emit) async {
      emit(TvDetailState.initial()
          .copyWith(tvDetailState: RequestState.Loading));

      final result = await getTvDetail.execute(event.id);
      final tvRecommendations = await getTvRecommendations.execute(event.id);

      result.fold(
          (l)async {emit(state.copyWith(
              tvDetailState: RequestState.Error, msg: l.message));}, (r)async {
        emit(state.copyWith(
            tvDetailState: RequestState.Loaded,
            tvDetail: r,
            tvRecommendationsState: RequestState.Loading));
        tvRecommendations.fold(
            (l) => emit(state.copyWith(
                tvRecommendationsState: RequestState.Error, msg: l.message)),
            (r) => emit(state.copyWith(
                tvRecommendationsState: RequestState.Loaded,
                tvRecommendations: r)));
      });
    });

    on<AddToWatchListTv>((event, emit) async {
      final result = await saveWatchListTv.execute(event.tvDetail);
      result.fold((l) => emit(state.copyWith(tvWatchlistMessage: l.message)),
          (r) => emit(state.copyWith(tvWatchlistMessage: r)));
      
      add(LoadWatchListTvStatus(event.tvDetail.id));
    });

    on<RemoveFromWatchListTv>((event, emit) async {
      final result = await removeWatchListTv.execute(event.tvDetail);
      result.fold((l) => emit(state.copyWith(tvWatchlistMessage: l.message)),
              (r) => emit(state.copyWith(tvWatchlistMessage: r)));

      add(LoadWatchListTvStatus(event.tvDetail.id));
    });

    on<LoadWatchListTvStatus>((event, emit)async {
     final result = await getTvWatchListStatus.execute(event.id);
     emit(state.copyWith(isInTvWatchList: result));
    });
  }
}
