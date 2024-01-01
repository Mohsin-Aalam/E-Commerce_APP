import 'package:ecomerce_app/data/models/products/product_modal.dart';

abstract class CategoryProductState {
  final List<ProductModal> products;
  CategoryProductState(this.products);
}

class CategoryProductInitialState extends CategoryProductState {
  CategoryProductInitialState() : super([]);
}

class CategoryProductLoadingState extends CategoryProductState {
  CategoryProductLoadingState(super.products);
}

class CategoryProductLoadedState extends CategoryProductState {
  CategoryProductLoadedState(super.products);
}

class CategoryProductErrorState extends CategoryProductState {
  final String message;
  CategoryProductErrorState(super.products, this.message);
}
