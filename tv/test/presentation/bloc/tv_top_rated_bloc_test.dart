import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/presentation/bloc/tv_top_rated_bloc.dart';

import '../../dummy_data/dummy_object.dart';
import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TvTopRatedBloc tvTopRatedBloc;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    tvTopRatedBloc = TvTopRatedBloc(getTopRatedTv: mockGetTopRatedTv);
  });

  test("initial state", () {
    expect(tvTopRatedBloc.state, TvTopRatedInitial());
  });

  blocTest<TvTopRatedBloc, TvTopRatedState>(
      "seharusnya mendapatkan data dari usecase ketika berhasil",
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return tvTopRatedBloc;
      },
      act: (bloc) => bloc.add(FetchTvTopRatedEvent()),
      expect: () => [TvTopRatedLoadingState(), TvTopRatedLoadedState(tTvList)],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      });
  blocTest<TvTopRatedBloc, TvTopRatedState>(
      "seharusnya mendapatkan error dari usecase ketika gagal",
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async =>Left(ServerFailure("failed")));
        return tvTopRatedBloc;
      },
      act: (bloc) => bloc.add(FetchTvTopRatedEvent()),
      expect: () => [TvTopRatedLoadingState(), const TvTopRatedErrorState("failed")],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      });

}
