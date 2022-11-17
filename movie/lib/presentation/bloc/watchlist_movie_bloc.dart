import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/usecases/remove_watchlist.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  WatchlistMovieBloc( {required this.getWatchlistMovies,
  required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist
  })
      : super(WatchlistMovieInitial()) {
    on<FetchWatchListMovie>((event, emit) async {
      emit(WatchListMovieLoadingState());
      final result = await getWatchlistMovies.execute();

      result.fold((l) => emit(WatchListMovieErrorState(l.message)),
          (r) => emit(WatchListMovieLoadedState(r)));
    });

    on<LoadWatchListStatus>((event, emit)async{
      final result = await getWatchListStatus.execute(event.id);

      emit(LoadWatchListStatusState(result));
    });

    on<AddToWatchListMovie>((event, emit)async{
      final result = await saveWatchlist.execute(event.movieDetail);
      result.fold((l) => emit(WatchListStatusErrorMessageState(l.message)), (r) => emit(WatchListStatusSuccessMessageState(r)));
      
      add(LoadWatchListStatus(event.movieDetail.id));
    });

    on<RemoveToWatchListMovie>((event, emit)async {
      final result = await removeWatchlist.execute(event.movieDetail);
      result.fold((l) => emit(WatchListStatusErrorMessageState(l.message)), (r) => emit(WatchListStatusSuccessMessageState(r)));
      add(LoadWatchListStatus(event.movieDetail.id));
    });
  }
}
