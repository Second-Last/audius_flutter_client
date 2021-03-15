import 'package:flutter/material.dart';
import 'package:audius_flutter_client/constants.dart';

class AudiusBottomNavBar extends StatefulWidget {
  @override
  _AudiusBottomNavBarState createState() => _AudiusBottomNavBarState();
}

class _AudiusBottomNavBarState extends State<AudiusBottomNavBar>
    with TickerProviderStateMixin {
  List<AnimationController> _navBarAnimationControllers;
  List<Animation> _navBarAnimations;
  int _currentIndex;

  // Reacts to change in page (user taps nav bar)
  void _changePage(int selectedIndex) {
    setState(() {
      _currentIndex = selectedIndex;
    });
    switch (selectedIndex) {
      case 2:
        _navBarAnimationControllers[0].forward();
        break;
      default:
        _navBarAnimationControllers[0].reset();
    }
    print("Page changed to $selectedIndex");
  }

  // TODO: move to 'late final' when possible
  @override
  void initState() {
    super.initState();

    _currentIndex = 0;
    _navBarAnimationControllers = [
      AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 250),
        lowerBound: 0,
        upperBound: 0.5,
      ),
    ];
    _navBarAnimations = [
      CurvedAnimation(
        parent: _navBarAnimationControllers[0],
        curve: Curves.elasticOut,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
          icon: Icon(Icons.trending_up),
          label: 'Trending',
        ),
        BottomNavigationBarItem(
          icon: RotationTransition(
            turns: _navBarAnimationControllers[0],
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
    );
  }
}
