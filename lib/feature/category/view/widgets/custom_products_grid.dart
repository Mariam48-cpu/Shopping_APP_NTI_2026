import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/routes/app_routes.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_state.dart';

Widget buildProductsGrid(List<ProductItemEntity> products) {
  if (products.isEmpty) {
    return const Center(child: Text("No products found"));
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
        final product = products[index];

        return BlocBuilder<FavoriteCubit, FavoriteStates>(
          builder: (context, state) {
            return ProductItemCard(
              product: product,

              // هنا الصورة بس هي اللي تفتح الـ Details
              imageOnlyClickable: true,

              isFavorite: context.read<FavoriteCubit>().isFavorite(product.id),

              onFavorite: () {
                context.read<FavoriteCubit>().toggleFavorite(product.id);
              },

              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.productDetailsScreen,
                  arguments: product,
                );
              },
            );
          },
        );
      },
    ),
  );
}
