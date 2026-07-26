import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'feature/app_section/view/bottom_navigation_Screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: AppTheme.lightTheme, home: BottomNavigationScreen());
  }
}
