import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/search.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;

  SearchBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());

      final result = await _searchMovies.execute(query);

      result.fold((l) {
        emit(SearchError(l.message));
      }, (r) {
        emit(SearchHasData(r));
      });
    }, transformer: debounce(const Duration(seconds: 1)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
