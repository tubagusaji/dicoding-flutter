import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_top_rated_bloc.dart';

import '../widgets/tv_card_list.dart';

class TopRatedTvPage extends StatefulWidget {

  @override
  _TopRatedTvPageState createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TvTopRatedBloc>().add(FetchTvTopRatedEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
          builder: (context, state) {
            if (state is TvTopRatedLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvTopRatedLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvTopRatedList[index];
                  return TvCard(tv);
                },
                itemCount: state.tvTopRatedList.length,
              );
            } else if (state is TvTopRatedErrorState){
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
