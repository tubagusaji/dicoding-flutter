import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc.dart';

import '../../dummy_data/dummy_object.dart';
import 'tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListTv])
void main() {
  late TvWatchlistBloc tvWatchlistBloc;
  late MockGetWatchListTv mockGetWatchListTv;

  setUp(() {
    mockGetWatchListTv = MockGetWatchListTv();
    tvWatchlistBloc = TvWatchlistBloc(getWatchListTv: mockGetWatchListTv);
  });

  test("initial state", () {
    expect(tvWatchlistBloc.state, TvWatchlistInitial());
  });

  blocTest<TvWatchlistBloc, TvWatchlistState>(
      "seharusnya mendapatkan data dari usecase ketika berhasil",
      build: () {
        when(mockGetWatchListTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(FetchTvWatchListEvent()),
      expect: () =>
          [TvWatchListLoadingState(), TvWatchListLoadedState(tTvList)],
      verify: (bloc) {
        verify(mockGetWatchListTv.execute());
      });

  blocTest<TvWatchlistBloc, TvWatchlistState>(
      "seharusnya mendapatkan eror dari usecase ketika gagal",
      build: () {
        when(mockGetWatchListTv.execute())
            .thenAnswer((_) async => Left(ServerFailure("failed")));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(FetchTvWatchListEvent()),
      expect: () =>
      [TvWatchListLoadingState(), const TvWatchListErrorState("failed")],
      verify: (bloc) {
        verify(mockGetWatchListTv.execute());
      });
}
