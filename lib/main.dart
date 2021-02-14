import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audius Local',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Home(title: "Audius",),
    );
  }
}