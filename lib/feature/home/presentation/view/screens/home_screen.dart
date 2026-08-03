import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/utils/app_toast.dart';
import 'package:shopping_app/feature/category/view/widgets/product_grid_skeleton.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_state.dart';
import 'package:shopping_app/feature/home/presentation/view/widget/category_list_skeleton.dart';
import 'package:shopping_app/feature/home/widgets/categories_list_widget.dart';
import 'package:toastification/toastification.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../core/widgets/product_item_card.dart';
import '../../view_model/category_cubit/category_cubit.dart';
import '../../view_model/category_cubit/category_state.dart';
import '../../view_model/product_cubit/product_cubit.dart';
import '../../view_model/product_cubit/product_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<CategoryCubit>()..getCategories(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<ProductCubit>()..getProducts(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hi!,", style: Theme.of(context).textTheme.bodyLarge),
                Text(
                  "Let's start your day",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),

                /// Categories
                BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoading) {
                      return const CategoryListSkeleton();
                    }

                    if (state is CategoryError) {
                      return Center(child: Text(state.message));
                    }

                    if (state is CategorySuccess) {
                      return CategoriesListWidget(
                        categories: state.categories.list,
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),

                const SizedBox(height: 20),

                /// Products
                Expanded(
                  child: BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoading) {
                        return const ProductGridSkeleton();
                      }

                      if (state is ProductError) {
                        return Center(child: Text(state.messageError));
                      }

                      if (state is ProductSuccess) {
                        return GridView.builder(
                          itemCount: state.products.products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 320,
                              ),
                          itemBuilder: (context, index) {
                            final product = state.products.products[index];

                            return BlocBuilder<FavoriteCubit, FavoriteStates>(
                              builder: (context, favoriteState) {
                                return ProductItemCard(
                                  product: product,
                                  isFavorite: context
                                      .read<FavoriteCubit>()
                                      .isFavorite(product.id),
                                  onFavorite: () {
                                    final wasFavorite = context
                                        .read<FavoriteCubit>()
                                        .isFavorite(product.id);
                                    context
                                        .read<FavoriteCubit>()
                                        .toggleFavorite(product.id);
                                    AppToast.showToast(
                                      context: context,
                                      title: "Success",
                                      description: wasFavorite
                                          ? "Removed from favourites"
                                          : "Added to favourites",
                                      type: ToastificationType.success,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}