import 'pages/trending.dart';
import 'pages/favorites.dart';
import 'pages/browse.dart';
import 'pages/feed.dart';
import 'pages/player.dart';
import 'pages/account.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  List<AnimationController> navBarAnimationControllers;

  List<Animation> navBarAnimations;

  int _currentIndex;

  @override
  void initState() {
    super.initState();

    _currentIndex = 0;
    navBarAnimationControllers = [
      AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 250),
        lowerBound: 0,
        upperBound: 0.5,
      ),
    ];
    navBarAnimations = [
      CurvedAnimation(
        parent: navBarAnimationControllers[0],
        curve: Curves.elasticOut,
      ),
    ];
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
          primarySwatch: audiusColor,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ),
          )),
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.settings), onPressed: null),
            title: Text('Audius'),
            // toolbarHeight: 40,
          ),
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                IndexedStack(
                  index: _currentIndex,
                  children: [
                    Feed(),
                    Trending(),
                    Browse(),
                    Favorites(),
                    Account(),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Player(),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            unselectedItemColor: Colors.blueGrey,
            selectedItemColor: audiusColor,
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.supervisor_account),
                label: 'Feed',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.trending_up), label: 'Trending'),
              BottomNavigationBarItem(
                  icon: RotationTransition(
                    turns: navBarAnimationControllers[0],
                    child: Icon(Icons.explore),
                  ),
                  label: 'Browse'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: 'Account'),
            ],
            onTap: (selectedIndex) {
              _changePage(selectedIndex);
              switch (selectedIndex) {
                case 2:
                  navBarAnimationControllers[0].forward();
                  break;
                default:
                  navBarAnimationControllers[0].reset();
              }
              print("Page changed to $selectedIndex");
            },
          ),
        ),
      ),
    );
  }
}
