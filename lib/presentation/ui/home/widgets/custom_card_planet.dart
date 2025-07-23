import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_3A/app/theme/app_colors.dart';
import 'package:planets_3A/app/theme/app_decorations.dart';
import 'package:planets_3A/app/theme/app_dimension.dart';
import 'package:planets_3A/core/extensions/color_extension.dart';
import 'package:planets_3A/data/models/planet_model.dart';
import 'package:planets_3A/presentation/ui/detail/screens/detail_screen.dart';
import 'package:planets_3A/presentation/widgets/image_local.dart';

class CustomCardPlanet extends ConsumerWidget {
  final PlanetModel? planet;
  final bool isFavoriteScreen;

  const CustomCardPlanet({required this.planet, this.isFavoriteScreen = false, super.key});

  void _goToPlanetDetails(BuildContext context, PlanetModel? planet) {
    if (!kIsWeb) {
      context.pushNamed(DetailScreen.screenName, extra: planet, pathParameters: {'planetName': planet?.name ?? ''});
    } else {
      context.goNamed(DetailScreen.screenName, extra: planet, pathParameters: {'planetName': planet?.name ?? ''});
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          child: InkWell(
            borderRadius: AppDecorations.radius(kSize16),
            hoverColor: kPurple.withOpacityValue(0.1),
            onTap: !isFavoriteScreen ? () => _goToPlanetDetails(context, planet) : null,
            child: Padding(
              padding: kPaddingSymmetric(horizontal: kSize16, vertical: kSize16),
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth - 230 - kSize16 * 2 - 16,
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
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: kBlack.withOpacityValue(0.7), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  ImageLocal.getImage(planetName: planet?.image ?? '', width: 230, height: 230),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
