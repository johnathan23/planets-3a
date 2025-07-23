import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_3A/app/theme/app_colors.dart';
import 'package:planets_3A/app/theme/app_decorations.dart';
import 'package:planets_3A/app/theme/app_dimension.dart';
import 'package:planets_3A/core/db/session/session_manager.dart';
import 'package:planets_3A/presentation/ui/home/widgets/custom_card_planet.dart';
import 'package:planets_3A/presentation/ui/home/widgets/custom_sliver_grid_fixed_cross_axis_count.dart';
import 'package:planets_3A/presentation/widgets/custom_appbar.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  static const String screenName = 'favorites';
  static const String path = '/$screenName';

  const FavoriteScreen({super.key});

  @override
  ConsumerState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final planets = SessionManager().favorites;
    return SafeArea(
      child: Container(
        decoration: AppDecorations.background(kBackgroundGradient02),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppbar(title: 'Favorites'),
          body: Padding(
            padding: kPaddingSymmetric(horizontal: kSize16),
            child: Column(
              children: [
                if (planets.isNotEmpty) ...[
                  CustomSliverGridFixedCrossAxisCount(
                    scrollController: scrollController,
                    itemCount: planets.length,
                    mainAxisExtent: 360,
                    itemBuilder: (context, index) {
                      return CustomCardPlanet(planet: planets[index], isFavoriteScreen: true);
                    },
                  ),
                ] else ...[
                  Center(
                    child: Padding(
                      padding: kPaddingAll(kSize20),
                      child: Text(
                        'No favorites yet!',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(color: kBlack),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
