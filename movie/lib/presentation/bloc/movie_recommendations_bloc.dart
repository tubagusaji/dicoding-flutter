import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';

import '../../domain/entities/movie.dart';

part 'movie_recommendations_event.dart';
part 'movie_recommendations_state.dart';

class MovieRecommendationsBloc extends Bloc<MovieRecommendationsEvent, MovieRecommendationsState> {
  final GetMovieRecommendations getMovieRecommendations;
  MovieRecommendationsBloc({required this.getMovieRecommendations}) : super(MovieRecommendationsInitial()) {
    on<FetchMovieRecommendationsEvent>((event, emit)async {
      emit(MovieRecommendationsLoadingState());

      final result = await getMovieRecommendations.execute(event.id);

      result.fold((l) => emit(MovieRecommendationsErrorState(l.message)), (r) => emit(MovieRecommendationsLoadedState(r)));
    });
  }
}
