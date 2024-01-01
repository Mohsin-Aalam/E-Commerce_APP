import 'package:ecomerce_app/data/models/products/product_modal.dart';
import 'package:ecomerce_app/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecomerce_app/logic/cubits/cart_cubit/cart_state.dart';
import 'package:ecomerce_app/logic/services/formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const String routeName = "ProductDetailsScreen";
  final ProductModal productModal;
  const ProductDetailsScreen({super.key, required this.productModal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${productModal.title}"),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width,
            child: CarouselSlider.builder(
              itemCount: productModal.images?.length ?? 0,
              slideBuilder: (index) {
                String url = productModal.images![index];
                return Image.network(
                  url,
                );
              },
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${productModal.title}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 28),
                ),
                Text(
                  Formatter.formatPrice(
                    productModal.price!,
                  ),
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 24),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      bool isInCart = BlocProvider.of<CartCubit>(context)
                          .cartContains(productModal);
                      return CupertinoButton(
                          onPressed: () {
                            if (isInCart) {
                              return;
                            }
                            BlocProvider.of<CartCubit>(context)
                                .addToCart(productModal, 1);
                          },
                          minSize: 56,
                          padding: EdgeInsets.zero,
                          color: (isInCart)
                              ? Colors.grey
                              : const Color.fromARGB(255, 26, 129, 133),
                          child: (isInCart)
                              ? const Text("Product added to cart",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24))
                              : const Text(
                                  "Add To Cart",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ));
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Text(
                  "${productModal.description}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 14),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
