import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie_detail.dart';

import '../../domain/usecases/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc({required this.getMovieDetail} )
      : super(MovieDetailInitial()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(MovieDetailLoadingState());
      final result = await getMovieDetail.execute(event.id);
      result.fold((l) => emit(MovieDetailErrorState(l.message)), (r) {
        emit(MovieDetailLoadedState(r));
      });
    });

    // on<LoadWatchListStatus>((event, emit)async{
    //   final result = await _getWatchListStatus.execute(event.id);
    //   emit(MovieWatchListStatus(result));
    // });
    //
    // on<AddToWatchListMovie>((event, emit)async{
    //   final result = await _saveWatchlist.execute(event.movieDetail);
    //   result.fold((l) => emit(WatchlistMessage(l.message)), (r) => emit(WatchlistMessage(r)));
    //   add(LoadWatchListStatus(event.movieDetail.id));
    // });
    //
    // on<RemoveToWatchListMovie>((event, emit)async{
    //   final result = await _removeWatchlist.execute(event.movieDetail);
    //   result.fold((l) => emit(WatchlistMessage(l.message)), (r) => emit(WatchlistMessage(r)));
    //   add(LoadWatchListStatus(event.movieDetail.id));
    // });
  }
}
