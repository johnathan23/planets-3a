import 'package:freezed_annotation/freezed_annotation.dart';

part 'planet_model.freezed.dart';
part 'planet_model.g.dart';

@freezed
abstract class PlanetModel with _$PlanetModel {
  const factory PlanetModel({
    required String? name,
    @JsonKey(name: 'orbital_distance_km') required int? orbitalDistanceKm,
    @JsonKey(name: 'equatorial_radius_km') required int? equatorialRadiusKm,
    @JsonKey(name: 'volume_km3', fromJson: _parseVolumeKm3) required String? volumeKm3,
    @JsonKey(name: 'mass_kg') required String? massKg,
    @JsonKey(name: 'density_g_cm3') required double? densityGcm3,
    @JsonKey(name: 'surface_gravity_m_s2') required double? surfaceGravityMs2,
    @JsonKey(name: 'escape_velocity_kmh') required int? escapeVelocityKmh,
    @JsonKey(name: 'day_length_earth_days') required double? dayLengthEarthDays,
    @JsonKey(name: 'year_length_earth_days') required double? yearLengthEarthDays,
    @JsonKey(name: 'orbital_speed_kmh') required int? orbitalSpeedKmh,
    @JsonKey(name: 'atmosphere_composition') required String? atmosphereComposition,
    required int? moons,
    required String? image,
    required String? description,
    @Default(false) bool isFavorite,
  }) = _PlanetModel;

  factory PlanetModel.fromJson(Map<String, dynamic> json) => _$PlanetModelFromJson(json);
}

String _parseVolumeKm3(dynamic value) {
  if (value == null) return '';

  if (value is String) return value;

  if (value is int || value is double) {
    return value.toString();
  }

  throw FormatException('Unexpected type for volume_km3: $value');
}
