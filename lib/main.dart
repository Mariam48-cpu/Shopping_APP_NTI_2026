import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/onboarding/onboarding_screen.dart';

void main() async {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: OnboardingScreen());
  }
}
