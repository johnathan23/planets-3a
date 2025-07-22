import 'package:planets_3A/data/models/planet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailScreen extends ConsumerStatefulWidget {
  static const String screenName = 'detail';
  static const String path = '/$screenName';

  final PlanetModel? planetModel;

  const DetailScreen({required this.planetModel, super.key});

  @override
  ConsumerState createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
