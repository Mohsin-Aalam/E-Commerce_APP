import 'package:ecomerce_app/data/models/products/product_modal.dart';

abstract class ProductState {
  final List<ProductModal> product;
  ProductState(this.product);
}

class ProductInitialState extends ProductState {
  ProductInitialState() : super([]);
}

class ProductLoadingsState extends ProductState {
  ProductLoadingsState(super.product);
}

class ProductLoadedState extends ProductState {
  ProductLoadedState(super.product);
}

class ProductErrorState extends ProductState {
  final String message;
  ProductErrorState(super.product, this.message);
}
