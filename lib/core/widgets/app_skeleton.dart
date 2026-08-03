import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppSkeleton extends StatelessWidget {
  const AppSkeleton({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.white,
        duration: const Duration(seconds: 2),
      ),
      child: child,
    );
  }
}
