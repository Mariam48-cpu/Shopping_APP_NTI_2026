import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/feature/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_cubit.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>(
          create: (_) => serviceLocator<CartCubit>()..getCart(),
        ),
        BlocProvider<FavoriteCubit>(
          create: (_) => serviceLocator<FavoriteCubit>()..getFavorite(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping App',
        theme: AppTheme.lightTheme,
        initialRoute: Routes.firstOnBoardingScreen,
        onGenerateRoute: AppRouters.createRoute,
        // home: const CartScreen(),
      ),
    );
  }
}
