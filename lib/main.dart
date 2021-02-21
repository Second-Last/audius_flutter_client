import 'pages/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/home.dart';
import 'pages/player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex;

  @override
  void initState() {
    super.initState();

    _currentIndex = 0;
  }

  void _changePage(int selectedIndex) {
    setState(() {
      _currentIndex = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audius Local',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.settings), onPressed: null),
            title: Text('Audius'),
            centerTitle: true,
            backgroundColor: Colors.purple,
            // toolbarHeight: 40,
          ),
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                IndexedStack(
                  index: _currentIndex,
                  children: [
                    Home(),
                    Library(),
                  ],
                ),
                SmallPlayer()
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.blueGrey,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.music_note,
                  color: Colors.blueGrey,
                ),
                label: "Library",
              ),
            ],
            onTap: (selectedIndex) {
              _changePage(selectedIndex);
              print("Page changed to $selectedIndex");
            },
          ),
        ),
      ),
    );
  }
}