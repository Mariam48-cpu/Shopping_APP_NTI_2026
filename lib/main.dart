import 'package:flutter/material.dart';
import 'package:shopping_app/core/routes/app_routers.dart';
import 'core/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.firstOnBoardingScreen,
      onGenerateRoute: AppRouters.createRoute,
    );
  }
}