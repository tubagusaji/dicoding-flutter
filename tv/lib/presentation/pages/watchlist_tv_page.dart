import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc.dart';

import '../widgets/tv_card_list.dart';

class WatchlistTvPage extends StatefulWidget {

  @override
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>context.read<TvWatchlistBloc>().add(FetchTvWatchListEvent()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    BlocProvider.of<TvWatchlistBloc>(context, listen:  false).add(FetchTvWatchListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvWatchlistBloc, TvWatchlistState>(
          builder: (context, state) {
            if (state is TvWatchListLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvWatchListLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvWatchList[index];
                  return TvCard(tv);
                },
                itemCount: state.tvWatchList.length,
              );
            } else if(state is TvWatchListErrorState){
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
