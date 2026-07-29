import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/favorite/presentation/view/widgets/fav_item_widget.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_state.dart';
import '../../../../../core/routes/app_routes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});
  static const routeName = Routes.favouriteScreen;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteCubit>(
      create: (_) => serviceLocator<FavoriteCubit>()..getFavorite(),
      child: Scaffold(
        appBar: AppBar(title: const Text("My Favourite"), centerTitle: true),
        body: BlocConsumer<FavoriteCubit, FavoriteStates>(
          listener: (context, state) {
            if (state is FavoriteErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error ?? 'An error occurred')),
              );
            }
          },
          builder: (context, state) {
            if (state is FavoriteLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavoriteErrorState) {
              return Center(child: Text(state.error ?? 'An error occurred'));
            } else if (state is FavoriteSuccessState) {
              final products = state.favorites!.productList;

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
                        "There are no products in your favourite list ",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: const Color(0xff2F2F2F),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              print("UI Count = ${products.length}");
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
                      // TODO: Add To Cart
                    },
                    onFavorite: () {
                      _handleToggle(context, product.toEntity().id);
                    },
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Future<void> _handleToggle(BuildContext context, int productId) async {
    final cubit = context.read<FavoriteCubit>();
    final wasFavorite = cubit.isFavorite(productId);
    final result = await cubit.toggleFavorite(productId);

    if (!context.mounted) return;
    switch (result) {
      case Success<String>():
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              wasFavorite ? "Removed from favourites" : "Added to favourites",
            ),
          ),
        );
        break;
      case Error<String>():
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(result.messageError ?? '')));
        break;
    }
  }
}
