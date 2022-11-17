import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/watchlist_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchlistMovies, GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistMovieBloc = WatchlistMovieBloc(
        saveWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist,
        getWatchlistMovies: mockGetWatchlistMovies,
        getWatchListStatus: mockGetWatchListStatus);
  });

  test('initial state', () {
    expect(watchlistMovieBloc.state, WatchlistMovieInitial());
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>("get data from usecase",
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right([testWatchlistMovie]));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(FetchWatchListMovie()),
      expect: () => [
            WatchListMovieLoadingState(),
            WatchListMovieLoadedState([testWatchlistMovie])
          ]);

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      "should return error when data is unsuccessful",
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(FetchWatchListMovie()),
      expect: () => [
            WatchListMovieLoadingState(),
            const WatchListMovieErrorState("Can't get data"),
          ]);

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        "should get the watchlist status",
        build: () {
          when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(const LoadWatchListStatus(1)),
        expect: () => [const LoadWatchListStatusState(true)]);

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should execute save watchlist when function called',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Success'));
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(AddToWatchListMovie(testMovieDetail)),
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
        });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should execute remove watchlist when function called',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Removed'));
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(RemoveToWatchListMovie(testMovieDetail)),
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
        });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        "should update watchlist status when add watchlist success",
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Added to Watchlist'));
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(AddToWatchListMovie(testMovieDetail)),
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        },
        expect: () => [
              const WatchListStatusSuccessMessageState('Added to Watchlist'),
              const LoadWatchListStatusState(true),
            ]);

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        "should update watchlist message when add watchlist failed",
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(AddToWatchListMovie(testMovieDetail)),
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        },
        expect: () => [
          const WatchListStatusErrorMessageState('Failed'),
          const LoadWatchListStatusState(false),
        ]);
}
