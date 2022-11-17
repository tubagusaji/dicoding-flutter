import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';

import '../../domain/entities/tv.dart';

part 'tv_top_rated_event.dart';
part 'tv_top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final GetTopRatedTv getTopRatedTv;
  TvTopRatedBloc({required this.getTopRatedTv}) : super(TvTopRatedInitial()) {
    on<FetchTvTopRatedEvent>((event, emit) async {
      emit(TvTopRatedLoadingState());
      final result = await getTopRatedTv.execute();
      result.fold((l) => emit(TvTopRatedErrorState(l.message)),
          (r) => emit(TvTopRatedLoadedState(r)));
    });
  }
}
