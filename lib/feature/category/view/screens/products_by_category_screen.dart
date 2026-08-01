import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping_app/core/utils/app_toast.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';
import 'package:shopping_app/feature/category/view/widgets/product_grid_skeleton.dart';
import 'package:shopping_app/feature/category/view_model/category_products_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_state.dart';
import 'package:toastification/toastification.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsByCategoryCubit>(
          create: (_) =>
              serviceLocator<ProductsByCategoryCubit>()
                ..intent(GetAllProductsByCategoryIntent(slug: slug)),
        ),
        BlocProvider<FavoriteCubit>.value(
          value: serviceLocator<FavoriteCubit>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(categoryName),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.productSearchScreen);
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
              return const ProductGridSkeleton();
            }

            if (state is CategoryErrorState) {
              return Center(
                child: Text(state.messageError ?? "Something went wrong"),
              );
            }

            if (state is CategoryEmptyState) {
              return const Center(child: Text("No products found."));
            }

            if (state is CategorySuccessState) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: BlocBuilder<FavoriteCubit, FavoriteStates>(
                  builder: (context, favoriteState) {
                    return GridView.builder(
                      itemCount: state.products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: .68,
                          ),
                      itemBuilder: (context, index) {
                        final product = state.products[index];

                        return ProductItemCard(
                          key: ValueKey(product.id),
                          product: product,
                          imageOnlyClickable: false,
                          isFavorite: context.read<FavoriteCubit>().isFavorite(
                            product.id,
                          ),
                          onFavorite: () {
                            final wasFavorite = context
                                .read<FavoriteCubit>()
                                .isFavorite(product.id);
                            context.read<FavoriteCubit>().toggleFavorite(
                              product.id,
                            );
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

            return Center(child: Text("Unknown State: ${state.runtimeType}"));
          },
        ),
      ),
    );
  }
}
