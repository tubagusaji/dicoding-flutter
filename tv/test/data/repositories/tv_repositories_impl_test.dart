import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';
import 'package:tv/domain/entities/tv.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repositoryImpl;
  late MockTvRemoteDataSource mockTvRemoteDataSource;
  late MockTvLocalDataSource mockTvLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockTvRemoteDataSource = MockTvRemoteDataSource();
    mockTvLocalDataSource = MockTvLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = TvRepositoryImpl(
        remoteDataSource: mockTvRemoteDataSource,
        localDataSource: mockTvLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  group("tv on air", () {
    group("ketika terhubung ke internet", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test("seharusnya mengecek jika device terhubung ke internet", () async {
        //arrange
        when(mockTvRemoteDataSource.getNowPlayingTv())
            .thenAnswer((_) async => []);
        //act
        await repositoryImpl.getNowPlayingTv();
        //assert
        verify(mockNetworkInfo.isConnected);
      });
      test("seharusnya mengembalikan data list of TV dari remote ketika sukses",
          () async {
        //arrange
        when(mockTvRemoteDataSource.getNowPlayingTv())
            .thenAnswer((_) async => tTvModelList);
        //act
        final result = await repositoryImpl.getNowPlayingTv();
        //assert
        verify(mockTvRemoteDataSource.getNowPlayingTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      });

      test(
          "seharusnya menyimpan data ke local jika berhasil mengambil data dari remote",
          () async {
        //arrange
        when(mockTvRemoteDataSource.getNowPlayingTv())
            .thenAnswer((_) async => tTvModelList);
        //actt
        await repositoryImpl.getNowPlayingTv();
        //assert
        verify(mockTvRemoteDataSource.getNowPlayingTv());
        verify(mockTvLocalDataSource.cacheNowPlayingTv([testTvCache]));
      });

      test("seharusnya mengembalikan failure ketika gagal mendapatkan data",
          () async {
        //arrange
        when(mockTvRemoteDataSource.getNowPlayingTv())
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getNowPlayingTv();
        //assert
        verify(mockTvRemoteDataSource.getNowPlayingTv());
        expect(result, equals(Left(ServerFailure(""))));
      });
    });

    group("ketika tidak terhubung ke internet", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test("seharusnya mengembalikan data dari lokal jika ada", () async {
        //arrange
        when(mockTvLocalDataSource.getCacheNowPlayingTv())
            .thenAnswer((_) async => [testTvCache]);

        //act
        final result = await repositoryImpl.getNowPlayingTv();
        //assert
        verify(mockTvLocalDataSource.getCacheNowPlayingTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvFromCache]);
      });

      test(
          "seharusnya mengembalikan exception cachefailure ketika tidak ada data dicache",
          () async {
        //arrange
        when(mockTvLocalDataSource.getCacheNowPlayingTv())
            .thenThrow(CacheException('No Cache'));
        //act
        final result = await repositoryImpl.getNowPlayingTv();
        //assert
        verify(mockTvLocalDataSource.getCacheNowPlayingTv());
        expect(result, Left(CacheFailure("No Cache")));
      });
    });
  });

  group("tv popular", () {
    group("ketika terhubung ke internet", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test("seharusnya mengecek jika device terhubung ke internet", () async {
        //arrange
        when(mockTvRemoteDataSource.getPopularTv()).thenAnswer((_) async => []);
        //act
        await repositoryImpl.getPopularTv();
        //assert
        verify(mockNetworkInfo.isConnected);
      });
      test("seharusnya mengembalikan data list of TV dari remote ketika sukses",
          () async {
        //arrange
        when(mockTvRemoteDataSource.getPopularTv())
            .thenAnswer((_) async => tTvModelList);
        //act
        final result = await repositoryImpl.getPopularTv();
        //assert
        verify(mockTvRemoteDataSource.getPopularTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      });

      test(
          "seharusnya menyimpan data ke local jika berhasil mengambil data dari remote",
          () async {
        //arrange
        when(mockTvRemoteDataSource.getPopularTv())
            .thenAnswer((_) async => tTvModelList);
        //actt
        await repositoryImpl.getPopularTv();
        //assert
        verify(mockTvRemoteDataSource.getPopularTv());
        verify(mockTvLocalDataSource.cachePopularTv([testTvCache]));
      });

      test("seharusnya mengembalikan failure ketika gagal mendapatkan data",
          () async {
        //arrange
        when(mockTvRemoteDataSource.getPopularTv())
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getPopularTv();
        //assert
        verify(mockTvRemoteDataSource.getPopularTv());
        expect(result, equals(Left(ServerFailure(""))));
      });
    });

    group("ketika tidak terhubung ke internet", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test("seharusnya mengembalikan data dari lokal jika ada", () async {
        //arrange
        when(mockTvLocalDataSource.getCachePopularTv())
            .thenAnswer((_) async => [testTvCache]);

        //act
        final result = await repositoryImpl.getPopularTv();
        //assert
        verify(mockTvLocalDataSource.getCachePopularTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvFromCache]);
      });

      test(
          "seharusnya mengembalikan exception cachefailure ketika tidak ada data dicache",
          () async {
        //arrange
        when(mockTvLocalDataSource.getCachePopularTv())
            .thenThrow(CacheException('No Cache'));
        //act
        final result = await repositoryImpl.getPopularTv();
        //assert
        verify(mockTvLocalDataSource.getCachePopularTv());
        expect(result, Left(CacheFailure("No Cache")));
      });
    });
  });

  group("tv top rated", () {
    group("ketika terhubung ke internet", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test("seharusnya mengecek jika device terhubung ke internet", () async {
        //arrange
        when(mockTvRemoteDataSource.getTopRatedTv())
            .thenAnswer((_) async => []);
        //act
        await repositoryImpl.getTopRatedTv();
        //assert
        verify(mockNetworkInfo.isConnected);
      });
      test("seharusnya mengembalikan data list of TV dari remote ketika sukses",
          () async {
        //arrange
        when(mockTvRemoteDataSource.getTopRatedTv())
            .thenAnswer((_) async => tTvModelList);
        //act
        final result = await repositoryImpl.getTopRatedTv();
        //assert
        verify(mockTvRemoteDataSource.getTopRatedTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      });

      test(
          "seharusnya menyimpan data ke local jika berhasil mengambil data dari remote",
          () async {
        //arrange
        when(mockTvRemoteDataSource.getTopRatedTv())
            .thenAnswer((_) async => tTvModelList);
        //actt
        await repositoryImpl.getTopRatedTv();
        //assert
        verify(mockTvRemoteDataSource.getTopRatedTv());
        verify(mockTvLocalDataSource.cacheTopRatedTv([testTvCache]));
      });

      test("seharusnya mengembalikan failure ketika gagal mendapatkan data",
          () async {
        //arrange
        when(mockTvRemoteDataSource.getTopRatedTv())
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getTopRatedTv();
        //assert
        verify(mockTvRemoteDataSource.getTopRatedTv());
        expect(result, equals(Left(ServerFailure(""))));
      });
    });

    group("ketika tidak terhubung ke internet", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test("seharusnya mengembalikan data dari lokal jika ada", () async {
        //arrange
        when(mockTvLocalDataSource.getCacheTopRatedTv())
            .thenAnswer((_) async => [testTvCache]);

        //act
        final result = await repositoryImpl.getTopRatedTv();
        //assert
        verify(mockTvLocalDataSource.getCacheTopRatedTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvFromCache]);
      });

      test(
          "seharusnya mengembalikan exception cachefailure ketika tidak ada data dicache",
          () async {
        //arrange
        when(mockTvLocalDataSource.getCacheTopRatedTv())
            .thenThrow(CacheException('No Cache'));
        //act
        final result = await repositoryImpl.getTopRatedTv();
        //assert
        verify(mockTvLocalDataSource.getCacheTopRatedTv());
        expect(result, Left(CacheFailure("No Cache")));
      });
    });
  });

  group('Get Tv Recommendations', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
    final tId = 1399;

    test('seharusnya mengembalikan list tv ketika sukses mendapatkan data',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvRecommendations(tId))
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repositoryImpl.getTvRecommendations(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test('seharusnya mengembalikan failure ketika gagal', () async {
      // arrange
      when(mockTvRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repositoryImpl.getTvRecommendations(tId);
      // assertbuild runner
      verify(mockTvRemoteDataSource.getTvRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    group("no internet", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test(
          'seharusnya mentgembalikan koneksi failure ketika tidak ada internet',
          () async {
        // arrange
        when(mockTvRemoteDataSource.getTvRecommendations(tId))
            .thenThrow(ConnectionFailure('no network'));
        // act
        final result = await repositoryImpl.getTvRecommendations(tId);
        // assert
        //verify(mockTvRemoteDataSource.getTvRecommendations(tId));
        expect(result, equals(Left(ConnectionFailure('no network'))));
      });
    });
  });
  group('watchlist', () {
    test('mengembalikan jika data tidak ada', () async {
      // arrange
      final tId = 1;
      when(mockTvLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repositoryImpl.isInWatchList(tId);
      // assert
      expect(result, false);
    });

    test('seharusnya mengembalikan pesan sukses ketika berhasil hapus',
        () async {
      // arrange
      when(mockTvLocalDataSource.removeTvWatchList(testTvTableCache))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repositoryImpl.removeWatchListTv(testTvDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('seharusnye mengembalikan DatabaseFailure ketika hapus gagal',
        () async {
      // arrange
      when(mockTvLocalDataSource.removeTvWatchList(testTvTableCache))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repositoryImpl.removeWatchListTv(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });

    final testTv = Tv.watchList(
        id: 94997,
        name: "House of the Dragon",
        posterPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
        overview:
            "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.");

    test('seharusnya mengembalikan list tv', () async {
      // arrange
      when(mockTvLocalDataSource.getWatchListTv())
          .thenAnswer((_) async => [testTvCache]);
      // act
      final result = await repositoryImpl.getWatchlistTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testTv]);
    });
  });

  group('Seach Tv', () {
    final tQuery = 'game';

    test('seharusnya mengembalikan list tv ketika berhasil', () async {
      // arrange
      when(mockTvRemoteDataSource.searchTv(tQuery))
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repositoryImpl.searchTv(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('seharusnay mengembalikan ServerFailure ketika gagal', () async {
      // arrange
      when(mockTvRemoteDataSource.searchTv(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repositoryImpl.searchTv(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'sseharusnye mengembalikan connectionfailure ketika tidak ada internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.searchTv(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repositoryImpl.searchTv(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });
}
