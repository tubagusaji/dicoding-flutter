import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';

import '../pages/watchlist_page.dart';

class AppDrawer extends StatelessWidget {
  final void Function() onMovieClick;
  final void Function() onTvClick;
  const AppDrawer({
    Key? key,
    required this.onMovieClick,
    required this.onTvClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Dicoding'),
            accountEmail: Text('@Dicoding.com'),
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Movies'),
            onTap: onMovieClick,
          ),
          ListTile(
            leading: const Icon(Icons.tv),
            title: const Text('Tv Series'),
            onTap: onTvClick,
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistPage.routeName);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, aboutRoute);
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
