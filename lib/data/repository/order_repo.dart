import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecomerce_app/core/api.dart';

import 'package:ecomerce_app/data/models/orders/orders_modal.dart';

class OrderRepo {
  final Api _api = Api();
  Future<List<OrderModel>> fetchOrdersForUser(String userId) async {
    try {
      Response response = await _api.sendRequest.get(
        '/order/$userId',
      );
      // log(" response $response");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((jsonObject) => OrderModel.fromJson(jsonObject))
          .toList();
    } catch (err) {
      rethrow;
    }
  }

  Future<OrderModel> createOrder(OrderModel orderModel) async {
    try {
      /// print(data);
      Response response = await _api.sendRequest
          .post('/order', data: jsonEncode(orderModel.toJson()));
      // log(" response $response");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return OrderModel.fromJson(apiResponse.data);
    } catch (err) {
      rethrow;
    }
  }
}
