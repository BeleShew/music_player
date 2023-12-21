import 'dart:math';

import 'package:flutter/material.dart';

class RandomColors{
  Color getRandomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      0.6,
    );
  }
}