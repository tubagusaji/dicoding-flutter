part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();
  @override
  List<Object> get props => [];
}

class FetchTvDetail extends TvDetailEvent{
  final int id;

  const FetchTvDetail(this.id);
  @override
  List<Object> get props => [id];

}

class AddToWatchListTv extends TvDetailEvent{
  final TvDetail tvDetail;

  const AddToWatchListTv(this.tvDetail);
  @override
  List<Object> get props => [tvDetail];
}

class RemoveFromWatchListTv extends TvDetailEvent{
  final TvDetail tvDetail;

  const RemoveFromWatchListTv(this.tvDetail);
  @override
  List<Object> get props => [tvDetail];
}

class LoadWatchListTvStatus extends TvDetailEvent{
  final int id;

  const LoadWatchListTvStatus(this.id);
  @override
  List<Object> get props => [id];
}