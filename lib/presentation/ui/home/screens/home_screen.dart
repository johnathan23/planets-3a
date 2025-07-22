import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_3A/app/theme/app_colors.dart';
import 'package:planets_3A/app/theme/app_decorations.dart';
import 'package:planets_3A/app/theme/app_dimension.dart';
import 'package:planets_3A/core/extensions/color_extension.dart';
import 'package:planets_3A/presentation/ui/home/providers/home_provider.dart';
import 'package:planets_3A/presentation/ui/home/widgets/custom_card_planet.dart';
import 'package:planets_3A/presentation/ui/home/widgets/custom_sliver_grid_fixed_cross_axis_count.dart';
import 'package:planets_3A/presentation/ui/home/widgets/sliver_grid_shimmer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String screenName = 'home';
  static const String path = '/$screenName';

  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final ScrollController _scrollController;
  late final TextEditingController controllerSearch;
  bool showSearchBar = true;
  Timer? _debounce;

  @override
  void initState() {
    controllerSearch = TextEditingController();
    _scrollController = ScrollController();
    _scrollController.addListener(() => _scrollListener());
    Future.microtask(() {
      ref.read(homeProvider.notifier).getPlanets();
    });
    super.initState();
  }

  @override
  void dispose() {
    controllerSearch.dispose();
    _debounce?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset <= 0) {
      if (!showSearchBar) {
        setState(() => showSearchBar = true);
      }
    } else {
      if (showSearchBar) {
        setState(() => showSearchBar = false);
      }
    }
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (controllerSearch.text.isEmpty) {
        ref.read(homeProvider.notifier).getPlanets();
      } else {
        ref.read(homeProvider.notifier).searchPlanet(controllerSearch.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final planets = ref.watch(homeProvider).planets;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: AppDecorations.background(kBackgroundGradient),
          child: Padding(
            padding: kPaddingSymmetric(horizontal: kSize16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (ref.watch(homeProvider).isLoading) ...[
                  Expanded(child: SliverGridShimmer()),
                ] else ...[
                  if (showSearchBar) ...[
                    SizedBox(height: kSize16),
                    SearchBar(
                      hintText: 'Search planets',
                      controller: controllerSearch,
                      onChanged: _onSearchChanged,
                      overlayColor: WidgetStateProperty.all<Color>(kBlue03.withOpacityValue(0.1)),
                    ),
                    SizedBox(height: kSize16),
                  ],
                  CustomSliverGridFixedCrossAxisCount(
                    scrollController: _scrollController,
                    itemCount: planets?.length,
                    mainAxisExtent: 360,
                    itemBuilder: (context, index) {
                      return CustomCardPlanet(planet: planets?[index]);
                    },
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
