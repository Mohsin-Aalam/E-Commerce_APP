import 'package:ecomerce_app/data/models/user/user_model.dart';
import 'package:ecomerce_app/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecomerce_app/logic/cubits/cart_cubit/cart_state.dart';
import 'package:ecomerce_app/logic/cubits/order_cubit/order_cubit.dart';
import 'package:ecomerce_app/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecomerce_app/logic/cubits/user_cubit/user_state.dart';
import 'package:ecomerce_app/presentation/screens/orders/order_placed_screen.dart';
import 'package:ecomerce_app/presentation/screens/orders/providers/order_provider.dart';
import 'package:ecomerce_app/presentation/widgets/cart_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class OrderDetailsSrceen extends StatelessWidget {
  static const routeName = "oder_details";

  const OrderDetailsSrceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoadingState) {
                return const CircularProgressIndicator();
              }
              if (state is UserLoggedInState) {
                UserModal userModal = state.userModel;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "User Details:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${userModal.fullName}",
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Email:-${userModal.email}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Phone:-${userModal.phoneNumber}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Address:-${userModal.address}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Text(
                          "|> edit profile <|",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {})
                  ],
                );
              }

              if (state is UserErrorState) {
                return Text(state.message);
              }
              return const SizedBox();
            },
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "Items:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartLoadingState && state.items.isEmpty) {
                return const CircularProgressIndicator();
              }
              if (state is CartErrorState && state.items.isEmpty) {
                return Text(state.message);
              }
              return CartListView(
                items: state.items,
                shrinkWrap: true,
                noScroll: true,
              );
            },
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "Payment:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 12,
          ),
          Consumer<OrderDetailProvider>(builder: (context, provider, child) {
            return Column(
              children: [
                RadioListTile(
                  value: "pay-on-delivery",
                  groupValue: provider.paymentMethod,
                  contentPadding: EdgeInsets.zero,
                  onChanged: provider.changePaymentMethod,
                  title: const Text("Pay on Delivery"),
                ),
                RadioListTile(
                  value: "pay-online",
                  groupValue: provider.paymentMethod,
                  contentPadding: EdgeInsets.zero,
                  onChanged: provider.changePaymentMethod,
                  title: const Text("Pay Online"),
                ),
                const SizedBox(
                  height: 24,
                ),
                CupertinoButton(
                  color: Colors.blueGrey,
                  onPressed: () async {
                    bool success = await BlocProvider.of<OrderCubit>(context)
                        .createOrder(
                            items:
                                BlocProvider.of<CartCubit>(context).state.items,
                            paymentMethod: Provider.of<OrderDetailProvider>(
                                    context,
                                    listen: false)
                                .paymentMethod
                                .toString());
                    if (success) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushNamed(context, OrderPlacedScreen.routeName);
                    }
                  },
                  child: const Text("Place Order"),
                )
              ],
            );
          }),
        ],
      )),
    );
  }
}
