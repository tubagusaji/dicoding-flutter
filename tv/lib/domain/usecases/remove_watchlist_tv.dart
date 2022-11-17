import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv_detail.dart';
import '../repositories/tv_repository.dart';

class RemoveWatchListTv {
  TvRepository tvRepository;

  RemoveWatchListTv(this.tvRepository);

  Future<Either<Failure, String>> execute(TvDetail tvDetail) {
    return tvRepository.removeWatchListTv(tvDetail);
  }
}
