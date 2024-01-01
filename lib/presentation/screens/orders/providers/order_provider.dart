import 'package:flutter/cupertino.dart';

class OrderDetailProvider with ChangeNotifier {
  String? paymentMethod = "pay-online";
  void changePaymentMethod(String? value) {
    paymentMethod = value;
    notifyListeners();
  }
}
