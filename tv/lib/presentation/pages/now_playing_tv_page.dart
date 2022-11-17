import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_now_playing_bloc.dart';

import '../widgets/tv_card_list.dart';

class NowPlayingTvPage extends StatefulWidget {

  @override
  _NowPlayingTvPageState createState() => _NowPlayingTvPageState();
}

class _NowPlayingTvPageState extends State<NowPlayingTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TvNowPlayingBloc>().add(FetchTvNowPlayingEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvNowPlayingBloc, TvNowPlayingState>(
          builder: (context, state) {
            if (state is TvNowPlayingLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvNowPlayingLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvNowPlayingList[index];
                  return TvCard(tv);
                },
                itemCount: state.tvNowPlayingList.length,
              );
            } else if(state is TvNowPlayingErrorState){
              return Center(
                key: Key('error_message'),
                child: Text(state.msg),
              );
            }

            return Center(child: const SizedBox(),);
          },
        ),
      ),
    );
  }
}
