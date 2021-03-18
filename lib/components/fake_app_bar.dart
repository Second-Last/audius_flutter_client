import 'package:flutter/material.dart';

import '../constants.dart';

class FakeAppBar extends StatelessWidget {
  FakeAppBar({
    @required this.leading,
    this.action,
    this.actionLabel,
  });

  final String leading;
  final Function action;
  final Widget actionLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 11, 10, 0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Center(
              child: GradientText(
                leading,
                gradient: linearGradient,
                style: TextStyle(
                  // The color must be set to white for this to work
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                color: audiusColor,
                child: actionLabel,
              ),
              onTap: action,
            ),
          ),
        ],
      ),
    );
  }
}
