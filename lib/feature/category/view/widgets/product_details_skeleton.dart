import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailsSkeleton extends StatelessWidget {
  const ProductDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(width: 220, height: 24, color: Colors.white),

            const SizedBox(height: 12),

            Container(width: 100, height: 18, color: Colors.white),

            const SizedBox(height: 20),

            Container(width: double.infinity, height: 14, color: Colors.white),

            const SizedBox(height: 8),

            Container(width: double.infinity, height: 14, color: Colors.white),

            const SizedBox(height: 8),

            Container(width: 250, height: 14, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
