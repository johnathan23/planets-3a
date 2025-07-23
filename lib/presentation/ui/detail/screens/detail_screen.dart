import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:planets_3A/app/theme/app_colors.dart';
import 'package:planets_3A/app/theme/app_dimension.dart';
import 'package:planets_3A/core/extensions/planet_extension.dart';
import 'package:planets_3A/data/models/planet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_3A/domain/enum/slide_direction_enum.dart';
import 'package:planets_3A/presentation/animations/fade_animation.dart';
import 'package:planets_3A/presentation/animations/rotate_animation.dart';
import 'package:planets_3A/presentation/animations/slide_animation.dart';
import 'package:planets_3A/presentation/ui/detail/providers/detail_provider.dart';
import 'package:planets_3A/presentation/ui/detail/widgets/custom_card_other_stats.dart';
import 'package:planets_3A/presentation/ui/detail/widgets/custom_chip.dart';
import 'package:planets_3A/presentation/widgets/image_local.dart';
import 'package:planets_3A/presentation/ui/home/screens/home_screen.dart';
import 'package:planets_3A/presentation/ui/home/widgets/custom_sliver_grid_fixed_cross_axis_count.dart';
import 'package:planets_3A/presentation/widgets/custom_appbar.dart';

class DetailScreen extends ConsumerStatefulWidget {
  static const String screenName = 'detail';
  static const String path = '/$screenName';

  final String? planetName;

  const DetailScreen({required this.planetName, super.key});

  @override
  ConsumerState createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    Future.microtask(() {
      ref.read(detailProvider.notifier).getPlanet(widget.planetName!);
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exists = ref.watch(detailProvider).exists;
    final planetModel = ref.watch(detailProvider).planet;
    if (exists) {
      return _detailView(planetModel);
    } else {
      return _errorView();
    }
  }

  Widget _detailView(PlanetModel? planetModel) {
    final isFavorite = ref.watch(detailProvider).isFavorite;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(title: 'Planet Detail'),
        body: Column(
          children: [
            Padding(
              padding: kPaddingSymmetric(horizontal: kSize16),
              child: Column(
                children: [
                  FadeAnimation(child: RotateAnimation(child: ImageLocal.getImage(planetName: planetModel?.image ?? '', width: 230, height: 230))),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: FadeAnimation(
                            child: Text(
                              planetModel?.name ?? '',
                              style: Theme.of(
                                context,
                              ).textTheme.headlineSmall?.copyWith(color: kBlack, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return ScaleTransition(scale: animation, child: child);
                        },
                        child: IconButton(
                          key: ValueKey(isFavorite),
                          icon:
                              !(isFavorite)
                                  ? Icon(Symbols.favorite_rounded, color: kBlack, size: kSize20)
                                  : Icon(Symbols.favorite_sharp, color: kPurple, size: kSize20, fill: 1),
                          onPressed: () {
                            ref.read(detailProvider.notifier).setPlanetFavorite(!isFavorite);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  SlideAnimation(
                    direction: SlideDirection.bottomToTop,
                    child: Text(
                      planetModel?.description ?? '',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kBlack, fontSize: 12),
                    ),
                  ),
                  SizedBox(height: 8),
                  SlideAnimation(
                    direction: SlideDirection.leftToRight,
                    child: Text(
                      'Atmosphere Composition',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: kBlack, fontSize: 12),
                    ),
                  ),
                  SizedBox(height: 8),
                  SlideAnimation(
                    direction: SlideDirection.rightToLeft,
                    child: Wrap(
                      children: [
                        ...?planetModel?.getAtmosphereComposition().map(
                          (element) => Padding(padding: const EdgeInsets.all(4.0), child: CustomChip(label: element)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: kSize16),
            FadeAnimation(
              child: Text(
                'Other Stats',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: kBlack, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: kSize16),
            CustomSliverGridFixedCrossAxisCount(
              scrollController: _scrollController,
              itemCount: planetModel?.formattedStats.length,
              mainAxisExtent: 60,
              itemBuilder: (context, index) {
                return CustomCardOtherStats(planetModel: planetModel, index: index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _errorView() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Planet ${widget.planetName} not found'),
            SizedBox(height: kSize16),
            ElevatedButton(onPressed: () => context.goNamed(HomeScreen.screenName), child: const Text('Go to Planets')),
          ],
        ),
      ),
    );
  }
}
