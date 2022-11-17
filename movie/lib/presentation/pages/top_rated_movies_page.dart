import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_top_rated_bloc.dart';

import '../widgets/movie_card_list.dart';

class TopRatedMoviesPage extends StatefulWidget {

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<MovieTopRatedBloc>().add(FetchMovieTopRatedEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
          builder: (context, state) {
            if (state is MovieTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieTopRatedLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return MovieCard(movie);
                },
                itemCount: state.movies.length,
              );
            } else if(state is MovieTopRatedError){
              return Center(
                key: Key('error_message'),
                child: Text(state.msg),
              );
            }

            return const Center(
              child: SizedBox(),
            );
          },
        ),
      ),
    );
  }
}
