import 'dart:math';

import 'package:flutter/material.dart';

class RandomColors{
  Color getRandomColor({double oppacity=0.4}) {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      oppacity,
    );
  }
}