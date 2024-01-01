import 'package:dio/dio.dart';
import 'package:ecomerce_app/core/api.dart';

import 'package:ecomerce_app/data/models/products/product_modal.dart';

class ProductRepo {
  final Api _api = Api();
  Future<List<ProductModal>> fetchAllProducts() async {
    try {
      Response response = await _api.sendRequest.get(
        '/product',
      );
      //log(" response $response");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((jsonObject) => ProductModal.fromJson(jsonObject))
          .toList();
    } catch (err) {
      rethrow;
    }
  }

  Future<List<ProductModal>> fetchProductsByCategory(String categoryId) async {
    try {
      Response response = await _api.sendRequest.get(
        '/product/category/$categoryId',
      );
      //log(" response $response");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((jsonObject) => ProductModal.fromJson(jsonObject))
          .toList();
    } catch (err) {
      rethrow;
    }
  }
}
