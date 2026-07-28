import 'package:flutter/material.dart';

class CartSummaryWidget extends StatelessWidget {
  const CartSummaryWidget({
    super.key,
    required this.total,
  });

  final double total;

  @override
  Widget build(BuildContext context) {
    const double shipping = 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRow(
              title: "Shipping",
              value: shipping,
            ),
            const SizedBox(height: 10),
            _buildRow(
              title: "Subtotal",
              value: total,
            ),
            const Divider(height: 30),
            _buildRow(
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

  Widget _buildRow({
    required String title,
    required double value,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight:
                isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          "\$${value.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 16,
            fontWeight:
                isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}