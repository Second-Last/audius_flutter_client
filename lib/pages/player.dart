import 'package:flutter/material.dart';

class SmallPlayer extends StatelessWidget {
  const SmallPlayer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('My Song'),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                icon: Icon(
                  Icons.play_circle_fill,
                ),
                iconSize: 40,
                onPressed: () => print('Play button pressed!'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
