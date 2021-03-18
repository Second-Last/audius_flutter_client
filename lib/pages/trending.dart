import 'package:flutter/material.dart';
import '../constants.dart';

class Trending extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 11, 10, 0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Center(
                        child: GradientText(
                          'Trending',
                          gradient: linearGradient,
                          style: TextStyle(
                            // The color must be set to white for this to work
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      // TODO: tweak GestureDetector
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          color: audiusColor,
                          child: Text(
                            'All Genres',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        onTap: () => print('All genres!'),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 20,
                thickness: 1,
                color: audiusLightGrey,
              ),
              TabBar(
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
              Divider(
                height: 0,
                color: audiusLightGrey,
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  children: [
                    Text('This Week'),
                    Text('This Month'),
                    Text('This Year'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
