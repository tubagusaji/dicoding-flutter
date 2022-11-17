
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTopRatedTv(mockTvRepository);
  });

  final tTvList = <Tv>[];

  group("get top rated tv", () {
    test("seharusnya mendapatkan list tv top rating", () async {
      //arrange
      when(mockTvRepository.getTopRatedTv())
          .thenAnswer((_) async => Right(tTvList));

      //act
      final result = await usecase.execute();
      //assert
      expect(result, Right(tTvList));
    });
  });
}
