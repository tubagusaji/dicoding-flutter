import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/presentation/bloc/tv_list_bloc.dart';

import '../../dummy_data/dummy_object.dart';
import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv, GetPopularTv, GetTopRatedTv])
void main() {
  late TvListBloc tvListBloc;
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late MockGetPopularTv mockGetPopularTv;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    mockGetPopularTv = MockGetPopularTv();
    mockGetTopRatedTv = MockGetTopRatedTv();
    tvListBloc = TvListBloc(
        getNowPlayingTv: mockGetNowPlayingTv,
        getPopularTv: mockGetPopularTv,
        getTopRatedTv: mockGetTopRatedTv);
  });

  final tvListStateInit = TvListState.initial();

  group("now playing tv", () {
    test("initialState harusnya empty", () {
      expect(tvListBloc.state, tvListStateInit);
    });

    blocTest<TvListBloc, TvListState>(
        "seharusnya mengembalikan data dari usecase",
        build: () {
          when(mockGetNowPlayingTv.execute())
              .thenAnswer((_) async => Right(tTvList));
          return tvListBloc;
        },
        act: (bloc) => bloc.add(FetchTvNowPlaying()),
        expect: () => [
              tvListStateInit.copyWith(nowPlayingTvState: RequestState.Loading),
              tvListStateInit.copyWith(
                  nowPlayingTvState: RequestState.Loaded,
                  nowPlayingTvList: tTvList)
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingTv.execute());
        });

    blocTest<TvListBloc, TvListState>(
        "seharusnya mengembalikan error ketika tidak berhasil",
        build: () {
          when(mockGetNowPlayingTv.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return tvListBloc;
        },
        act: (bloc) => bloc.add(FetchTvNowPlaying()),
        expect: () => [
              tvListStateInit.copyWith(nowPlayingTvState: RequestState.Loading),
              tvListStateInit.copyWith(
                  nowPlayingTvState: RequestState.Error, msg: 'Server Failure')
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingTv.execute());
        });
  });
  group("now popular tv", () {
    test("initialState harusnya empty", () {
      expect(tvListBloc.state, tvListStateInit);
    });

    blocTest<TvListBloc, TvListState>(
        "seharusnya mengembalikan data dari usecase",
        build: () {
          when(mockGetPopularTv.execute())
              .thenAnswer((_) async => Right(tTvList));
          return tvListBloc;
        },
        act: (bloc) => bloc.add(FetchTvPopular()),
        expect: () => [
          tvListStateInit.copyWith(popularTvState: RequestState.Loading),
          tvListStateInit.copyWith(
              popularTvState: RequestState.Loaded,
              popularTvList: tTvList)
        ],
        verify: (bloc) {
          verify(mockGetPopularTv.execute());
        });

    blocTest<TvListBloc, TvListState>(
        "seharusnya mengembalikan error ketika tidak berhasil",
        build: () {
          when(mockGetPopularTv.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return tvListBloc;
        },
        act: (bloc) => bloc.add(FetchTvPopular()),
        expect: () => [
          tvListStateInit.copyWith(popularTvState: RequestState.Loading),
          tvListStateInit.copyWith(
              popularTvState: RequestState.Error, msg: 'Server Failure')
        ],
        verify: (bloc) {
          verify(mockGetPopularTv.execute());
        });
  });

  group("top rated tv", () {
    test("initialState harusnya empty", () {
      expect(tvListBloc.state,tvListStateInit);
    });

    blocTest<TvListBloc, TvListState>(
        "seharusnya mengembalikan data dari usecase",
        build: () {
          when(mockGetTopRatedTv.execute())
              .thenAnswer((_) async => Right(tTvList));
          return tvListBloc;
        },
        act: (bloc) => bloc.add(FetchTvTopRated()),
        expect: () => [
          tvListStateInit.copyWith(topRatedTvState: RequestState.Loading),
          tvListStateInit.copyWith(
              topRatedTvState: RequestState.Loaded,
              topRatedTvList: tTvList)
        ],
        verify: (bloc) {
          verify(mockGetTopRatedTv.execute());
        });

    blocTest<TvListBloc, TvListState>(
        "seharusnya mengembalikan error ketika tidak berhasil",
        build: () {
          when(mockGetTopRatedTv.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return tvListBloc;
        },
        act: (bloc) => bloc.add(FetchTvTopRated()),
        expect: () => [
          tvListStateInit.copyWith(topRatedTvState: RequestState.Loading),
          tvListStateInit.copyWith(
              topRatedTvState: RequestState.Error, msg: 'Server Failure')
        ],
        verify: (bloc) {
          verify(mockGetTopRatedTv.execute());
        });
  });
}
