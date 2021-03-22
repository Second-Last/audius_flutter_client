import 'package:flutter/material.dart';
import '../constants.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> with TickerProviderStateMixin {
  // Search form related
  bool _showSearchField = false;
  String? _initialValue;

  // The animation controller that controls everything
  late AnimationController _animationController;

  // Border animation for the container
  final DecorationTween decorationTween = DecorationTween(
    begin: BoxDecoration(
      border: Border.all(style: BorderStyle.none),
      borderRadius: BorderRadius.circular(8),
    ),
    end: BoxDecoration(
      border: Border.all(color: audiusGrey, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
  );
  late final Animation containerTransition = decorationTween.animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
    ),
  );
  // Border animation for the container

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
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
          Text('AUDIUS'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.notifications),
              Spacer(),
              DecoratedBoxTransition(
                decoration: decorationTween.animate(_animationController),
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (BuildContext context, child) {
                    return Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                      width: _animationController.value * _containerLength + 35,
                      child: child,
                    );
                  },
                  child: _showSearchField
                      ? Row(
                          children: [
                            Expanded(
                              child: TextField(
                                /* TODO: add these parameters later on 
                                controller: ,
                                focusNode: ,*/
                                decoration: null,
                                onChanged: (value) => _initialValue = value,
                              ),
                            ),
                            GestureDetector(
                              key: Key('Search Button'),
                              child: Icon(Icons.search),
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
                          key: Key('Search Button'),
                          child: Icon(Icons.search),
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
              )
            ],
          )
        ],
      ),
    );
  }
}