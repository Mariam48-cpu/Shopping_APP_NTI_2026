import 'package:flutter/material.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/feature/auth/presentation/view/screens/sign_up_screen.dart';
import 'package:shopping_app/feature/category/view/screens/product_details_screen.dart';
import 'package:shopping_app/feature/home/presentation/view/screens/home_screen.dart';
import 'core/di/service_locator.dart';
import 'core/routes/app_routers.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'feature/auth/presentation/view/screens/login_screen.dart';
void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home:SignUpScreen(),
      initialRoute: Routes.signUpScreen,
      onGenerateRoute: AppRouters.createRoute,
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      theme: AppTheme.lightTheme,
      );
  }
}
