import 'package:flutter/material.dart';
import 'package:shopping_app/feature/cart/presentation/view/widgets/cart_summary_row_widget.dart';

class CartSummaryWidget extends StatelessWidget {
  const CartSummaryWidget({super.key, required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    final double shipping = 0;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CartSummaryRowWidget(
              title: "Shipping fee",
              value: shipping,
              isBold: false,
            ),
            const SizedBox(height: 10),
            CartSummaryRowWidget(
              title: "Subtotal",
              value: total,
              isBold: false,
            ),
            const Divider(height: 30),
            CartSummaryRowWidget(
              title: "Total",
              value: total + shipping,
              isBold: true,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Checkout"),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
