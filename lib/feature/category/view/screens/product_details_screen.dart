import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/common/widgets/custom_button.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/feature/category/view_model/product_cubit.dart';
import 'package:shopping_app/feature/category/view_model/product_state.dart';
import 'package:shopping_app/feature/category/view_model/widgets/product_details_card.dart';

import '../../../../core/di/service_locator.dart';
class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
        serviceLocator<ProductCubit>()
          ..intent(GetProductDetailsIntent(id: widget.productId)),
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
                return const Center(child: CircularProgressIndicator());
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
                    crossAxisAlignment: .start,
                    children: [
                      ProductDetailsCard(product: productDetails),
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
          bottomNavigationBar: SizedBox(
            width: double.infinity,
            height: 50,
            child:Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: CustomButton(txt: "Add to cart", width: 343, height: 48, color: AppColors.buttonBlack, fun: (){}, borderColor: AppColors.buttonBlack, txtColor: AppColors.white),
            ),
          ),)
    );
  }
}