import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/repositories/tv_repository.dart';
import '../datasources/tv_local_data_source.dart';
import '../datasources/tv_remote_data_source.dart';
import '../models/tv_table.dart';

class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource remoteDataSource;
  final TvLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TvRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Tv>>> getNowPlayingTv() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getNowPlayingTv();
        localDataSource.cacheNowPlayingTv(
            result.map((tv) => TvTable.fromDTO(tv)).toList());
        return Right(result.map((e) => e.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }on TlsException catch (e) {
        return Left(CommonFailure('Certificated not valid\n${e.message}'));
      } catch (e) {
        return Left(CommonFailure(e.toString()));
      }
    } else {
      try {
        final result = await localDataSource.getCacheNowPlayingTv();
        return Right(result.map((e) => e.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getPopularTv() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPopularTv();
        localDataSource
            .cachePopularTv(result.map((tv) => TvTable.fromDTO(tv)).toList());
        return Right(result.map((e) => e.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }on TlsException catch (e) {
        return Left(CommonFailure('Certificated not valid\n${e.message}'));
      } catch (e) {
        return Left(CommonFailure(e.toString()));
      }
    } else {
      try {
        final result = await localDataSource.getCachePopularTv();
        return Right(result.map((e) => e.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedTv() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTopRatedTv();
        localDataSource
            .cacheTopRatedTv(result.map((tv) => TvTable.fromDTO(tv)).toList());
        return Right(result.map((e) => e.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }on TlsException catch (e) {
        return Left(CommonFailure('Certificated not valid\n${e.message}'));
      } catch (e) {
        return Left(CommonFailure(e.toString()));
      }
    } else {
      try {
        final result = await localDataSource.getCacheTopRatedTv();
        return Right(result.map((e) => e.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTvDetail(id);
        return Right(result.toEntity());
      } on ServerException {
        return Left(ServerFailure(''));
      }on TlsException catch (e) {
        return Left(CommonFailure('Certificated not valid\n${e.message}'));
      } catch (e) {
        return Left(CommonFailure(e.toString()));
      }
    } else {
      return Left(ConnectionFailure("no network"));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTvRecommendations(id);
        return Right(result.map((e) => e.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }on TlsException catch (e) {
        return Left(CommonFailure('Certificated not valid\n${e.message}'));
      } catch (e) {
        return Left(CommonFailure(e.toString()));
      }
    } else {
      return Left(ConnectionFailure("no network"));
    }
  }

  @override
  Future<bool> isInWatchList(int id) async {
    final result = await localDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchlistTv() async {
    final result = await localDataSource.getWatchListTv();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<Either<Failure, String>> saveWatchListTv(TvDetail tvDetail) async {
    try {
      final result =
          await localDataSource.insertTvWatchList(TvTable.fromEntity(tvDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchListTv(TvDetail tvDetail) async {
    try {
      final result =
          await localDataSource.removeTvWatchList(TvTable.fromEntity(tvDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> searchTv(String query) async {
    try {
      final result = await remoteDataSource.searchTv(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }on TlsException catch (e) {
      return Left(CommonFailure('Certificated not valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
