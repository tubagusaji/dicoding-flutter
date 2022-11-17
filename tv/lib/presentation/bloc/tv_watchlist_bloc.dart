import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';

import '../../domain/entities/tv.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchListTv getWatchListTv;
  TvWatchlistBloc({required this.getWatchListTv})
      : super(TvWatchlistInitial()) {
    on<FetchTvWatchListEvent>((event, emit) async {
      emit(TvWatchListLoadingState());
      final result = await getWatchListTv.execute();
      result.fold((l) => emit(TvWatchListErrorState(l.message)),
          (r) => emit(TvWatchListLoadedState(r)));
    });
  }
}
