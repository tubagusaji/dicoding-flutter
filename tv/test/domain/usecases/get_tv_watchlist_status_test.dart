import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_watchlist_status.dart';

import '../../helpers/test_helper.mocks.dart';


void main() {
  late GetTvWatchListStatus usecase;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    usecase = GetTvWatchListStatus(repository);
  });

  final tId = 1399;

  test('seharusnya mendapatkan status watchlist tv dari repository', () async {
    // arrange
    when(repository.isInWatchList(tId)).thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, true);
  });
}
