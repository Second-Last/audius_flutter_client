import 'package:flutter/material.dart';

class SmallPlayer extends StatefulWidget {
  @override
  _SmallPlayerState createState() => _SmallPlayerState();
}

class _SmallPlayerState extends State<SmallPlayer>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: 500),
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
