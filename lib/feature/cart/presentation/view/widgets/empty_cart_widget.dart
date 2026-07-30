import 'package:flutter/material.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/image/shopping_cart.png",
            width: 180,
            height: 180,
          ),
          const SizedBox(height: 20),
          const Text("Your cart is empty", style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
