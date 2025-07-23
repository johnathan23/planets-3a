import 'package:flutter/material.dart';
import 'package:planets_3A/app/theme/app_colors.dart';
import 'package:planets_3A/core/extensions/color_extension.dart';
import 'package:planets_3A/core/extensions/planet_extension.dart';
import 'package:planets_3A/core/utils/custom_color.dart';
import 'package:planets_3A/data/models/planet_model.dart';

class CustomCardOtherStats extends StatelessWidget {
  final PlanetModel? planetModel;
  final int index;
  const CustomCardOtherStats({required this.planetModel, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.getColorRandom().withOpacityValue(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          SizedBox(height: 8),
          Text(
            planetModel?.formattedStats[index].key ?? '',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: kBlack, fontSize: 12),
          ),
          SizedBox(height: 8),
          Text(
            planetModel?.formattedStats[index].value ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kBlack, fontSize: 12),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
