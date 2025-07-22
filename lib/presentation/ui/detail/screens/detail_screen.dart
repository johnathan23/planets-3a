import 'package:go_router/go_router.dart';
import 'package:planets_3A/app/theme/app_colors.dart';
import 'package:planets_3A/app/theme/app_decorations.dart';
import 'package:planets_3A/app/theme/app_dimension.dart';
import 'package:planets_3A/core/extensions/color_extension.dart';
import 'package:planets_3A/core/extensions/planet_extension.dart';
import 'package:planets_3A/data/models/planet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_3A/presentation/ui/detail/widgets/custom_chip.dart';
import 'package:planets_3A/presentation/ui/home/helpers/image_local_helper.dart';
import 'package:planets_3A/presentation/ui/home/providers/home_provider.dart';
import 'package:planets_3A/presentation/ui/home/screens/home_screen.dart';
import 'package:planets_3A/presentation/ui/home/widgets/custom_sliver_grid_fixed_cross_axis_count.dart';
import 'package:planets_3A/presentation/widgets/custom_cache_network_image.dart';

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

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<PlanetModel>? planets = ref.watch(homeProvider).planets;
    final PlanetModel? planetModel = planets?.where((planet) => planet.name == widget.planetName).firstOrNull;
    final exists = planets?.any((p) => p.name?.toLowerCase() == widget.planetName?.toLowerCase()) ?? false;

    if (exists) {
      return _detailView(planetModel);
    } else {
      return _errorView();
    }
  }

  Widget _detailView(PlanetModel? planetModel) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: kPaddingSymmetric(horizontal: kSize16),
              child: Column(
                children: [
                  ImageLocalHelper.getImage(planetName: planetModel?.image ?? '', width: 230, height: 230),
                  Text(
                    planetModel?.name ?? '',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(color: kBlack, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    planetModel?.description ?? '',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kBlack, fontSize: 12),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Atmosphere Composition',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: kBlack, fontSize: 12),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    children: [
                      ...?planetModel?.getAtmosphereComposition().map(
                        (element) => Padding(padding: const EdgeInsets.all(4.0), child: CustomChip(label: element)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: kSize16),
            Text(
              'Other Stats',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: kBlack, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: kSize16),
            CustomSliverGridFixedCrossAxisCount(
              scrollController: _scrollController,
              itemCount: planetModel?.formattedStats.length,
              mainAxisExtent: 60,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: kBlue03.withOpacityValue(0.1),
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
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _errorView() {
    return Scaffold(
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
