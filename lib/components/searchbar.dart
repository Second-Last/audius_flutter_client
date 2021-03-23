import 'package:flutter/material.dart';
import '../constants.dart';

class SearchBar extends StatefulWidget {
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
      border: Border.all(color: audiusGrey),
      borderRadius: BorderRadius.circular(8),
    ),
  );
  late final Animation<Decoration> _containerTransition = _decorationTween.animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
    ),
  );
  // Border animation for the container

  // Opacity animation for the search button
  double _titleOpacity = 1.0;
  // Opacity animation for the search button

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
    double _containerLength =
        (MediaQuery.of(context).size.width - 2 * 8) * 0.75;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          AnimatedOpacity(
            opacity: _titleOpacity,
            duration: Duration(milliseconds: _animationTime),
            curve: Curves.linear,
            child: Text('AUDIUS'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.notifications),
              Spacer(),
              DecoratedBoxTransition(
                decoration: _containerTransition,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (BuildContext context, child) => Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
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
                                  // onChanged: (value) => null,
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  child: Icon(
                                    Icons.search,
                                    size: 24 *
                                        cosineCurve(_animationController.value),
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
                                      _titleOpacity = 1.0;
                                    } else {
                                      _animationController.forward();
                                      _showSearchField = true;
                                      _titleOpacity = 0;
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
