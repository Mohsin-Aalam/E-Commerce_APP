import 'package:ecomerce_app/data/models/products/product_modal.dart';

class CartModal {
  int? quantity;
  String? sId;
  ProductModal? product;

  CartModal({this.quantity, this.sId, this.product});

  CartModal.fromJson(Map<String, dynamic> json) {
    product = ProductModal.fromJson(json["product"]);
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson({bool objectMode = false}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = (objectMode == false) ? product!.sId : product!.toJson();
    data['quantity'] = this.quantity;
    data['_id'] = this.sId;
    return data;
  }
}
