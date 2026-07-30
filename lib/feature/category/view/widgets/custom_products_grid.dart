import 'package:flutter/material.dart';
import '../../../../core/model/item/product_item_entity.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/widgets/product_item_card.dart';

Widget buildProductsGrid(List<ProductItemEntity> products) {
  if (products.isEmpty) {
    return const Center(
      child: Text("No products found"),
    );
  }

  return Padding(
    padding: const EdgeInsets.all(8),
    child: GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) {
        return ProductItemCard(
          product: products[index],
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.productDetailsScreen,
              arguments: products[index],
            );
          },
        );
      },
    ),
  );
}