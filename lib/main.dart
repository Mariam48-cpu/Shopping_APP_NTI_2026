import 'package:flutter/material.dart';
import 'package:shopping_app/feature/cart/presentation/view/screens/cart_screen.dart';
import 'package:shopping_app/feature/favorite/presentation/view/screens/favorite_screen.dart';
import 'core/di/service_locator.dart';
import 'core/routes/app_routers.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      // initialRoute: Routes.firstOnBoardingScreen,
      // onGenerateRoute: AppRouters.createRoute,
      home: const CartScreen(),
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      theme: AppTheme.lightTheme,
    );
  }
}
