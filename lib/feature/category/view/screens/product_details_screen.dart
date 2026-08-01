import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/common/widgets/custom_button.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/utils/app_toast.dart';
import 'package:shopping_app/feature/category/view/widgets/product_details_skeleton.dart';
import 'package:shopping_app/feature/category/view_model/product_cubit.dart';
import 'package:shopping_app/feature/category/view_model/product_state.dart';
import 'package:shopping_app/feature/category/view_model/widgets/product_details_card.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_state.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/model/item/product_item_entity.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductItemEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCubit>(
          create: (_) =>
              serviceLocator<ProductCubit>()
                ..intent(GetProductDetailsIntent(id: widget.product.id)),
        ),
        BlocProvider<CartCubit>.value(value: serviceLocator<CartCubit>()),
        BlocProvider<FavoriteCubit>.value(
          value: serviceLocator<FavoriteCubit>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset(
              "assets/icon/vector.svg",
              width: 20.78,
              height: 20.23,
              fit: BoxFit.scaleDown,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoadingState) {
              return const ProductDetailsSkeleton();
            } else if (state is ProductErrorState) {
              return Center(
                child: Text(
                  state.messageError,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state is ProductSuccessState) {
              final productDetails = state.products is List
                  ? (state.products as List).first
                  : state.products;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<FavoriteCubit, FavoriteStates>(
                      builder: (context, favoriteState) {
                        return ProductDetailsCard(product: productDetails);
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      productDetails.description.isNotEmpty
                          ? productDetails.description
                          : "No Description",
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.grayText,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomButton(
                txt: "Add to cart",
                width: 343,
                height: 48,
                color: AppColors.black,
                borderColor: AppColors.black,
                txtColor: AppColors.white,

                fun: () async {
                  print("Widget Product Id = ${widget.product.id}");

                  final result = await context.read<CartCubit>().addToCart(
                    productId: widget.product.id,
                  );

                  print(result);

                  if (!context.mounted) return;

                  switch (result) {
                    case Success<String>():
                      AppToast.showToast(
                        context: context,
                        title: "Success",
                        description: "Product added to cart",
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
