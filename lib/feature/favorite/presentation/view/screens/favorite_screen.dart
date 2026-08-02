import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/core/utils/app_toast.dart';
import 'package:shopping_app/feature/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:shopping_app/feature/category/view/widgets/product_grid_skeleton.dart';
import 'package:shopping_app/feature/favorite/presentation/view/widgets/fav_item_widget.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_state.dart';
import 'package:toastification/toastification.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Favourite'), centerTitle: true),
      body: BlocConsumer<FavoriteCubit, FavoriteStates>(
        listener: (context, state) {
          if (state is FavoriteErrorState) {
            AppToast.showToast(
              context: context,
              title: "Error",
              description: state.error ?? "Something went wrong",
              type: ToastificationType.error,
            );
          }
        },
        builder: (context, state) {
          if (state is FavoriteLoadingState || state is FavoriteIntialState) {
            return const ProductGridSkeleton();
          }

          if (state is FavoriteErrorState) {
            return Center(child: Text(state.error ?? "Something went wrong"));
          }

          if (state is FavoriteSuccessState) {
            final products = state.favorites?.productList ?? [];

            if (products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 120,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "There are no products in your favourite list",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 320,
              ),
              itemBuilder: (context, index) {
                final product = products[index];

                return FavoriteItemWidget(
                  product: product.toEntity(),
                  onAddToCart: () {
                    context.read<CartCubit>().addToCart(productId: product.id!);
                    AppToast.showToast(
                      context: context,
                      title: "Success",
                      description: "Added to cart",
                      type: ToastificationType.success,
                    );
                  },
                  onFavorite: () async {
                    final cubit = context.read<FavoriteCubit>();

                    final wasFavorite = cubit.isFavorite(product.id!);

                    final result = await cubit.toggleFavorite(product.id!);

                    if (!context.mounted) return;

                    switch (result) {
                      case Success<String>():
                        AppToast.showToast(
                          context: context,
                          title: "Success",
                          description: wasFavorite
                              ? "Removed from favourites"
                              : "Added to favourites",
                          type: ToastificationType.success,
                        );
                        break;

                      case Error<String>():
                        AppToast.showToast(
                          context: context,
                          title: "Error",
                          description:
                              result.messageError ?? "Something went wrong",
                          type: ToastificationType.error,
                        );
                        break;
                    }
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
