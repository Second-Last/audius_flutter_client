import 'package:audius_flutter_client/components/searchbar.dart';

import '../components/fake_app_bar.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // SearchBar(),
          Divider(
            height: 0,
            thickness: 1,
            color: audiusLightGrey,
          ),
          FakeAppBar(leading: 'Favorites'),
          Container(
            child: Center(
              child: Icon(
                Icons.favorite,
                size: 125,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
