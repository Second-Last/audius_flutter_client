import 'package:animations/animations.dart';
import 'package:flutter/material.dart';


class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (context, action) {
        return SmallPlayer();
      },
      openBuilder: (context, action) {
        return FullPlayer();
      },
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: Duration(milliseconds: 500),
    );
  }
}



class SmallPlayer extends StatelessWidget {
  const SmallPlayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}




class FullPlayer extends StatelessWidget {
  const FullPlayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_downward),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_circle_filled,
              size: 200,
            ),
            Text('Player!')
          ],
        ),
      ),
    );
  }
}
