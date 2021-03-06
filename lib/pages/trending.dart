import 'package:flutter/material.dart';

import 'package:audius_flutter_client/components/fake_app_bar.dart';
import 'package:audius_flutter_client/components/search_integrated.dart';
import '../constants.dart';

class Trending extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: SearchIntegratedPage(
        mainContent: Column(
          children: [
            // SearchBar(),
            Divider(
              height: 0,
              thickness: 1,
              color: audiusLightGrey,
            ),
            FakeAppBar(
              action: () => print('All genres!'),
              actionLabel: Text(
                'All Genres',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
              leading: 'Trending',
            ),
            Divider(
              height: 0,
              thickness: 1,
              color: audiusLightGrey,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7),
              child: TabBar(
                tabs: [
                  Tab(
                    child: Column(
                      children: [
                        Icon(Icons.today),
                        Text('THIS WEEK',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      children: [
                        Icon(Icons.date_range),
                        Text('THIS MONTH',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      children: [
                        Icon(Icons.all_inclusive),
                        Text('THIS YEAR',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ],
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
              ),
            ),
            Divider(
              height: 0,
              color: audiusLightGrey,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // SingleChildScrollView ??????????????????
                  SingleChildScrollView(child: Text('This Week')),
                  SingleChildScrollView(child: Text('This Month')),
                  SingleChildScrollView(child: Text('This Year')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
