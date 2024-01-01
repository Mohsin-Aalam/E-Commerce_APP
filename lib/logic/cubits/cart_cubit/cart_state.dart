import 'package:ecomerce_app/data/models/cart/cart_modal.dart';

abstract class CartState {
  final List<CartModal> items;
  CartState(this.items);
}

class CartInitialState extends CartState {
  CartInitialState() : super([]);
}

class CartLoadingState extends CartState {
  CartLoadingState(super.items);
}

class CartLoadedState extends CartState {
  CartLoadedState(super.items);
}

class CartErrorState extends CartState {
  final String message;
  CartErrorState(super.items, this.message);
}
