import 'dart:developer';

import 'package:ecomerce_app/data/models/cart/cart_modal.dart';
import 'package:ecomerce_app/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecomerce_app/logic/services/formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';

class CartListView extends StatelessWidget {
  final List<CartModal> items;
  final bool shrinkWrap;
  final bool noScroll;
  const CartListView(
      {super.key,
      required this.items,
      this.shrinkWrap = false,
      this.noScroll = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: (noScroll) ? const NeverScrollableScrollPhysics() : null,
        shrinkWrap: shrinkWrap,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
              leading: Image.network(
                item.product!.images![0],
                width: MediaQuery.of(context).size.width / 5.2,
              ),
              title: Text(
                "${item.product?.title}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${Formatter.formatPrice(item.product!.price!)} X ${item.quantity} =${Formatter.formatPrice(item.product!.price! * item.quantity!)}"),
                  CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        BlocProvider.of<CartCubit>(context)
                            .removeFromCart(item.product!);
                      },
                      child: const Text("delete"))
                ],
              ),
              trailing: InputQty(
                initVal: item.quantity!,
                maxVal: 99,
                minVal: 1,
                qtyFormProps: const QtyFormProps(enableTyping: false),
                onQtyChanged: (value) {
                  log("i am updating");
                  BlocProvider.of<CartCubit>(context)
                      .addToCart(item.product!, value.toInt());
                },
                decoration: const QtyDecorationProps(
                    width: 14,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    qtyStyle: QtyStyle.classic),
              ));
        });
  }
}
