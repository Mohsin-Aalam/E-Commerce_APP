import 'package:ecomerce_app/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecomerce_app/logic/cubits/cart_cubit/cart_state.dart';
import 'package:ecomerce_app/logic/services/calculations.dart';
import 'package:ecomerce_app/logic/services/formatter.dart';
import 'package:ecomerce_app/presentation/screens/orders/order_detail.dart';
import 'package:ecomerce_app/presentation/widgets/cart_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = "cart";
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoadingState && state.items.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartErrorState && state.items.isEmpty) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is CartLoadedState && state.items.isEmpty) {
              return const Center(
                child: Text("Cart items will show up here..."),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: CartListView(
                    items: state.items,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${state.items.length} items",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          Text(
                            " Total: ${Formatter.formatPrice(Calculations.cartTotal(state.items))}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ],
                      )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: CupertinoButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, OrderDetailsSrceen.routeName);
                          },
                          color: const Color.fromARGB(255, 87, 194, 176),
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width / 22),
                          child: const Text("Place Order"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
