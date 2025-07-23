import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:planets_3A/app/theme/app_colors.dart';
import 'package:planets_3A/app/theme/app_dimension.dart';

class ImageLocal {
  static Widget getImage({required String planetName, required double width, required double height}) {
    String imagePath = kIsWeb ? 'images/${planetName.toLowerCase()}' : 'assets/images/${planetName.toLowerCase()}';
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: BoxFit.contain,
      errorBuilder: (context, object, error) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Symbols.error, color: kGrey, size: kSize50),
            Text(
              'Image not found',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: kBlack),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
