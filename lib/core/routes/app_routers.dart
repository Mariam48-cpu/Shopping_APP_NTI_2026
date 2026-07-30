import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/routes/app_routes.dart';
import 'package:shopping_app/feature/category/view/screens/product_search_screen.dart';
import '../../feature/auth/presentation/view/screens/hello_screen.dart';
import '../../feature/auth/presentation/view/screens/login_screen.dart';
import '../../feature/auth/presentation/view/screens/sign_up_screen.dart';
import '../../feature/auth/presentation/view_model/register_cubit.dart';
import '../../feature/category/view/screens/products_by_category_screen.dart';
import '../../feature/home/presentation/view/screens/home_screen.dart';
import '../../feature/onboarding/onboarding_screen.dart';
import '../../feature/app_section/view/bottom_navigation_Screen.dart';

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
          builder: (_) =>
              ProductsByCategoryScreen(
                slug: args['slug'],
                categoryName: args['categoryName'] ?? 'Electronics',
              ),
        );
    // case Routes.productDetailsScreen:
    // return MaterialPageRoute(
    // builder: (_) => ProductDetailsScreen(),
    // );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const BottomNavigationScreen(),
        );
      case Routes.firstOnBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case Routes.productSearchScreen:
        return MaterialPageRoute(
          builder: (_) => ProductSearchScreen(),
        );


      default:
        return null;
    }
  }
}