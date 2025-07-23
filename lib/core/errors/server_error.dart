import 'package:dio/dio.dart';
import 'package:planets_3A/core/utils/custom_console.dart';
import 'package:planets_3A/domain/enum/log_level_enum.dart';

class ServerError implements Exception {
  int? _errorCode;
  String? _errorMessage;

  void catchError({required Object error, String? nameApi}) {
    if (error is DioException) _handleError(error);
    CustomConsole.log(message: 'error code: $_errorCode, error message: $_errorMessage', level: LogLevel.info);
  }

  int? get errorCode => _errorCode;
  String? get errorMsg => _errorMessage;

  void _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        _errorMessage = 'Petition cancelled.';
        break;

      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        _errorMessage = 'The connection timed out.';
        break;

      case DioExceptionType.badCertificate:
        _errorMessage = 'The certificates are wrong.';
        break;

      case DioExceptionType.connectionError:
        _errorMessage = 'The server is not running.';
        break;

      case DioExceptionType.unknown:
        _errorMessage = error.message;
        break;

      case DioExceptionType.badResponse:
        _errorCode = error.response?.statusCode;
        _errorMessage = _validateErrorCodes(_errorCode ?? 0);
        break;
    }
  }

  String _validateErrorCodes(int errorCode) {
    switch (errorCode) {
      case 0:
        return 'The response is empty.';
      case 400:
        return 'Sorry, an error has occurred.';
      case 401:
        return 'Without authority.';
      case 403:
        return 'Restricted access.';
      case 404:
        return 'Not found.';
      case 500:
        return 'A server error has occurred. Please try again later. If the error persists, please contact us.';
      default:
        return "Response code received: $errorCode.";
    }
  }
}
