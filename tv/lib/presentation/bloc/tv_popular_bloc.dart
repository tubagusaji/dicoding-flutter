import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';

part 'tv_popular_event.dart';
part 'tv_popular_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  final GetPopularTv getPopularTv;
  TvPopularBloc({required this.getPopularTv}) : super(TvPopularInitial()) {
    on<FetchTvPopularEvent>((event, emit) async {
      emit(TvPopularLoadingState());
      final result = await getPopularTv.execute();

      result.fold((l) => emit(TvPopularErrorState(l.message)),
          (r) => emit(TvPopularLoadedState(r)));
    });
  }
}
