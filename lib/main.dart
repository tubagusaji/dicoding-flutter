import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:core/cubit/tab_menu_cubit.dart';
import 'package:core/utils/http_ssl_pinning.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_list_bloc.dart';
import 'package:movie/presentation/bloc/movie_popular_bloc.dart';
import 'package:movie/presentation/bloc/movie_recommendations_bloc.dart';
import 'package:movie/presentation/bloc/movie_top_rated_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:movie/presentation/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/search.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_list_bloc.dart';
import 'package:tv/presentation/bloc/tv_now_playing_bloc.dart';
import 'package:tv/presentation/bloc/tv_popular_bloc.dart';
import 'package:tv/presentation/bloc/tv_search_bloc.dart';
import 'package:tv/presentation/bloc/tv_top_rated_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc.dart';
import 'package:tv/presentation/pages/home_tv_page.dart';
import 'package:tv/presentation/pages/now_playing_tv_page.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';
import 'package:tv/presentation/pages/search_tv_page.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/presentation/pages/watchlist_tv_page.dart';
import 'injection.dart' as di;
import 'firebase_options.dart';

void main()async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HttpSSLPinning.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<TabMenuNotifier>(),
        // ),
        BlocProvider(create: (_) => di.locator<TabMenuCubit>()),
        BlocProvider(create: (_) => di.locator<MovieListBloc>()),
        BlocProvider(create: (_) => di.locator<MovieDetailBloc>()),
        BlocProvider(create: (_) => di.locator<MovieRecommendationsBloc>()),
        BlocProvider(create: (_) => di.locator<SearchBloc>()),
        BlocProvider(create: (_) => di.locator<MoviePopularBloc>()),
        BlocProvider(create: (_) => di.locator<MovieTopRatedBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistMovieBloc>()),
        BlocProvider(create: (_) => di.locator<TvWatchlistBloc>()),
        BlocProvider(create: (_) => di.locator<TvSearchBloc>()),
        BlocProvider(create: (_) => di.locator<TvDetailBloc>()),
        BlocProvider(create: (_) => di.locator<TvListBloc>()),
        BlocProvider(create: (_) => di.locator<TvNowPlayingBloc>()),
        BlocProvider(create: (_) => di.locator<TvPopularBloc>()),
        BlocProvider(create: (_) => di.locator<TvTopRatedBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: Material(
            child: CustomDrawer(
          content: HomeMoviePage(),
        )),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case '/tv':
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case POPULAR_MOVIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TOP_RATED_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MOVIE_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SEARCH_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WATCHLIST_MOVIE_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case ABOUT_ROUTE:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case POPULAR_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());
            case TOP_RATED_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
            case NOW_PLAYING_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => NowPlayingTvPage());
            case DETAIL_TV_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case WATCHLIST_TV_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistTvPage());
            case SEARCH_TV_ROUTE:
              return MaterialPageRoute(builder: (_) => SearchTvPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
