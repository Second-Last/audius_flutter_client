import 'package:audius_flutter_client/pages/full_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audio_service/audio_service.dart';

import 'pages/trending.dart';
import 'pages/favorites.dart';
import 'pages/explore.dart';
import 'pages/feed.dart';
import 'pages/player.dart';
import 'pages/account.dart';
import 'pages/full_player.dart' as player;
import 'constants.dart';
import 'blocs/reset_page/reset_page.dart';

// This extra widget is necessary for the ResetPageCubit to function in Home()
class BlocWrapped extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ResetPageCubit(0),
      child: Home(),
    );
  }
}

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
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              BlocListener<ResetPageCubit, int>(
                listener: (context, state) => _changePage(state),
                child: IndexedStack(
                  index: _currentIndex,
                  children: [
                    Feed(),
                    Trending(),
                    Explore(),
                    Favorites(),
                    Account(),
                    player.FullPlayer(),
                  ],
                ),
              ),
            //   Player(),
            ],
          ),
        ),
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
            BottomNavigationBarItem(
              icon: Icon(Icons.playlist_play),
              label: 'Player',
            )
          ],
          onTap: (selectedIndex) {
            context.read<ResetPageCubit>().setPage(selectedIndex);
          },
        ),
      ),
    );
  }
}
