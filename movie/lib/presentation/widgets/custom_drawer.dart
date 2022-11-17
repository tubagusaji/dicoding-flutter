import 'package:core/core.dart';
import 'package:core/cubit/tab_menu_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/pages/home_tv_page.dart';

import '../pages/home_movie_page.dart';

class CustomDrawer extends StatefulWidget {
  final Widget content;

  CustomDrawer({
    required this.content,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  Widget _buildDrawer() {
    return Container(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
                // backgroundImage: CachedNetworkImage(
                //   imageUrl:
                //       'https://raw.githubusercontent.com/dicodingacademy/assets/main/flutter_expert_academy/dicoding-icon.png',
                //   placeholder: (context, url) => Center(
                //     child: CircularProgressIndicator(),
                //   ),
                //   errorWidget: (context, url, error) => Icon(Icons.error),
                // ) as ImageProvider,
                ),
            accountName: Text('Dicoding'),
            accountEmail: Text('Ditoonton@dicoding.com'),
          ),
          ListTile(
            onTap: () {
              // Provider.of<TabMenuNotifier>(context, listen: false)
              //     .currentMenuTab = MenuTabState.Movie;
              context.read<TabMenuCubit>().changeMenu(MenuTabState.Movie);
              _animationController.reverse();
            },
            leading: Icon(Icons.movie),
            title: Text('Movies'),
          ),
          ListTile(
            onTap: () {
              // Provider.of<TabMenuNotifier>(context, listen: false)
              //     .currentMenuTab = MenuTabState.Tv;
              context.read<TabMenuCubit>().changeMenu(MenuTabState.Tv);

              _animationController.reverse();
            },
            leading: Icon(Icons.tv),
            title: Text('TV'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, WATCHLIST_MOVIE_ROUTE);
              _animationController.reverse();
            },
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist Movie'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, WATCHLIST_TV_ROUTE);
              _animationController.reverse();
            },
            leading: Icon(Icons.save_outlined),
            title: Text('Watchlist TV'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, ABOUT_ROUTE);
              _animationController.reverse();
            },
            leading: Icon(Icons.save_outlined),
            title: Text('About'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          double slide = 255.0 * _animationController.value;
          double scale = 1 - (_animationController.value * 0.3);

          return Stack(
            children: [
              _buildDrawer(),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: BlocBuilder<TabMenuCubit, TabMenuState>(
                    builder: (context, state) {
                  if (state.tab == MenuTabState.Movie) {
                    return HomeMoviePage();
                  } else if (state.tab == MenuTabState.Tv) {
                    return HomeTvPage();
                  }
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
