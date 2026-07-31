import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/routes/app_routes.dart';
import 'package:shopping_app/feature/auth/presentation/view_model/register_cubit.dart';
import 'package:shopping_app/feature/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:shopping_app/feature/category/view/screens/product_search_screen.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_cubit.dart';
import '../../feature/auth/presentation/view/screens/hello_screen.dart';
import '../../feature/auth/presentation/view/screens/login_screen.dart';
import '../../feature/auth/presentation/view/screens/sign_up_screen.dart';
import '../../feature/category/view/screens/products_by_category_screen.dart';
import '../../feature/home/presentation/view/screens/home_screen.dart';
import '../../feature/onboarding/onboarding_screen.dart';
import 'package:shopping_app/feature/app_section/view/bottom_navigation_screen.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/feature/category/view/screens/product_details_screen.dart';

class AppRouters {
  static Route? createRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.logInScreen:
      case Routes.homeScreen: 
      case Routes.bottomNavigationScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: serviceLocator<FavoriteCubit>()),
              BlocProvider.value(value: serviceLocator<CartCubit>()),
            ],
            child: settings.name == Routes.logInScreen 
                ? const LoginScreen() 
                : const BottomNavigationScreen(),
          ),
        );

      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => serviceLocator<RegisterCubit>(),
            child: SignUpScreen(),
          ),
        );

      case Routes.helloScreen:
        return MaterialPageRoute(builder: (_) => const HelloScreen());

      case Routes.productOfCategoryScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: serviceLocator<FavoriteCubit>()),
              BlocProvider.value(value: serviceLocator<CartCubit>()),
            ],
            child: ProductsByCategoryScreen(
              slug: args['slug'],
              categoryName: args['categoryName'] ?? 'Electronics',
            ),
          ),
        );

      case Routes.productDetailsScreen:
        final product = settings.arguments as ProductItemEntity;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: serviceLocator<FavoriteCubit>()),
              BlocProvider.value(value: serviceLocator<CartCubit>()),
            ],
            child: ProductDetailsScreen(product: product),
          ),
        );

      case Routes.firstOnBoardingScreen:
      case Routes.secondOnBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case Routes.productSearchScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: serviceLocator<FavoriteCubit>()),
              BlocProvider.value(value: serviceLocator<CartCubit>()),
            ],
            child: ProductSearchScreen(),
          ),
        );

      default:
        return null;
    }
  }
}