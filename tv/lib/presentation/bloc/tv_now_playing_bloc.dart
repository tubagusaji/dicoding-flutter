import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';

import '../../domain/entities/tv.dart';

part 'tv_now_playing_event.dart';
part 'tv_now_playing_state.dart';

class TvNowPlayingBloc extends Bloc<TvNowPlayingEvent, TvNowPlayingState> {
  final GetNowPlayingTv getNowPlayingTv;
  TvNowPlayingBloc({required this.getNowPlayingTv})
      : super(TvNowPlayingInitial()) {
    on<FetchTvNowPlayingEvent>((event, emit) async {
      emit(TvNowPlayingLoadingState());
      final result = await getNowPlayingTv.execute();
      result.fold((l) => emit(TvNowPlayingErrorState(l.message)),
          (r) => emit(TvNowPlayingLoadedState(r)));
    });
  }
}
