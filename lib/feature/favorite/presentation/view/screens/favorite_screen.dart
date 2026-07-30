import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/view/widgets/fav_item_widget.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_state.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Favourite'), centerTitle: true),
      body: BlocConsumer<FavoriteCubit, FavoriteStates>(
        listener: (context, state) {
          if (state is FavoriteErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error ?? "Something went wrong")),
            );
          }
        },
        builder: (context, state) {
          if (state is FavoriteLoadingState || state is FavoriteIntialState) {
            return const Center(child: CircularProgressIndicator());
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
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 35,
                mainAxisSpacing: 16.75,
                childAspectRatio: 0.58,
              ),
              itemBuilder: (context, index) {
                final product = products[index];

                return FavoriteItemWidget(
                  product: product.toEntity(),
                  onAddToCart: () {
                    context.read<CartCubit>().addToCart(productId: product.id!);
                  },
                  onFavorite: () async {
                    final cubit = context.read<FavoriteCubit>();

                    final wasFavorite = cubit.isFavorite(product.id!);

                    final result = await cubit.toggleFavorite(product.id!);

                    if (!context.mounted) return;

                    switch (result) {
                      case Success<String>():
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              wasFavorite
                                  ? "Removed from favourites"
                                  : "Added to favourites",
                            ),
                          ),
                        );
                        break;

                      case Error<String>():
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result.messageError ?? "")),
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
