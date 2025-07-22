import 'package:planets_3A/app/constants/app_constants.dart';
import 'package:planets_3A/data/models/planet_model.dart';

extension PlanetExtension on PlanetModel{

   String get imageUrl{
    if (image == null || image?.isEmpty == true) {
      return '';
    }
    return '$kApiBaseUrl/$kApiVersion/$kApiPathData/$image';
  }
}
