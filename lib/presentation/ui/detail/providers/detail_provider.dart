import 'package:planets_3A/core/db/session/session_manager.dart';
import 'package:planets_3A/data/models/planet_model.dart';
import 'package:planets_3A/presentation/ui/detail/states/detail_state.dart';
import 'package:planets_3A/presentation/ui/home/providers/home_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_provider.g.dart';

@riverpod
class Detail extends _$Detail {
  @override
  DetailState build() {
    return DetailState();
  }

  Future<void> getPlanet(String planetName) async {
    try {
      final List<PlanetModel>? planets = ref.read(homeProvider).planets;
      final PlanetModel? planetModel = planets?.where((planet) => planet.name == planetName).firstOrNull;
      final favorites = SessionManager().favorites;
      bool isFavorite = favorites.any((p) => p.name?.toLowerCase() == planetModel?.name?.toLowerCase());
      bool exists = planets?.any((p) => p.name?.toLowerCase() == planetName.toLowerCase()) ?? false;
      state = state.copyWith(planet: planetModel, planets: planets, isFavorite: isFavorite, exists: exists);
    } catch (e) {
      state = state.copyWith(hasError: true, errorMessage: e.toString());
      throw Exception('Error get planet: $e');
    }
  }

  Future<void> setPlanetFavorite(bool shouldBeFavorite) async {
    try {
      final sessionManager = SessionManager();
      final List<PlanetModel> updatedFavorites = [...sessionManager.favorites];

      final exists = updatedFavorites.any((p) => p.name?.toLowerCase() == state.planet?.name?.toLowerCase());

      if (shouldBeFavorite && !exists) {
        updatedFavorites.add(state.planet!);
        state = state.copyWith(isFavorite: true);
      } else if (!shouldBeFavorite && exists) {
        updatedFavorites.removeWhere((p) => p.name?.toLowerCase() == state.planet?.name?.toLowerCase());
        state = state.copyWith(isFavorite: false);
      }
      sessionManager.favorites = updatedFavorites;
    } catch (e) {
      state = state.copyWith(hasError: true, errorMessage: e.toString());
      throw Exception('Error set planet favorite: $e');
    }
  }
}
