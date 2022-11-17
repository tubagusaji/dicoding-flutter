import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class SearchTv {
  final TvRepository tvRepository;
  SearchTv(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return tvRepository.searchTv(query);
  }
}
