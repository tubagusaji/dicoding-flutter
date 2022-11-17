
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';

import '../../helpers/test_helper.mocks.dart';


void main() {
  late GetPopularTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetPopularTv(mockTvRepository);
  });

  final tTvList = <Tv>[];

  group("get popular tv", () {
    test("seharusnya mendapatkan list tv popular", () async {
      //arrange
      when(mockTvRepository.getPopularTv())
          .thenAnswer((_) async => Right(tTvList));

      //act
      final result = await usecase.execute();
      //assert
      expect(result, Right(tTvList));
    });
  });
}
