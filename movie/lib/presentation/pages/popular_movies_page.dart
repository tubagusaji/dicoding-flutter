import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_popular_bloc.dart';
import 'package:provider/provider.dart';

import '../widgets/movie_card_list.dart';

class PopularMoviesPage extends StatefulWidget {
  const PopularMoviesPage({Key? key}) : super(key: key);


  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<MoviePopularBloc>().add(FetchMoviePopular()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoviePopularBloc, MoviePopularState>(
          builder: (context, state) {
            if (state is MoviePopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MoviePopularLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.popularMovies[index];
                  return MovieCard(movie);
                },
                itemCount: state.popularMovies.length,
              );
            } else if(state is MoviePopularError){
              return Center(
                key: Key('error_message'),
                child: Text(state.msg),
              );
            }

            return const Center(child: SizedBox(),);
          },
        ),
      ),
    );
  }
}
