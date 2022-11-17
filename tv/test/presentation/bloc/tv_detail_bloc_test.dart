import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recomendations.dart';
import 'package:tv/domain/usecases/get_tv_watchlist_status.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_wacthlist_tv.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';

import '../../dummy_data/dummy_object.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetTvWatchListStatus,
  SaveWatchListTv,
  RemoveWatchListTv,
])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecomendations;
  late MockGetTvWatchListStatus mockGetTvWatchListStatus;
  late MockSaveWatchListTv mockSaveWatchlistTv;
  late MockRemoveWatchListTv mockRemoveWatchlistTv;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvWatchListStatus = MockGetTvWatchListStatus();
    mockGetTvRecomendations = MockGetTvRecommendations();
    mockSaveWatchlistTv = MockSaveWatchListTv();
    mockRemoveWatchlistTv = MockRemoveWatchListTv();
    tvDetailBloc = TvDetailBloc(
        getTvDetail: mockGetTvDetail,
        getTvRecommendations: mockGetTvRecomendations,
        getTvWatchListStatus: mockGetTvWatchListStatus,
        saveWatchListTv: mockSaveWatchlistTv,
        removeWatchListTv: mockRemoveWatchlistTv);
  });

  final tId = 1399;
  final tvDetailStateInit = TvDetailState.initial();

  test('initial state', () {
    expect(tvDetailBloc.state, tvDetailStateInit);
  });

  void _arrangeUsecase() {
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    when(mockGetTvRecomendations.execute(tId))
        .thenAnswer((_) async => Right(tTvList));
  }

  group("get Tv Detail and Tv Recommendations", () {
    blocTest<TvDetailBloc, TvDetailState>(
        "seharusnya dapet data dari usecase ketika semuanya sukses",
        build: () {
          when(mockGetTvDetail.execute(tId))
              .thenAnswer((_) async => Right(testTvDetail));
          when(mockGetTvRecomendations.execute(tId))
              .thenAnswer((_) async => const Right(<Tv>[]));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(FetchTvDetail(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => {
              tvDetailStateInit.copyWith(tvDetailState: RequestState.Loading),
              tvDetailStateInit.copyWith(
                  tvDetailState: RequestState.Loaded,
                  tvDetail: testTvDetail,
                  tvRecommendations: <Tv>[],
                  tvRecommendationsState: RequestState.Loading,
                  msg: ''),
              tvDetailStateInit.copyWith(
                  tvDetailState: RequestState.Loaded,
                  tvRecommendationsState: RequestState.Loaded,
                  tvRecommendations: <Tv>[],
                  msg: '')
            },
        verify: (bloc) {
          verify(mockGetTvDetail.execute(tId));
          verify(mockGetTvRecomendations.execute(tId));
        });

    blocTest<TvDetailBloc, TvDetailState>(
        "seharusnya dapet data tv detail dari usecase ketika sukses,"
        " dan menegmbalikan error untuk tv recommendations",
        build: () {
          when(mockGetTvDetail.execute(tId))
              .thenAnswer((_) async => Right(testTvDetail));
          when(mockGetTvRecomendations.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(FetchTvDetail(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => {
              tvDetailStateInit.copyWith(tvDetailState: RequestState.Loading),
              tvDetailStateInit.copyWith(
                  tvDetailState: RequestState.Loaded,
                  tvDetail: testTvDetail,
                  tvRecommendations: <Tv>[],
                  tvRecommendationsState: RequestState.Loading,
                  msg: ''),
              tvDetailStateInit.copyWith(
                  tvDetailState: RequestState.Loaded,
                  tvRecommendationsState: RequestState.Error,
                  tvRecommendations: <Tv>[],
                  msg: 'Failed')
            },
        verify: (bloc) {
          verify(mockGetTvDetail.execute(tId));
          verify(mockGetTvRecomendations.execute(tId));
        });
  });


  group('Watchlist Tv', () {

  blocTest<TvDetailBloc, TvDetailState>(
    'seharu7snya mengembalikan status whactlisttv',
    build: () {
      when(mockGetTvWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      when(mockGetTvRecomendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(LoadWatchListTvStatus(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      tvDetailStateInit.copyWith(
        isInTvWatchList: true,
      ),
    ],
    verify: (bloc) {
      verify(mockGetTvWatchListStatus.execute(tId));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'seharusnya seave tv ke watchlist ketika fungsi digunakan',
    build: () {
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Berhasil'));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add( AddToWatchListTv(testTvDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      tvDetailStateInit.copyWith(tvWatchlistMessage: 'Berhasil'),
      tvDetailStateInit.copyWith(
        isInTvWatchList: true,
        tvWatchlistMessage: 'Berhasil',
      ),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTv.execute(testTvDetail));
      verify(mockGetTvWatchListStatus.execute(tId));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'seharusmnya menghapus tv detail dari data watchlist sudah digunakan',
    build: () {
      when(mockRemoveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Berhasil dihapus'));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add( RemoveFromWatchListTv(testTvDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      tvDetailStateInit.copyWith(tvWatchlistMessage: 'Berhasil dihapus'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
      verify(mockGetTvWatchListStatus.execute(tId));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'seharusnya update whatclist tv status ketika sukses menambahkan ke watchlist',
    build: () {
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(AddToWatchListTv(testTvDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      tvDetailStateInit.copyWith(tvWatchlistMessage: 'Added to Watchlist'),
      tvDetailStateInit.copyWith(
        isInTvWatchList: true,
        tvWatchlistMessage: 'Added to Watchlist',
      ),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTv.execute(testTvDetail));
      verify(mockGetTvWatchListStatus.execute(tId));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'seharusnya update pesan whatclist tv ketika gagal menambahkan ke watchlist',
    build: () {
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add( AddToWatchListTv(testTvDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      tvDetailStateInit.copyWith(tvWatchlistMessage: 'Failed'),
      tvDetailStateInit.copyWith(
        isInTvWatchList: true,
        tvWatchlistMessage: 'Failed',
      ),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTv.execute(testTvDetail));
      verify(mockGetTvWatchListStatus.execute(tId));
    },
  );

  });

  group('on Error', () {
    blocTest<TvDetailBloc, TvDetailState>(
        "seharusnya mengembalikan error jketika gagal mendapatkan data",
        build: () {
          when(mockGetTvDetail.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          when(mockGetTvRecomendations.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(FetchTvDetail(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => {
              tvDetailStateInit.copyWith(tvDetailState: RequestState.Loading),
              tvDetailStateInit.copyWith(
                  tvDetailState: RequestState.Error, msg: 'Failed'),
            },
        verify: (bloc) {
          verify(mockGetTvDetail.execute(tId));
          verify(mockGetTvRecomendations.execute(tId));
        });
  });
}
