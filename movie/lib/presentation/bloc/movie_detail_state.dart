part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
}

class MovieDetailInitial extends MovieDetailState {
  @override
  List<Object> get props => [];
}


class MovieDetailLoadingState extends MovieDetailState{
  @override
  List<Object> get props => [];
}

class MovieDetailErrorState extends MovieDetailState{
  final String msg;

  const MovieDetailErrorState(this.msg);
  @override
  List<Object> get props => [msg];
}

class MovieDetailLoadedState extends MovieDetailState{
  final MovieDetail movieDetail;

  const MovieDetailLoadedState(this.movieDetail);
  @override
  List<Object> get props => [movieDetail];
}


