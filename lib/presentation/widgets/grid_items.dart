import 'package:ecomerce_app/data/models/products/product_modal.dart';
import 'package:ecomerce_app/logic/services/formatter.dart';
import 'package:ecomerce_app/presentation/screens/product/product_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridItems extends StatelessWidget {
  const GridItems({
    super.key,
    required this.product,
  });

  final ProductModal product;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.pushNamed(context, ProductDetailsScreen.routeName,
            arguments: product);
      },
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 236, 241, 240),
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              child: Image.network(
                "${product.images?[0]}",
                width: double.infinity,
                height: 170,
                fit: BoxFit.cover,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${product.title}",
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text('${product.description},',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(Formatter.formatPrice(product.price!)),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(CupertinoIcons.heart)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(CupertinoIcons.cart))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
