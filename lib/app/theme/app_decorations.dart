import 'package:flutter/cupertino.dart';

class AppDecorations {
  static BoxDecoration background(LinearGradient gradient) => BoxDecoration(gradient: gradient);

  static BorderRadius radius(double corners) => BorderRadius.all(Radius.circular(corners));
}
