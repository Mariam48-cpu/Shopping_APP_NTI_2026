import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/routes/app_routes.dart';
import 'package:shopping_app/core/utils/app_toast.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_state.dart';
import 'package:toastification/toastification.dart';

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
        childAspectRatio: .68,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return BlocBuilder<FavoriteCubit, FavoriteStates>(
          builder: (context, state) {
            return ProductItemCard(
              product: product,
              imageOnlyClickable: true,
              isFavorite: context.read<FavoriteCubit>().isFavorite(product.id),

              onFavorite: () {
                final wasFavorite = context.read<FavoriteCubit>().isFavorite(
                  product.id,
                );
                context.read<FavoriteCubit>().toggleFavorite(product.id);
                AppToast.showToast(
                  context: context,
                  title: "Success",
                  description: wasFavorite
                      ? "Removed from favourites"
                      : "Added to favourites",
                  type: ToastificationType.success,
                );
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
