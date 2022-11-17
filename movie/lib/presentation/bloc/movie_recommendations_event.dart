part of 'movie_recommendations_bloc.dart';

abstract class MovieRecommendationsEvent extends Equatable {
  const MovieRecommendationsEvent();
  @override
  List<Object> get props => [];

}

class FetchMovieRecommendationsEvent extends MovieRecommendationsEvent{
  final int id;

  const FetchMovieRecommendationsEvent(this.id);

  @override
  List<Object> get props => [id];
}
