import 'package:planets_3A/data/datasources/home_datasource_impl.dart';
import 'package:planets_3A/data/models/planet_model.dart';
import 'package:planets_3A/data/repositories/home_repository_impl.dart';
import 'package:planets_3A/domain/datasources/home_datasource.dart';
import 'package:planets_3A/domain/repositories/home_repository.dart';
import 'package:planets_3A/domain/usecases/home_usecase.dart';
import 'package:planets_3A/presentation/ui/home/states/home_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_provider.g.dart';

@riverpod
class HomeProvider extends _$HomeProvider {
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
}
