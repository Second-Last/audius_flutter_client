import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:audius_flutter_client/pages/search.dart';
import '../blocs/reset_page/reset_page.dart';
import '../constants.dart';

class SearchBar extends StatefulWidget {
  SearchBar(this._navigatorKey);

  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> with TickerProviderStateMixin {
  // Search form related
  bool _showSearchField = false;

  // The animation controller that controls everything
  late AnimationController _animationController;
  static const int _animationTime = 300;

  // Border animation for the container
  final DecorationTween _decorationTween = DecorationTween(
    begin: BoxDecoration(
      border: Border.all(style: BorderStyle.none),
      borderRadius: BorderRadius.circular(8),
    ),
    end: BoxDecoration(
      border: Border.all(color: outlineGrey!),
      borderRadius: BorderRadius.circular(8),
      color: backgroundGrey,
    ),
  );
  late final Animation<Decoration> _containerTransition =
      _decorationTween.animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
    ),
  );
  // Border animation for the container

  // Opacity animation for the title
  late final Animation<double> _opacityAnimation = ReverseAnimation(
    CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.5, curve: Curves.linear),
    ),
  );
  // Opacity animation for the title

  // Size animation for the title
  // TODO: technically it should truncate (i.e. only go from 1 to 0.8)
  // but I doubled the interval to make it look like so
  late final Animation<double> _sizeAnimation = ReverseAnimation(
    CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 1.0, curve: Curves.easeInCubic),
    ),
  );
  // Size animation for the title

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _animationTime),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _containerLength = (MediaQuery.of(context).size.width - 2 * 8) * 0.8;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          FadeTransition(
            opacity: _opacityAnimation,
            child: ScaleTransition(
              scale: _sizeAnimation,
              child: GestureDetector(
                child: Text(
                  'AUDIUS',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: audiusColor,
                  ),
                ),
                onTap: () {
                  if (widget._navigatorKey.currentState!.canPop()) {
                    widget._navigatorKey.currentState!
                        .popUntil(ModalRoute.withName('/'));
                    // Bruh I don't even know why this works... Figure this out!
                    // Shouldn't the route '/' be one layer above?????
                  }
                  context.read<ResetPageCubit>().reset();
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Icon(
                  Icons.notifications,
                  color: audiusGrey,
                ),
              ),
              Spacer(),
              DecoratedBoxTransition(
                decoration: _containerTransition,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (BuildContext context, child) => Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(5, 5, 3, 5),
                    width: _animationController.value * _containerLength + 35,
                    child: _showSearchField
                        ? Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  /* TODO: add these parameters later on 
                                    controller: ,
                                    focusNode: ,*/
                                  decoration: null,
                                  autofocus: true,
                                  // onChanged: (value) => null,
                                  onSubmitted: (value) =>
                                      widget._navigatorKey.currentState!.push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Search(search: value),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  child: Icon(
                                    Icons.search,
                                    size: 24 *
                                        cosineCurve(_animationController.value),
                                    color: audiusGrey,
                                  ),
                                  // TODO: prevent hard-coded values
                                  width: 24,
                                  height: 24,
                                ),
                                onTap: () {
                                  setState(() {
                                    if (_animationController.isCompleted) {
                                      _animationController.reverse();
                                      _showSearchField = false;
                                    } else {
                                      _animationController.forward();
                                      _showSearchField = true;
                                    }
                                  });
                                },
                              )
                            ],
                          )
                        : GestureDetector(
                            child: Container(
                              child: Icon(
                                Icons.search,
                                size: 24 *
                                    cosineCurve(_animationController.value),
                                color: audiusGrey,
                              ),
                              // TODO: prevent hard-coded values
                              width: 24,
                              height: 24,
                            ),
                            onTap: () {
                              setState(() {
                                if (_animationController.isCompleted) {
                                  _animationController.reverse();
                                  _showSearchField = false;
                                } else {
                                  _animationController.forward();
                                  _showSearchField = true;
                                }
                              });
                            },
                          ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
