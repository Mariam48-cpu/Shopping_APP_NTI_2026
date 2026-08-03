import 'package:flutter/material.dart';

class CartSummaryRowWidget extends StatelessWidget {
  const CartSummaryRowWidget({
    super.key,
    required this.title,
    required this.value,
    this.isBold = false,
  });
  final String title;
  final double value;
  final bool isBold;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          "\$${value.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}



  // Widget RowWidget({
  //   required String title,
  //   required double value,
  //   bool isBold = false,
  // }) {

  // }
