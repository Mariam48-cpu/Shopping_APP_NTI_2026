import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';
import 'package:shopping_app/feature/category/view_model/category_products_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_state.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/routes/app_routes.dart';
import '../../view_model/category_products_state.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  const ProductsByCategoryScreen({
    super.key,
    required this.slug,
    required this.categoryName,
  });

  final String slug;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          serviceLocator<ProductsByCategoryCubit>()
            ..intent(GetAllProductsByCategoryIntent(slug: slug)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(categoryName),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.searchScreen);
                },
                icon: SvgPicture.asset("assets/icon/magnifier.svg"),
              ),
            ),
          ],
        ),
        body: BlocBuilder<ProductsByCategoryCubit, CategoryProductsState>(
          builder: (context, state) {
            if (state is CategoryInitialState ||
                state is CategoryLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoryErrorState) {
              return Center(
                child: Text(state.messageError ?? "Something went wrong"),
              );
            } else if (state is CategoryEmptyState) {
              return const Center(child: Text('No products found.'));
            } else if (state is CategorySuccessState) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.62,
                  ),
                  itemBuilder: (context, index) {
                    final product = state.products[index];

                    return BlocBuilder<FavoriteCubit, FavoriteStates>(
                      builder: (context, favoriteState) {
                        return ProductItemCard(
                          product: product,
                          isFavorite: context.read<FavoriteCubit>().isFavorite(
                            product.id,
                          ),

                          onFavorite: () {
                            context.read<FavoriteCubit>().toggleFavorite(
                              product.id,
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
                  itemCount: state.products.length,
                ),
              );
            }
            return Center(child: Text('Unknown State: ${state.runtimeType}'));
          },
        ),
      ),
    );
  }
}
