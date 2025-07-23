import 'dart:math';

import 'package:flutter/material.dart';
import 'package:planets_3A/app/theme/app_colors.dart';

class CustomColor {
  static Color getColorRandom() {
    List<Color> colors = [kBlue, kPurple, kViolet];
    final Color randomColor = colors[Random().nextInt(colors.length)];
    return randomColor;
  }
}
