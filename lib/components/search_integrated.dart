import 'package:audius_flutter_client/components/searchbar.dart';
import 'package:flutter/material.dart';

class SearchIntegratedPage extends StatelessWidget {
  SearchIntegratedPage({required this.mainContent});

  final Widget mainContent;
  final _topLevelKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(onGenerateRoute: (settings) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _Body(mainContent: mainContent),
        settings: settings,
      );
    });
  }
}

class _Body extends StatefulWidget {
  _Body({required this.mainContent});

  final Widget mainContent;

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          SearchBar(_navigatorKey),
          Expanded(
            child: Navigator(
              key: _navigatorKey,
              pages: [],
              onGenerateRoute: (settings) {
                return MaterialPageRoute<dynamic>(
                  builder: (context) {
                    return widget.mainContent;
                  },
                  settings: settings,
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
