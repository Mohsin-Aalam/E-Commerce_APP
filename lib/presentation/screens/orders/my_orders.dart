import 'package:ecomerce_app/logic/cubits/order_cubit/order_cubit.dart';
import 'package:ecomerce_app/logic/cubits/order_cubit/order_state.dart';
import 'package:ecomerce_app/logic/services/calculations.dart';
import 'package:ecomerce_app/logic/services/formatter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});
  static const routeName = "my_orders";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
      ),
      body: SafeArea(
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state is OrderLoadingState) {
              return const CircularProgressIndicator();
            }
            if (state is OrderErrorState && state.orders.isEmpty) {
              return Text(state.message);
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.orders.length,
              separatorBuilder: (context, index) => Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              itemBuilder: (context, index) {
                final order = state.orders[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("#${order.sId}",
                        style:
                            const TextStyle(fontSize: 24, color: Colors.grey)),
                    Text(
                      " ${Formatter.formatDate(order.createdOn!)}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 47, 175, 207)),
                    ),
                    Text(
                        "Total Amount: ${Formatter.formatPrice(Calculations.cartTotal(order.items!))}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    ListView.builder(
                      itemCount: order.items!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = order.items![index];
                        final product = item.product!;
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Image.network(
                            product.images![0],
                            width: MediaQuery.of(context).size.width / 5.2,
                          ),
                          title: Text("${product.title}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                          subtitle: Text("Qty:${item.quantity}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey)),
                          trailing: Text(
                              Formatter.formatPrice(
                                  product.price! * item.quantity!),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        );
                      },
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
