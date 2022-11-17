import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchListTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveWatchListTv(mockTvRepository);
  });

  test('seharusnya menghabus data dari repository', () async {
    // arrange
    when(mockTvRepository.removeWatchListTv(testTvDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTvRepository.removeWatchListTv(testTvDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
