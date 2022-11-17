import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_recomendations.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendations usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvRecommendations(mockTvRepository);
  });

  final tId = 1399;
  test("seharusnya mendapatkan list tv recommendations dari repository",
      () async {
    //arrange
    when(mockTvRepository.getTvRecommendations(tId))
        .thenAnswer((_) async => Right(tTvList));

    //act
    final result = await usecase.execute(tId);
    //assert
    expect(result, Right(tTvList));
  });
}
