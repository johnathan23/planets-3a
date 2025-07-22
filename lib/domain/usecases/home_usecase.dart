import 'package:planets_3A/data/models/planet_model.dart';
import 'package:planets_3A/domain/repositories/home_repository.dart';

class HomeUseCase {
  final HomeRepository repository;

  HomeUseCase(this.repository);

  Future<List<PlanetModel>> execute() => repository.getPlanets();
}
