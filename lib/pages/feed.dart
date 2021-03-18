import '../components/fake_app_bar.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Column(
        children: [
          FakeAppBar(
            leading: 'Feed',
            actionLabel: Text(
              'All Posts',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
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
    );
  }
}
