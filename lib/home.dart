import 'pages/trending.dart';
import 'pages/favorites.dart';
import 'pages/explore.dart';
import 'pages/feed.dart';
import 'pages/player.dart';
import 'pages/account.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late final List<AnimationController> navBarAnimationControllers = [
    AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0,
      upperBound: 0.5,
    ),
  ];
  late final List<Animation> navBarAnimations = [
    CurvedAnimation(
      parent: navBarAnimationControllers[0],
      curve: Curves.elasticInOut,
    ),
  ];
  int? _currentIndex;

  void _changePage(int selectedIndex) {
    setState(() {
      _currentIndex = selectedIndex;
    });
    switch (selectedIndex) {
      case 2:
        navBarAnimationControllers[0].forward();
        break;
      default:
        navBarAnimationControllers[0].reset();
    }
    print("Page changed to $selectedIndex");
  }

  @override
  void initState() {
    super.initState();

    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: _currentIndex == 4
              ? IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: null,
                )
              : IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: null,
                ),
          title: Center(
            child: TextButton(
              child: Text(
                'AUDIUS',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              onPressed: () => setState(() => _changePage(1)),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: audiusGrey,
              ),
              onPressed: () => null,
            )
          ],
          toolbarHeight: 40,
        ),
        body: Body(currentIndex: _currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex!,
          iconSize: 28,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: audiusGrey,
          selectedItemColor: audiusColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.supervisor_account),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              label: 'Trending',
            ),
            BottomNavigationBarItem(
              icon: RotationTransition(
                turns: navBarAnimationControllers[0],
                child: Icon(Icons.explore),
              ),
              label: 'Browse',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ],
          onTap: (selectedIndex) => _changePage(selectedIndex),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required int? currentIndex,
  })   : _currentIndex = currentIndex,
        super(key: key);

  final int? _currentIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          IndexedStack(
            index: _currentIndex,
            children: [
              Feed(),
              Trending(),
              Explore(),
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
    );
  }
}
