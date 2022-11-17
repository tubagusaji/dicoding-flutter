
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv/domain/usecases/search_tv.dart';

import '../../domain/entities/tv.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTv searchTv;
  TvSearchBloc({required this.searchTv}) : super(TvSearchInitial()) {
    on<TvSearchByQuery>((event, emit) async {
      emit(TvSearchLoadingState());
      final result = await searchTv.execute(event.query);
      result.fold((l) => emit(TvSearchErrorState(l.message)),
          (r) => emit(TvSearchLoadedState(r)));
    }, transformer: debounce(const Duration(seconds: 1))
    );
  }

  EventTransformer<T> debounce<T>(Duration duration){
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
