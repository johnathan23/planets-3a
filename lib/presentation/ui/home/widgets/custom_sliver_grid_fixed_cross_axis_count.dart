import 'package:flutter/material.dart';
import 'package:planets_3A/app/theme/app_dimension.dart';
import 'package:planets_3A/presentation/ui/home/helpers/custom_grid_row_size_helper.dart';

class CustomSliverGridFixedCrossAxisCount extends StatefulWidget {
  final ScrollController scrollController;
  final int? itemCount;
  final double mainAxisExtent;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final Widget? Function(BuildContext, int) itemBuilder;

  const CustomSliverGridFixedCrossAxisCount({
    super.key,
    required this.scrollController,
    required this.itemCount,
    required this.mainAxisExtent,
    required this.itemBuilder,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
    this.physics,
    this.shrinkWrap = false,
  });

  @override
  State<CustomSliverGridFixedCrossAxisCount> createState() => _CustomSliverGridFixedCrossAxisCountState();
}

class _CustomSliverGridFixedCrossAxisCountState extends State<CustomSliverGridFixedCrossAxisCount> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        physics: widget.physics,
        shrinkWrap: widget.shrinkWrap,
        controller: widget.scrollController,
        anchor: 0.01,
        slivers: [
          SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: CustomGridRowSizeHelper.byDefault(context),
              crossAxisSpacing: widget.crossAxisSpacing ?? kSize16,
              mainAxisSpacing: widget.mainAxisSpacing ?? kSize16,
              mainAxisExtent: widget.mainAxisExtent,
            ),
            itemCount: widget.itemCount,
            itemBuilder: widget.itemBuilder,
          ),
        ],
      ),
    );
  }
}
