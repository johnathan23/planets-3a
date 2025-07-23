import 'dart:convert';

import 'package:planets_3A/data/models/planet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String keyFavorites = 'favorites';

  static final SessionManager _instance = SessionManager._internal();

  late SharedPreferences _prefs;

  SessionManager._internal();

  factory SessionManager() {
    return _instance;
  }

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void deletePreference({required String key}) async {
    await _prefs.remove(key);
  }

  void deletePreferences({required List<String> preferences}) async {
    for (String preference in preferences) {
      await _prefs.remove(preference);
    }
  }

  void deleteAllPreferences() async {
    await _prefs.clear();
  }

  // ? ----------- Add values here -----------

  List<PlanetModel> get favorites {
    final List<String>? jsonList = _prefs.getStringList(keyFavorites);
    if (jsonList == null) return [];
    return jsonList.map((json) => PlanetModel.fromJson(jsonDecode(json))).toList();
  }

  set favorites(List<PlanetModel> value) {
    final List<String> jsonList = value.map((planet) => jsonEncode(planet.toJson())).toList();
    _prefs.setStringList(keyFavorites, jsonList);
  }
}
