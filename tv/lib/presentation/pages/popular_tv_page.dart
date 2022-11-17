import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_popular_bloc.dart';

import '../widgets/tv_card_list.dart';

class PopularTvPage extends StatefulWidget {

  @override
  _PopularTvPageState createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TvPopularBloc>().add(FetchTvPopularEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvPopularBloc, TvPopularState>(
          builder: (context, state) {
            if (state is TvPopularLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvPopularLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvPopularList[index];
                  return TvCard(tv);
                },
                itemCount: state.tvPopularList.length,
              );
            } else if (state is TvPopularErrorState){
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
