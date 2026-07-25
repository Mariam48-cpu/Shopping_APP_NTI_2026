import 'package:flutter/material.dart';
import 'package:shopping_app/core/routes/app_routes.dart';
import 'package:shopping_app/feature/auth/presentation/screens/hello.dart';
import 'package:shopping_app/feature/auth/presentation/screens/login.dart';
import 'package:shopping_app/feature/auth/presentation/screens/sign_up_screen.dart';

class AppRouters {
  static Route? createRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.logInScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case Routes.helloScreen:
        return MaterialPageRoute(builder: (_) => const HelloScreen());
      default:
        return null;
    }
  }
}
