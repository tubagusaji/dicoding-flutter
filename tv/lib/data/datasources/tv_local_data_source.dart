import 'package:core/core.dart';

import '../models/tv_table.dart';
import 'db/database_helper.dart';

abstract class TvLocalDataSource {
  Future<void> cacheNowPlayingTv(List<TvTable> tvList);
  Future<List<TvTable>> getCacheNowPlayingTv();
  Future<void> cachePopularTv(List<TvTable> tvList);
  Future<List<TvTable>> getCachePopularTv();
  Future<List<TvTable>> getWatchListTv();
  Future<String> insertTvWatchList(TvTable tvTable);
  Future<String> removeTvWatchList(TvTable tvTable);
  Future<void> cacheTopRatedTv(List<TvTable> tvList);
  Future<List<TvTable>> getCacheTopRatedTv();
  Future<TvTable?> getTvById(int id);
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final TvDatabaseHelper tvDatabaseHelper;

  TvLocalDataSourceImpl({required this.tvDatabaseHelper});
  @override
  Future<void> cacheNowPlayingTv(List<TvTable> tvList) async {
    await tvDatabaseHelper.clearCache("now playing");
    await tvDatabaseHelper.insertCacheTransaction(tvList, 'now playing');
  }

  @override
  Future<List<TvTable>> getCacheNowPlayingTv() async {
    final result = await tvDatabaseHelper.getCacheTvList('now playing');
    if (result.length > 0) {
      return result.map((e) => TvTable.fromMap(e)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<void> cachePopularTv(List<TvTable> tvList) async {
    await tvDatabaseHelper.clearCache("popular");
    await tvDatabaseHelper.insertCacheTransaction(tvList, 'popular');
  }

  @override
  Future<List<TvTable>> getCachePopularTv() async {
    final result = await tvDatabaseHelper.getCacheTvList('popular');
    if (result.length > 0) {
      return result.map((e) => TvTable.fromMap(e)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<void> cacheTopRatedTv(List<TvTable> tvList) async {
    await tvDatabaseHelper.clearCache("toprated");
    await tvDatabaseHelper.insertCacheTransaction(tvList, 'toprated');
  }

  @override
  Future<List<TvTable>> getCacheTopRatedTv() async {
    final result = await tvDatabaseHelper.getCacheTvList('toprated');
    if (result.length > 0) {
      return result.map((e) => TvTable.fromMap(e)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await tvDatabaseHelper.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchListTv() async {
    final result = await tvDatabaseHelper.getWatchlistTv();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertTvWatchList(TvTable tvTable) async {
    try {
      await tvDatabaseHelper.insertWatchlist(tvTable);
      return 'Added Tv to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTvWatchList(TvTable tvTable) async {
    try {
      await tvDatabaseHelper.removeWatchlist(tvTable);
      return 'Removed Tv from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
