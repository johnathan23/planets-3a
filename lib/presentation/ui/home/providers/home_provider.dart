import 'package:planets_3A/core/extensions/planet_extension.dart';
import 'package:planets_3A/data/models/planet_model.dart';
import 'package:planets_3A/data/repositories/home_repository_impl.dart';
import 'package:planets_3A/domain/repositories/home_repository.dart';
import 'package:planets_3A/domain/usecases/home_usecase.dart';
import 'package:planets_3A/presentation/ui/home/states/home_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_provider.g.dart';

@riverpod
class Home extends _$Home {
  @override
  HomeState build() {
    return HomeState();
  }

  HomeUseCase get _homeUseCase {
    final HomeRepository homeRepository = HomeRepositoryImpl();
    return HomeUseCase(homeRepository);
  }

  Future<void> getPlanets() async {
    state = state.copyWith(isLoading: true, hasError: false);
    try {
      final List<PlanetModel> planets = await _homeUseCase.execute();
      state = state.copyWith(planets: planets, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, hasError: true, errorMessage: e.toString());
      throw Exception('Error get planets: $e');
    }
  }

  Future<void> searchPlanet(String query) async {
    state = state.copyWith(isLoading: true, hasError: false);
    try {
      if (query.isEmpty) {
        await getPlanets();
        return;
      }
      final List<PlanetModel>? planets = state.planets?.where((planet) => planet.matchesQuery(query)).toList();
      state = state.copyWith(planets: planets, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, hasError: true, errorMessage: e.toString());
      throw Exception('Error search planet: $e');
    }
  }
}
