import 'package:flutter/material.dart';

BoxDecoration gradientBox(Color first, Color second) {
  return BoxDecoration(
      gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[first, second],
  ));
}
