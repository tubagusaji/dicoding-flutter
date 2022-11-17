
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';

import '../../helpers/test_helper.mocks.dart';


void main() {
  late GetNowPlayingTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetNowPlayingTv(mockTvRepository);
  });

  final tTvList = <Tv>[];

  test("seharusnya mendapatkan list tv dari repository", () async {
    //arrange
    when(mockTvRepository.getNowPlayingTv())
        .thenAnswer((_) async => Right(tTvList));
    //act
    final result = await usecase.execute();
    //assert
    expect(result, Right(tTvList));
  });
}
