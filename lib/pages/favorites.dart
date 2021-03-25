import 'package:flutter/material.dart';

import 'package:audius_flutter_client/components/search_integrated.dart';
import 'package:audius_flutter_client/components/fake_app_bar.dart';
import '../constants.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return SearchIntegratedPage(
      mainContent: Column(
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
