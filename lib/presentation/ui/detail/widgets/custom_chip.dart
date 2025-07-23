import 'package:flutter/material.dart';
import 'package:planets_3A/app/theme/app_colors.dart';
import 'package:planets_3A/core/extensions/color_extension.dart';
import 'package:planets_3A/core/utils/custom_color.dart';

class CustomChip extends StatelessWidget {
  final String label;
  const CustomChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: kBlack)),
      backgroundColor: CustomColor.getColorRandom().withOpacityValue(0.3),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
    );
  }
}
