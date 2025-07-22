import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_3A/app/theme/app_colors.dart';
import 'package:planets_3A/app/theme/app_decorations.dart';
import 'package:planets_3A/app/theme/app_dimension.dart';
import 'package:planets_3A/core/extensions/color_extension.dart';
import 'package:planets_3A/core/extensions/planet_extension.dart';
import 'package:planets_3A/data/models/planet_model.dart';
import 'package:planets_3A/presentation/ui/detail/screens/detail_screen.dart';
import 'package:planets_3A/presentation/widgets/custom_cache_network_image.dart';

class CustomCardPlanet extends ConsumerWidget {
  final PlanetModel? planet;

  const CustomCardPlanet({required this.planet, super.key});

  void _goToPlanetDetails(BuildContext context, PlanetModel? planet) {
    context.goNamed(DetailScreen.screenName, extra: planet, pathParameters: {'planetName': planet?.name ?? ''});
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          child: InkWell(
            borderRadius: AppDecorations.radius(kSize16),
            hoverColor: kPurple.withOpacityValue(0.1),
            onTap: () => _goToPlanetDetails(context, planet),
            child: Padding(
              padding: kPaddingSymmetric(horizontal: kSize16, vertical: kSize16),
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth - 250 - kSize16 * 2 - 16,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          planet?.name ?? '',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(color: kBlack, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          planet?.description ?? '',
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: kBlack.withOpacityValue(0.7), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  CustomCacheNetworkImage(
                    imageUrl: planet?.image ?? '',
                    width: 250,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
