import 'package:planets_3A/app/constants/app_constants.dart';
import 'package:planets_3A/data/models/planet_model.dart';

extension PlanetExtension on PlanetModel {
  String get imageUrl {
    if (image == null || image?.isEmpty == true) {
      return '';
    }
    return '$kApiBaseUrl/$kApiVersion/$kApiPathData/$image';
  }

  bool matchesQuery(String query) {
    final q = query.toLowerCase();
    return [
      name,
      orbitalDistanceKm?.toString(),
      equatorialRadiusKm?.toString(),
      volumeKm3?.toString(),
      massKg,
      densityGcm3?.toString(),
      surfaceGravityMs2?.toString(),
      escapeVelocityKmh?.toString(),
      dayLengthEarthDays?.toString(),
      yearLengthEarthDays?.toString(),
      orbitalSpeedKmh?.toString(),
      atmosphereComposition,
      moons?.toString(),
      description,
    ].whereType<String>().map((field) => field.toLowerCase()).any((field) => field.contains(q));
  }

  List<String> getAtmosphereComposition() {
    if (atmosphereComposition?.isEmpty == true) {
      return [];
    }
    return atmosphereComposition!.split(',').map((e) => e.trim()).toList();
  }

  List<MapEntry<String, String>> get formattedStats {
    final rawData = {
      'orbitalDistanceKm': orbitalDistanceKm?.toString(),
      'equatorialRadiusKm': equatorialRadiusKm?.toString(),
      'volumeKm3': volumeKm3,
      'massKg': massKg,
      'densityGcm3': densityGcm3?.toString(),
      'surfaceGravityMs2': surfaceGravityMs2?.toString(),
      'escapeVelocityKmh': escapeVelocityKmh?.toString(),
      'dayLengthEarthDays': dayLengthEarthDays?.toString(),
      'yearLengthEarthDays': yearLengthEarthDays?.toString(),
      'orbitalSpeedKmh': orbitalSpeedKmh?.toString(),
      'moons': moons?.toString(),
    };

    return rawData.entries.map((entry) {
      final formattedName = _formatStatName(entry.key);
      final value = entry.value ?? 'Unknown';
      return MapEntry(formattedName, value);
    }).toList();
  }

  String _formatStatName(String key) {
    final buffer = StringBuffer();
    for (int i = 0; i < key.length; i++) {
      final char = key[i];
      if (i == 0) {
        buffer.write(char.toUpperCase());
      } else if (char == '_') {
        buffer.write(' ');
      } else if (char.toUpperCase() == char && char != char.toLowerCase()) {
        buffer.write(' $char');
      } else {
        buffer.write(char);
      }
    }
    return buffer.toString();
  }
}
