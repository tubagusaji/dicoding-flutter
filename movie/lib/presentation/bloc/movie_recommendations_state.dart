part of 'movie_recommendations_bloc.dart';

abstract class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();
  @override
  List<Object> get props => [];
}

class MovieRecommendationsInitial extends MovieRecommendationsState {
  @override
  List<Object> get props => [];
}

class MovieRecommendationsLoadingState extends MovieRecommendationsState{
  @override
  List<Object> get props => [];
}

class MovieRecommendationsLoadedState extends MovieRecommendationsState{
  final List<Movie> movieRecommendations;

  const MovieRecommendationsLoadedState(this.movieRecommendations);

  @override
  List<Object> get props => [movieRecommendations];
}

class MovieRecommendationsErrorState extends MovieRecommendationsState{
  final String msg;

  const MovieRecommendationsErrorState(this.msg);

  @override
  List<Object> get props => [msg];
}
