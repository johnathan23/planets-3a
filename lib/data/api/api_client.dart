import 'package:planets_3A/app/constants/app_constants.dart';
import 'package:planets_3A/app/theme/app_dimension.dart';
import 'package:planets_3A/data/models/base/base_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'dio_config.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient({String? otherUrl}) {
    return _ApiClient(DioConfig.createDio(url: otherUrl ?? kApiBaseUrl));
  }

  @GET('/planets.json')
  Future<BaseResponse> getPlanets();
}
