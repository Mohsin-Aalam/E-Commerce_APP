import 'package:ecomerce_app/data/models/cart/cart_modal.dart';
import 'package:ecomerce_app/data/models/user/user_model.dart';

class OrderModel {
  String? sId;
  UserModal? user;
  List<CartModal>? items;
  String? status;

  DateTime? createdOn;
  DateTime? updatedOn;

  OrderModel(
      {this.sId,
      this.user,
      this.items,
      this.status,
      this.createdOn,
      this.updatedOn});

  OrderModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = UserModal.fromJson(json["user"]);
    items = (json["items"] as List<dynamic>)
        .map((item) => CartModal.fromJson(item))
        .toList();
    status = json['status'];
    createdOn = DateTime.tryParse(json["createdOn"]);
    updatedOn = DateTime.tryParse(json['updatedOn']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = user!.toJson();
    data['items'] =
        items!.map((item) => item.toJson(objectMode: true)).toList();
    data['status'] = this.status;
    data['createdOn'] = this.createdOn?.toIso8601String();
    data['updatedOn'] = this.updatedOn?.toIso8601String();
    return data;
  }
}
