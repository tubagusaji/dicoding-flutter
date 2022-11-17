import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/presentation/bloc/tv_now_playing_bloc.dart';

import '../../dummy_data/dummy_object.dart';
import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late TvNowPlayingBloc tvNowPlayingBloc;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    tvNowPlayingBloc = TvNowPlayingBloc(getNowPlayingTv: mockGetNowPlayingTv);
  });

  test("initial state", () {
    expect(tvNowPlayingBloc.state, TvNowPlayingInitial());
  });

  blocTest<TvNowPlayingBloc, TvNowPlayingState>(
      "seharusnya mendapatkan data dari usecase ketika berhasil",
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return tvNowPlayingBloc;
      },
      act: (bloc) => bloc.add(FetchTvNowPlayingEvent()),
      expect: () =>
          [TvNowPlayingLoadingState(), TvNowPlayingLoadedState(tTvList)],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      });
  blocTest<TvNowPlayingBloc, TvNowPlayingState>(
      "seharusnya mendapatkan error dari usecase ketika gagal",
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Left(ServerFailure("failed")));
        return tvNowPlayingBloc;
      },
      act: (bloc) => bloc.add(FetchTvNowPlayingEvent()),
      expect: () =>
      [TvNowPlayingLoadingState(), const TvNowPlayingErrorState("failed")],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      });

}
