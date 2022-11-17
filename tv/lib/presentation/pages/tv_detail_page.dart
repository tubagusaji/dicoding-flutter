import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';

import '../../domain/entities/genre.dart';
import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';

class TvDetailPage extends StatefulWidget {
  final int id;
  TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailBloc>()..add(FetchTvDetail(widget.id))..add(LoadWatchListTvStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (context, state) {
          if (state.tvDetailState == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.tvDetailState == RequestState.Loaded) {
            final tvDetail = state.tvDetail;
            return SafeArea(
              child: TvDetailContent(
                tvDetail,
                state.tvRecommendations,
                state.isInTvWatchList,
              ),
            );
          } else {
            return Text(state.msg);
          }
        },
      ),
    );
  }
}

class TvDetailContent extends StatelessWidget {
  final TvDetail tv;
  final List<Tv> recommendations;
  final bool isAddedWatchlist;

  TvDetailContent(this.tv, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocListener<TvDetailBloc, TvDetailState>(
      listenWhen: (prev, curr){
        return prev.tvWatchlistMessage != curr.tvWatchlistMessage && curr.tvWatchlistMessage != '';
      },
      listener: (context, state) {
        if (state.tvWatchlistMessage == TvDetailState.addTvSuccesMsg ||
            state.tvWatchlistMessage == TvDetailState.removeTvSuccessMsg) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.tvWatchlistMessage)));
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(state.tvWatchlistMessage),
                );
              });
        }
      },
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
            width: screenWidth,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Container(
            margin: const EdgeInsets.only(top: 48 + 8),
            child: DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: kRichBlack,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 16,
                    right: 16,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tv.name!,
                                style: kHeading5,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (!isAddedWatchlist) {
                                    context
                                        .read<TvDetailBloc>()
                                        .add(AddToWatchListTv(tv));
                                  } else {
                                    context
                                        .read<TvDetailBloc>()
                                        .add(RemoveFromWatchListTv(tv));
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    isAddedWatchlist
                                        ? const Icon(Icons.check)
                                        : const Icon(Icons.add),
                                    const Text('Watchlist'),
                                  ],
                                ),
                              ),
                              Text(
                                _showGenres(tv.genres!),
                              ),
                              Text(
                                _showDuration(tv.episodeRunTime!.isEmpty
                                    ? 0
                                    : tv.episodeRunTime!.first),
                              ),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: tv.voteAverage! / 2,
                                    itemCount: 5,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: kMikadoYellow,
                                    ),
                                    itemSize: 24,
                                  ),
                                  Text('${tv.voteAverage}')
                                ],
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Overview',
                                style: kHeading6,
                              ),
                              Text(
                                tv.overview!,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Recommendations',
                                style: kHeading6,
                              ),
                              BlocBuilder<TvDetailBloc, TvDetailState>(
                                builder: (context, state) {
                                  if (state.tvRecommendationsState ==
                                      RequestState.Loading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state.tvRecommendationsState ==
                                      RequestState.Error) {
                                    return Text(state.msg);
                                  } else if (state.tvRecommendationsState ==
                                      RequestState.Loaded) {
                                    return Container(
                                      height: 150,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final tvRecommendations =
                                              recommendations[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  DETAIL_TV_ROUTE,
                                                  arguments:
                                                      tvRecommendations.id,
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius: const BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      'https://image.tmdb.org/t/p/w500${tvRecommendations.posterPath}',
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: recommendations.length,
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          color: Colors.white,
                          height: 4,
                          width: 48,
                        ),
                      ),
                    ],
                  ),
                );
              },
              // initialChildSize: 0.5,
              minChildSize: 0.25,
              // maxChildSize: 1.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: kRichBlack,
              foregroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name! + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
