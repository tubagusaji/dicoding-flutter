part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String msg;

  SearchError(this.msg);

  @override
  List<Object> get props => [msg];
}

class SearchHasData extends SearchState {
  final List<Movie> result;

  SearchHasData(this.result);

  @override
  List<Object> get props => [result];
}
