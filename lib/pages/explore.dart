import '../components/fake_app_bar.dart';
import 'package:flutter/material.dart';

class Explore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FakeAppBar(leading: 'Explore'),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.explore,
                  size: 200,
                ),
                Text('Library')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
