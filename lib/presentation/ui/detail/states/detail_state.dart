import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planets_3A/data/models/planet_model.dart';

part 'detail_state.freezed.dart';
part 'detail_state.g.dart';

@freezed
abstract class DetailState with _$DetailState {
  const factory DetailState({
    List<PlanetModel>? planets,
    PlanetModel? planet,
    @Default(false) bool isFavorite,
    @Default(false) bool exists,
    @Default(false) bool hasError,
    String? errorMessage,
  }) = _DetailState;

  factory DetailState.fromJson(Map<String, dynamic> json) => _$DetailStateFromJson(json);
}
