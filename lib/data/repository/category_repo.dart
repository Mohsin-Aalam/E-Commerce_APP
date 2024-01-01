import 'package:dio/dio.dart';
import 'package:ecomerce_app/core/api.dart';
import 'package:ecomerce_app/data/models/category/category_modal.dart';

class CategoryRepo {
  final Api _api = Api();
  Future<List<CategoryModal>> fetchAllCategories() async {
    try {
      Response response = await _api.sendRequest.get(
        '/category',
      );
      //  log(" response $response");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((jsonObject) => CategoryModal.fromJson(jsonObject))
          .toList();
    } catch (err) {
      rethrow;
    }
  }
}
