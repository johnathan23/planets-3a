import 'package:flutter/material.dart';
import 'package:planets_3A/app/theme/app_dimension.dart';
import 'package:planets_3A/presentation/ui/home/helpers/custom_grid_row_size_helper.dart';
import 'package:shimmer/shimmer.dart';

class SliverGridShimmer extends StatelessWidget {
  const SliverGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: CustomGridRowSizeHelper.byDefault(context),
        crossAxisSpacing: kSize16,
        mainAxisSpacing: kSize16,
        mainAxisExtent: 350,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                ),
                const SizedBox(height: 10),
                Container(height: 15, margin: const EdgeInsets.symmetric(horizontal: 8), color: Colors.white),
                const SizedBox(height: 8),
                Container(
                  height: 15,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 80,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
