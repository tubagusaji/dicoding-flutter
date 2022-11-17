import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/presentation/bloc/tv_popular_bloc.dart';

import '../../dummy_data/dummy_object.dart';
import 'tv_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late TvPopularBloc tvPopularBloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    tvPopularBloc = TvPopularBloc(getPopularTv: mockGetPopularTv);
  });

  test("initial state", () {
    expect(tvPopularBloc.state, TvPopularInitial());
  });

  blocTest<TvPopularBloc, TvPopularState>(
      "seharusnya mendapatkan data dari usecase ketika berhasil",
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return tvPopularBloc;
      },
      act: (bloc) => bloc.add(FetchTvPopularEvent()),
      expect: () => [TvPopularLoadingState(), TvPopularLoadedState(tTvList)],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      });

  blocTest<TvPopularBloc, TvPopularState>(
      "seharusnya mendapatkan error dari usecase ketika gagal",
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvPopularBloc;
      },
      act: (bloc) => bloc.add(FetchTvPopularEvent()),
      expect: () => [TvPopularLoadingState(), TvPopularErrorState('Server Failure')],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      });
}
