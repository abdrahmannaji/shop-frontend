import 'package:dio/dio.dart';

class ApiResponse {
  var response;
  dynamic error;

  ApiResponse(this.response, this.error);
  ApiResponse.withSuccess(Response responseValue)
      : response = responseValue,
        error = null;
  ApiResponse.withError(dynamic errorValue)
      : error = errorValue,
        response = null;
}
