import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_state.dart';
import 'package:shopping_app/feature/home/presentation/view/widgets/categories_list_widget.dart';
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
                      return const Center(child: CircularProgressIndicator());
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
                        return const Center(child: CircularProgressIndicator());
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
                                childAspectRatio: 0.62,
                                mainAxisSpacing: 10,
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
                                    context
                                        .read<FavoriteCubit>()
                                        .toggleFavorite(product.id);
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
