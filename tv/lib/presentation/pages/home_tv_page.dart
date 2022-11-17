import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/bloc/tv_list_bloc.dart';

import '../../domain/entities/tv.dart';

class HomeTvPage extends StatefulWidget {
  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TvListBloc>()
      ..add(FetchTvNowPlaying())
      ..add(FetchTvPopular())
      ..add(FetchTvTopRated()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: const Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_TV_ROUTE);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () =>
                    Navigator.pushNamed(context, NOW_PLAYING_TV_ROUTE),
              ),
              BlocBuilder<TvListBloc, TvListState>(builder: (context, state) {
                if (state.nowPlayingTvState == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.nowPlayingTvState == RequestState.Loaded) {
                  return TvList(state.nowPlayingTvList);
                } else if(state.nowPlayingTvState == RequestState.Error){
                  return Text(state.msg);
                } else {
                return const Center(child: SizedBox(),);
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, POPULAR_TV_ROUTE),
              ),
              BlocBuilder<TvListBloc, TvListState>(builder: (context, state) {
                if (state.popularTvState == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.popularTvState == RequestState.Loaded) {
                  return TvList(state.popularTvList);
                } else if(state.popularTvState == RequestState.Error){
                  return Text(state.msg);
                }
                return Center(child: const SizedBox(),);
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TOP_RATED_TV_ROUTE),
              ),
              BlocBuilder<TvListBloc, TvListState>(builder: (context, state) {
                if (state.topRatedTvState == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.topRatedTvState == RequestState.Loaded) {
                  return TvList(state.topRatedTvList);
                } else if(state.topRatedTvState == RequestState.Error){
                  return Text(state.msg);
                }

                return const Center(child: SizedBox(),);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvList;

  TvList(this.tvList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvList[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DETAIL_TV_ROUTE,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvList.length,
      ),
    );
  }
}
