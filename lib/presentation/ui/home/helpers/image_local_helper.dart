import 'package:flutter/material.dart';

class ImageLocalHelper {
  static Widget getImage({required String planetName, required double width, required double height}) {
    String imagePath = 'assets/images/${planetName.toLowerCase()}';
    print("### url : $imagePath");
    return Image.asset(imagePath, width: width, height: height, fit: BoxFit.contain);
  }
}
