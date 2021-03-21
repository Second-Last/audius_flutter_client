import 'package:flutter/material.dart';

/*
  UI related
*/
const audiusColor = Colors.purple;
const audiusGrey = Colors.blueGrey;
var audiusLightGrey = Colors.blueGrey[200]; // TODO: why can't this be constant?
const linearGradient = LinearGradient(
  colors: <Color>[
    Color(0xffDA44bb),
    audiusColor,
  ],
); // TODO: refer to the actual values, even though this actually looks quite good

class GradientText extends StatelessWidget {
  GradientText(
    this.text, {
    required this.gradient,
    required this.style,
  });

  final String text;
  final Gradient gradient;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}

/*
  Network related
*/
const app_name = 'Audius Flutter Client';