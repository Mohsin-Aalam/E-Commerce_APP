import 'package:ecomerce_app/logic/cubits/category_product_cubit/category_product_cubit.dart';
import 'package:ecomerce_app/logic/cubits/category_product_cubit/category_product_state.dart';
import 'package:ecomerce_app/presentation/widgets/grid_items.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductScreen extends StatelessWidget {
  static const routeName = "category_products";
  const CategoryProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CategoryProductCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${cubit.category.title}"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CategoryProductCubit, CategoryProductState>(
          builder: (context, state) {
            if (state is CategoryProductLoadingState &&
                state.products.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CategoryProductErrorState && state.products.isEmpty) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is CategoryProductLoadedState && state.products.isEmpty) {
              return const Center(
                child: Text("No Products Found yet!"),
              );
            }

            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 350,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12),
                itemCount: state.products.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return GridItems(product: product);
                });
          },
        ),
      )),
    );
  }
}
