import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../feature/auth/presentation/view/screens/hello_screen.dart';
import '../../feature/auth/presentation/view/screens/login_screen.dart';
import '../../feature/auth/presentation/view/screens/sign_up_screen.dart';
import '../../feature/auth/presentation/view_model/register/register_cubit.dart';
import '../../feature/category/view/screens/product_details_screen.dart';
import '../../feature/category/view/screens/products_by_category_screen.dart';
import '../../feature/home/presentation/view/screens/home_screen.dart';
import '../../feature/onboarding/onboarding_screen.dart';
import '../di/service_locator.dart';
import 'app_routes.dart';

class AppRouters {
  static Route? createRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.logInScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) =>serviceLocator<RegisterCubit>(),
              child: SignUpScreen(),
            ));
      case Routes.helloScreen:
        return MaterialPageRoute(builder: (_) => const HelloScreen());
      case Routes.productOfCategoryScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ProductsByCategoryScreen(
            slug: args['slug'],
            categoryName: args['categoryName'] ?? 'Electronics',
          ),
        );
      case Routes.productDetailsScreen:
        final productId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(productId: productId),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case Routes.firstOnBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );

      default:
        return null;
    }
  }
}