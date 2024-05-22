import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_assignment/models/orders_model.dart';
import 'package:flutter_assignment/models/portfolio_model.dart';
import 'package:flutter_assignment/service/response_handler.dart';

class APIService {
  static String baseUrl = 'https://api-cryptiva.azure-api.net/staging/api/v1';

  static Future<dynamic> fetchOrders() async {
    try {
      final options = Options();
      Response response =
          await ApiClient.getRequest('$baseUrl/orders/open', options);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("success");
          print(response.statusCode);
        }
        Map<String, dynamic> values = response.data;
        return Success(
            code: response.statusCode,
            successResponse: OrdersModel.fromJson(values));
      } else {
        if (kDebugMode) {
          print("failure");
          print(response.statusCode);
        }
        return Failure(code: response.statusCode, errorResponse: response.data);
      }
    } catch (error) {
      return Failure(code: -1, errorResponse: error.toString());
    }
  }

  static Future<dynamic> fetchPortfolios() async {
    try {
      final options = Options();
      Response response =
          await ApiClient.getRequest('$baseUrl/accounts/portfolio', options);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("success");
          print(response.statusCode);
        }
        Map<String, dynamic> values = response.data;
        return Success(
            code: response.statusCode,
            successResponse: PortfolioModel.fromJson(values));
      } else {
        if (kDebugMode) {
          print("failure");
          print(response.statusCode);
        }
        return Failure(code: response.statusCode, errorResponse: response.data);
      }
    } catch (error) {
      return Failure(code: -1, errorResponse: error.toString());
    }
  }
}
