import 'package:flutter/material.dart';
import '../constants.dart';

class Trending extends StatefulWidget {
  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Text(
            'Trending',
            style: TextStyle(color: audiusColor),
          ),
        ),
        actions: [
          PreferredSize(
            preferredSize: Size(40, 150),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ElevatedButton(
                child: Text('All Genres'),
                onPressed: () => print('All genres!'),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Icon(
          Icons.trending_up,
          size: 125,
        ),
      ),
    );
  }
}
