import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key});
  static const String routeName = "order_placed";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Placed!"),
      ),
      body: const SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.cube_box_fill,
              size: 100,
              color: Colors.grey,
            ),
            Text(
              "Order Placed!",
              style: TextStyle(fontSize: 34, color: Colors.grey),
            ),
            Text(
              "you can check out the status by going to\n Profile -> Orders",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            )
          ],
        ),
      )),
    );
  }
}
