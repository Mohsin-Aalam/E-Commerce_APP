import 'package:ecomerce_app/logic/cubits/product_cubit/product_cubit.dart';
import 'package:ecomerce_app/logic/cubits/product_cubit/product_state.dart';

import 'package:ecomerce_app/presentation/widgets/grid_items.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingsState && state.product.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductErrorState && state.product.isEmpty) {
            return Center(
              child: Text(state.message),
            );
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 350,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12),
              itemCount: state.product.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final product = state.product[index];
                return GridItems(product: product);
              });
        },
      ),
    );
  }
}
