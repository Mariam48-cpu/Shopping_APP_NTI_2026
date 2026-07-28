import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/feature/cart/presentation/view/widgets/cart_item_widget.dart';
import 'package:shopping_app/feature/cart/presentation/view/widgets/cart_summary_widget.dart';
import 'package:shopping_app/feature/cart/presentation/view/widgets/empty_cart_widget.dart';
import 'package:shopping_app/feature/cart/presentation/view_model/cubit/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<CartCubit>()..getCart(),
      child: Scaffold(
        appBar: AppBar(title: const Text("My Cart"), centerTitle: true),
        body: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message ?? '')));
            }
          },
          builder: (context, state) {
            switch (state) {
              case CartLoading():
                return const Center(child: CircularProgressIndicator());

              case CartError():
                return Center(
                  child: Text(state.message ?? 'Something went wrong'),
                );

              case CartSuccess():
                final cart = state.cart;

                if (cart!.list.isEmpty) {
                  return const EmptyCartWidget();
                }

                final total = cart.list.fold<double>(
                  0,
                  (sum, item) => sum + item.price,
                );

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.list.length,
                        itemBuilder: (context, index) {
                          return CartItemWidget(
                            item: cart.list[index],
                            onDelete: () {},
                          );
                        },
                      ),
                    ),

                    CartSummaryWidget(total: total),
                  ],
                );

              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
