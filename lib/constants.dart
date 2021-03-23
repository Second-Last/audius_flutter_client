import 'package:flutter/material.dart';
import 'dart:math';

/*
  UI related
*/
const audiusColor = Colors.purple;
const audiusGrey = Colors.blueGrey;
var audiusLightGrey = Colors.blueGrey[200]; // TODO: why can't this be constant?
var backgroundGrey = Colors.grey[300];
var outlineGrey = Colors.grey[350];
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

/*
  Math related
*/
double cosineCurve (double value) {
  return (1 / 8) * cos(2 * pi * value) + 7 / 8;
}