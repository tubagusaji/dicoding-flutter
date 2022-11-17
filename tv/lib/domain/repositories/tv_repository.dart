import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv.dart';
import '../entities/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getNowPlayingTv();
  Future<Either<Failure, List<Tv>>> getPopularTv();
  Future<Either<Failure, List<Tv>>> getTopRatedTv();
  Future<Either<Failure, List<Tv>>> getWatchlistTv();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id);
  Future<bool> isInWatchList(int id);
  Future<Either<Failure, String>> saveWatchListTv(TvDetail tvDetail);
  Future<Either<Failure, String>> removeWatchListTv(TvDetail tvDetail);
  Future<Either<Failure, List<Tv>>> searchTv(String query);
}
