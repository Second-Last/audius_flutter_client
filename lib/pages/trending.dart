import 'package:flutter/material.dart';
import '../constants.dart';

class Trending extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
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
            Padding(
              padding: const EdgeInsets.all(15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                // TODO: switch to GestureDetector to remove the overlay color
                child: ElevatedButton( 
                  child: Text('All Genres'),
                  onPressed: () => print('All genres!'),
                ),
              ),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                child: Column(
                  children: [
                    Icon(Icons.today),
                    Text('This Week'),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    Icon(Icons.date_range),
                    Text('This Month'),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    Icon(Icons.all_inclusive),
                    Text('This Year'),
                  ],
                ),
              ),
            ],
            labelPadding: EdgeInsets.zero,
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
