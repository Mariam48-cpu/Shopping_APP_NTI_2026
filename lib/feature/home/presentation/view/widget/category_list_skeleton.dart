import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryListSkeleton extends StatelessWidget {
  const CategoryListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (_, __) {
            return Container(
              width: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            );
          },
        ),
      ),
    );
  }
}
