import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecomerce_app/core/api.dart';
import 'package:ecomerce_app/data/models/cart/cart_modal.dart';

class CartRepo {
  final Api _api = Api();
  Future<List<CartModal>> fetchCartForUser(String userId) async {
    try {
      Response response = await _api.sendRequest.get(
        '/Cart/$userId',
      );
      // log(" response $response");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((jsonObject) => CartModal.fromJson(jsonObject))
          .toList();
    } catch (err) {
      rethrow;
    }
  }

  Future<List<CartModal>> addProductToCart(
      CartModal cartItems, String userId) async {
    try {
      Map<String, dynamic> data = cartItems.toJson();
      data["user"] = userId;

      /// print(data);
      Response response =
          await _api.sendRequest.post('/Cart', data: jsonEncode(data));
      //  log(" response $response");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((jsonObject) => CartModal.fromJson(jsonObject))
          .toList();
    } catch (err) {
      rethrow;
    }
  }

  Future<List<CartModal>> removeFromCart(
      String productId, String userId) async {
    try {
      Map<String, dynamic> data = {"user": userId, "product": productId};
      //print(data);
      Response response =
          await _api.sendRequest.delete('/Cart', data: jsonEncode(data));
      //log(" response $response");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((jsonObject) => CartModal.fromJson(jsonObject))
          .toList();
    } catch (err) {
      rethrow;
    }
  }
}
