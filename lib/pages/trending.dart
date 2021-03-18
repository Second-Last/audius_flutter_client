import 'package:audius_flutter_client/components/fake_app_bar.dart';
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
              FakeAppBar(
                action: () => print('All genres!'),
                actionLabel: Text(
                  'All Genres',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                leading: 'Trending',
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
                        Text('This Week',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      children: [
                        Icon(Icons.date_range),
                        Text('This Month',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      children: [
                        Icon(Icons.all_inclusive),
                        Text('This Year',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ],
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
              ),
              Divider(
                height: 0,
                color: audiusLightGrey,
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  children: [
                    // SingleChildScrollView 应该放在这里
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
