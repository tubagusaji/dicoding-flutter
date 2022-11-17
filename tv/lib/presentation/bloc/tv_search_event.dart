part of 'tv_search_bloc.dart';

abstract class TvSearchEvent extends Equatable {
  const TvSearchEvent();
}

class TvSearchByQuery extends TvSearchEvent{
  final String query;

  const TvSearchByQuery(this.query);

  @override
  List<Object?> get props => [query];
}
