import 'package:planets_3A/data/datasources/home_datasource_impl.dart';
import 'package:planets_3A/data/models/planet_model.dart';
import 'package:planets_3A/domain/datasources/home_datasource.dart';
import 'package:planets_3A/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  late final HomeDatasource datasource;

  HomeRepositoryImpl() {
    datasource = HomeDatasourceImpl();
  }

  @override
  Future<List<PlanetModel>> getPlanets() async => await datasource.getPlanets();
}
