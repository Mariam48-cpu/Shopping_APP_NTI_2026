import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_cubit.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import '../../view_model/products_search_cubit.dart';
import '../../view_model/products_search_state.dart';
import '../widgets/custom_products_grid.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductSearchCubit>(
          create: (_) => serviceLocator<ProductSearchCubit>(),
        ),
        BlocProvider<FavoriteCubit>(
          create: (_) => serviceLocator<FavoriteCubit>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Builder(
            builder: (searchContext) {
              return CustomTextFormField(
                controller: _searchController,
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    AppAssets.magnifierIcon,
                    width: 25,
                    height: 25,
                  ),
                ),
                hintText: "Search for your products...",
                keyboardType: TextInputType.text,
                onChanged: (query) {
                  final trimmedQuery = query?.trim() ?? '';

                  if (trimmedQuery.isNotEmpty) {
                    searchContext.read<ProductSearchCubit>().intent(
                      SearchProductsIntent(search: trimmedQuery),
                    );
                  } else {
                    setState(() {});
                  }
                },
              );
            },
          ),
        ),
        body: BlocBuilder<ProductSearchCubit, ProductsSearchState>(
          builder: (context, state) {
            switch (state) {
              case SearchInitialState():
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.searchInitial,
                        width: 150,
                        height: 150,
                      ),
                      const Text("Search for your products..."),
                    ],
                  ),
                );

              case SearchLoadingState():
                return const Center(child: CircularProgressIndicator());

              case SearchSuccessState():
                return buildProductsGrid(state.data);

              case SearchErrorState():
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.searchInitial,
                        width: 150,
                        height: 150,
                      ),
                      Text(state.messageError ?? "Something went wrong"),
                    ],
                  ),
                );

              case SearchEmptyState():
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
