import 'package:planets_3A/data/models/planet_model.dart';

abstract class HomeRepository {
  Future<List<PlanetModel>> getPlanets();
}
