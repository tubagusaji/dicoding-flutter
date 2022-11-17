import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv_detail.dart';
import '../repositories/tv_repository.dart';

class SaveWatchListTv {
  final TvRepository tvRepository;

  SaveWatchListTv(this.tvRepository);

  Future<Either<Failure, String>> execute(TvDetail tvDetail) {
    return tvRepository.saveWatchListTv(tvDetail);
  }
}
