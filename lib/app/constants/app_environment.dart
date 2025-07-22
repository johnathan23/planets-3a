import 'package:planets_3A/app/constants/app_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static final String _baseUrl = 'API_ENDPOINT';

  static Future<void> _loadEnvironmentData(String fileName) async {
    try {
      await dotenv.load(fileName: fileName);
    } catch (error) {
      throw Exception('Failed to load environment variables from env file: $error');
    }
  }

  static Future<void> load() => _loadEnvironmentData(kPathToEnv);

  static String? _getValue({required String key}) => dotenv.get(key);

  // ? ----------- Add values here -----------

  static String get baseUrl => _getValue(key: _baseUrl) ?? '';
  static set baseUrl(String value) => dotenv.env[_baseUrl] = value;
}
