import 'package:flutter/material.dart';
import 'package:shopping_app/core/routes/routes.dart';
import 'package:shopping_app/feature/auth/presentation/screens/login.dart';
import 'package:shopping_app/feature/auth/presentation/screens/register.dart';

class AppRouters {
  static Route? createRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteLayers.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteLayers.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      default:
        return null;
    }
  }
}
