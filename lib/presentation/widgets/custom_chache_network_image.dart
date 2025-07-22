import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:planets_3A/app/theme/app_colors.dart';
import 'package:planets_3A/app/theme/app_dimension.dart';

class CustomCacheNetworkImage extends StatefulWidget {
  final String imageUrl;
  final BoxFit? fit;
  final double? width;
  final double? height;

  const CustomCacheNetworkImage({super.key, required this.imageUrl, this.fit, this.width, this.height});

  @override
  State<CustomCacheNetworkImage> createState() => _CustomCacheNetworkImageState();
}

class _CustomCacheNetworkImageState extends State<CustomCacheNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      fit: widget.fit,
      width: widget.width,
      height: widget.height,
      progressIndicatorBuilder:
          (context, url, downloadProgress) => CircularProgressIndicator(
            value: downloadProgress.progress,
            padding: EdgeInsets.all(kSize40),
            color: kBlack,
          ),
      errorWidget: (context, url, error) {
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
