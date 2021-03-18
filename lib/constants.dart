import 'package:flutter/material.dart';

const audiusColor = Colors.purple;
const audiusGrey = Colors.blueGrey;
var audiusLightGrey = Colors.blueGrey[200]; // TODO: why can't this be constant?

final Shader linearGradient = LinearGradient(
  colors: <Color>[
    Color(0xffDA44bb),
    Color(0xff8921aa),
  ],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
