import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Success {
  int? code;
  dynamic successResponse;
  Success({this.code, this.successResponse});
}

class Failure {
  int? code;
  dynamic errorResponse;
  Failure({this.code, this.errorResponse});
}

class ApiClient {
  static final dios = Dio();

  static Future<dynamic> getRequest(String url, Options? options) async {
    try {
      final response = await dios.get(url, options: options);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(url);
          print(response);
        }
        return response;
      } else {
        return response;
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          if (kDebugMode) {
            print('Server Error: ${e.response!.statusCode}');
            print('Error Data: ${e.response!.data}');
          }

          return e.response;
        } else {
          if (kDebugMode) {
            print('Network Error: ${e.message}');
          }

          return e.response;
        }
      } else {
        rethrow;
      }
    }
  }
}
