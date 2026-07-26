import 'package:flutter/material.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/feature/home/presentation/view/screens/home_screen.dart';
import 'core/theme/app_theme.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      theme: AppTheme.lightTheme,
    );
  }
}
