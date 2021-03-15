import 'package:flutter/material.dart';
import '../constants.dart';

class Trending extends StatefulWidget {
  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
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
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.today),
                text: 'This Week',
              ),
              Tab(
                icon: Icon(Icons.date_range),
                text: 'This Month',
              ),
              Tab(
                icon: Icon(Icons.all_inclusive),
                text: 'This Year',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text('This Week')),
            Center(child: Text('This Month')),
            Center(child: Text('This Year')),
          ],
        ),
      ),
    );
  }
}
