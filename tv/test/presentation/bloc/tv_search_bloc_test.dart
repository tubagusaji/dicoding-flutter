import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/search_tv.dart';
import 'package:tv/presentation/bloc/tv_search_bloc.dart';

import '../../dummy_data/dummy_object.dart';
import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late TvSearchBloc tvSearchBloc;
  late MockSearchTv mockSearchTv;


  final tQuery = 'House of the Dragon';

  setUp(() {
    mockSearchTv = MockSearchTv();
    tvSearchBloc = TvSearchBloc(searchTv: mockSearchTv);
  });

  test("initial state", (){
    expect(tvSearchBloc.state, TvSearchInitial());
  });

  blocTest<TvSearchBloc, TvSearchState>("mendapatakan data dari usecase ketika berhasil", build: (){
    when(mockSearchTv.execute(tQuery)).thenAnswer((_) async=> Right(tTvList));
    return tvSearchBloc;
  },
  act: (bloc) => bloc.add(TvSearchByQuery(tQuery)),
    wait: const Duration(seconds: 1),
    expect: ()=>[
      TvSearchLoadingState(),
      TvSearchLoadedState(tTvList)
    ],
    verify: (bloc){
    verify(mockSearchTv.execute(tQuery));
    }
  );

  blocTest<TvSearchBloc, TvSearchState>("mendapatakan error dari usecase ketika gagal", build: (){
    when(mockSearchTv.execute(tQuery)).thenAnswer((_) async=> Left(ServerFailure("failed")));
    return tvSearchBloc;
  },
      act: (bloc) => bloc.add(TvSearchByQuery(tQuery)),
      wait: const Duration(seconds: 1),
      expect: ()=>[
        TvSearchLoadingState(),
        const TvSearchErrorState("failed")
      ],
      verify: (bloc){
        verify(mockSearchTv.execute(tQuery));
      }
  );
}
