import 'package:planets_3A/data/models/planet_model.dart';

abstract class HomeDatasource {
  Future<List<PlanetModel>> getPlanets();
}
