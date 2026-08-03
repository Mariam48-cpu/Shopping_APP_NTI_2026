import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AccountSkeleton extends StatelessWidget {
  const AccountSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Account",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.notifications_none),
              ],
            ),

            const SizedBox(height: 16),

            const CircleAvatar(radius: 64, child: Icon(Icons.person, size: 80)),

            const SizedBox(height: 12),

            Container(width: 180, height: 20, color: Colors.white),

            const SizedBox(height: 8),

            Container(width: 220, height: 16, color: Colors.white),

            const SizedBox(height: 32),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        const CircleAvatar(radius: 12),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(height: 14, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
