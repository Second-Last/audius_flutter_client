import 'package:flutter/material.dart';

import 'package:audius_flutter_client/components/fake_app_bar.dart';
import 'package:audius_flutter_client/components/search_integrated.dart';
import '../constants.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SearchIntegratedPage(
      mainContent: Center(
        child: Scaffold(
          body: Column(
            children: [
              // SearchBar(),
              Divider(
                height: 0,
                thickness: 1,
                color: audiusLightGrey,
              ),
              FakeAppBar(
                leading: 'Feed',
                actionLabel: Text(
                  'All Posts',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                action: () => print('All Posts!'),
              ),
              Divider(
                height: 0,
                thickness: 1,
                color: audiusLightGrey,
              ),
              Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'You have pushed the button this many times:',
                      ),
                      Text(
                        '$_counter',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
