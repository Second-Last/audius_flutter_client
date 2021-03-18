import 'package:flutter/material.dart';
import '../constants.dart';

class Trending extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   centerTitle: false,
        //   title: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 0),
        //     child: Text(
        //       'Trending',
        //       style: TextStyle(color: audiusColor),
        //     ),
        //   ),
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.all(15),
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.circular(7),
        //         // TODO: switch to GestureDetector to remove the overlay color
        //         child: ElevatedButton(
        //           child: Text('All Genres'),
        //           onPressed: () => print('All genres!'),
        //         ),
        //       ),
        //     ),
        //   ],
        //   bottom: TabBar(
        //     tabs: [
        //       Tab(
        //         child: Column(
        //           children: [
        //             Icon(Icons.today),
        //             Text('This Week'),
        //           ],
        //         ),
        //       ),
        //       Tab(
        //         child: Column(
        //           children: [
        //             Icon(Icons.date_range),
        //             Text('This Month'),
        //           ],
        //         ),
        //       ),
        //       Tab(
        //         child: Column(
        //           children: [
        //             Icon(Icons.all_inclusive),
        //             Text('This Year'),
        //           ],
        //         ),
        //       ),
        //     ],
        //     labelPadding: EdgeInsets.zero,
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Center(
                        child: Text(
                          'Trending',
                          style: TextStyle(color: audiusColor, fontSize: 22, ),
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
                            style: TextStyle(color: Colors.white),
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
                // thickness: 3,
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
