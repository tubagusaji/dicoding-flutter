import 'package:core/core.dart';
import 'package:core/cubit/tab_menu_cubit.dart';
import 'package:core/utils/http_ssl_pinning.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_list_bloc.dart';
import 'package:movie/presentation/bloc/movie_popular_bloc.dart';
import 'package:movie/presentation/bloc/movie_recommendations_bloc.dart';
import 'package:movie/presentation/bloc/movie_top_rated_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/search.dart';
import 'package:tv/data/datasources/db/database_helper.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recomendations.dart';
import 'package:tv/domain/usecases/get_tv_watchlist_status.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_wacthlist_tv.dart';
import 'package:tv/domain/usecases/search_tv.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_list_bloc.dart';
import 'package:tv/presentation/bloc/tv_now_playing_bloc.dart';
import 'package:tv/presentation/bloc/tv_popular_bloc.dart';
import 'package:tv/presentation/bloc/tv_search_bloc.dart';
import 'package:tv/presentation/bloc/tv_top_rated_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc.dart';

final locator = GetIt.instance;

void init() {
//bloc movie
  locator.registerFactory(
    () => MovieListBloc(
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(() => SearchBloc(locator()));
  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieRecommendationsBloc(
      getMovieRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => MoviePopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieTopRatedBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(
      removeWatchlist: locator(),
      saveWatchlist: locator(),
      getWatchListStatus: locator(),
      getWatchlistMovies: locator(),
    ),
  );
  // provider

  locator.registerFactory(() => TabMenuCubit());

  locator.registerFactory(() => TvListBloc(
      getNowPlayingTv: locator(),
      getPopularTv: locator(),
      getTopRatedTv: locator()));

  locator.registerFactory(() => TvDetailBloc(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getTvWatchListStatus: locator(),
      saveWatchListTv: locator(),
      removeWatchListTv: locator()));

  locator.registerFactory(
    () => TvNowPlayingBloc(
      getNowPlayingTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvPopularBloc(getPopularTv: locator()),
  );
  locator.registerFactory(
    () => TvTopRatedBloc(getTopRatedTv: locator()),
  );

  locator.registerFactory(() => TvWatchlistBloc(getWatchListTv: locator()));
  locator.registerFactory(() => TvSearchBloc(searchTv: locator()));

  // use case
  //movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  //tv
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => GetTvWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchListTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchListTv(locator()));
  locator.registerLazySingleton(() => GetWatchListTv(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));

  // repository
  //movie
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
        networkInfo: locator()),
  );
  //tv
  locator.registerLazySingleton<TvRepository>(() => TvRepositoryImpl(
      remoteDataSource: locator(),
      networkInfo: locator(),
      localDataSource: locator()));

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  //tv
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(tvDatabaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  //network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
  locator.registerLazySingleton(() => DataConnectionChecker());
}
