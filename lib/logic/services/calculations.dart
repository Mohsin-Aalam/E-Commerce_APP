import '../../data/models/cart/cart_modal.dart';

class Calculations {
  static double cartTotal(List<CartModal> items) {
    double total = 0;
    for (int i = 0; i < items.length; i++) {
      total += items[i].product!.price! * items[i].quantity!;
    }
    return total;
  }
}
