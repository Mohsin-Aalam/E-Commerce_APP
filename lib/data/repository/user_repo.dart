import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecomerce_app/core/api.dart';
import 'package:ecomerce_app/data/models/user/user_model.dart';

class UserRepo {
  final Api _api = Api();
  Future<UserModal> createAccount(
      {required String email, required String password}) async {
    try {
      Response response = await _api.sendRequest.post(
        '/user/createAccount',
        data: jsonEncode({
          "email": email,
          "password": password,
        }),
      );
      //log(" response $response");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return UserModal.fromJson(apiResponse.data);
    } catch (err) {
      rethrow;
    }
  }

  Future<UserModal> signIn(
      {required String email, required String password}) async {
    try {
      Response response = await _api.sendRequest.post(
        '/user/signIn',
        data: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return UserModal.fromJson(apiResponse.data);
    } catch (err) {
      rethrow;
    }
  }

  Future<UserModal> updateUser(
    UserModal userModal,
  ) async {
    try {
      Response response = await _api.sendRequest.put(
        '/user/${userModal.sId}',
        data: jsonEncode(userModal.toJson()),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return UserModal.fromJson(apiResponse.data);
    } catch (err) {
      rethrow;
    }
  }
}
