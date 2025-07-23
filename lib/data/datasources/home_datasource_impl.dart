import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:planets_3A/core/utils/custom_console.dart';
import 'package:planets_3A/data/api/api_client.dart';
import 'package:planets_3A/data/models/base/base_response.dart';
import 'package:planets_3A/data/models/planet_model.dart';
import 'package:planets_3A/domain/datasources/home_datasource.dart';
import 'package:planets_3A/domain/enum/log_level_enum.dart';

class HomeDatasourceImpl implements HomeDatasource {
  late final ApiClient _apiClient;

  HomeDatasourceImpl() {
    _apiClient = ApiClient();
  }

  @override
  Future<List<PlanetModel>> getPlanets() async {
    try {
      final BaseResponse response = await _apiClient.getPlanets();
      final List<PlanetModel> planets =
      (response.data as List<dynamic>).map((element) => PlanetModel.fromJson(element)).toList();
      return planets;
      /*final data = await rootBundle.loadString("assets/jsons/planets.json");
      final BaseResponse<List<PlanetModel>> response = BaseResponse.fromJson(
        json.decode(data),
        (jsonData) => (jsonData as List<dynamic>).map((e) => PlanetModel.fromJson(e as Map<String, dynamic>)).toList(),
      );
      return response.data;*/
    } catch (e) {
      CustomConsole.log(message: 'Error to get planets', error: e.toString(), level: LogLevel.warning);
      rethrow;
    }
  }
}
