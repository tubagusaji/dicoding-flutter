import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/save_wacthlist_tv.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchListTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SaveWatchListTv(mockTvRepository);
  });

  test('seharusnya menyimpan tv ke repository', () async {
    // arrange
    when(mockTvRepository.saveWatchListTv(testTvDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTvRepository.saveWatchListTv(testTvDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
