import 'package:audius_flutter_client/components/searchbar.dart';
import '../constants.dart';
import 'package:flutter/material.dart';

class SearchIntegratedPage extends StatelessWidget {
  SearchIntegratedPage({required this.mainContent});

  final Widget mainContent;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        late Widget page;

        if (settings.name == routeMain) {
          page = _Body(mainContent);
        } else {
          throw Exception('Unknown route: ${settings.name}');
        }

        return MaterialPageRoute<dynamic>(
          builder: (context) => page,
          settings: settings,
        );
      },
    );
  }
}

class _Body extends StatefulWidget {
  _Body(this._mainContent);

  final Widget _mainContent;

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
        child: Column(
          children: [
            SearchBar(_navigatorKey),
            Expanded(
              child: Navigator(
                key: _navigatorKey,
                onGenerateRoute: (settings) {
                  return MaterialPageRoute<dynamic>(
                    builder: (context) {
                      return SingleChildScrollView(child: widget._mainContent);
                    },
                    settings: settings,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
