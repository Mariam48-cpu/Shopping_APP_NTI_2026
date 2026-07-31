import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/feature/app_section/view/widget/svg_icon.dart';
import 'package:shopping_app/feature/app_section/view_model/bottom_navigation_cubit.dart';
import 'package:shopping_app/feature/app_section/view_model/bottom_navigation_state.dart';
import 'package:shopping_app/feature/cart/presentation/view/screens/cart_screen.dart';
import 'package:shopping_app/feature/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/view/screens/favorite_screen.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_cubit.dart';
import 'package:shopping_app/feature/home/presentation/view/screens/home_screen.dart';
import 'package:shopping_app/feature/account/presentation/view/screens/account_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final List<Widget> _tabs = const [
    HomeScreen(),
    CartScreen(),
    FavouriteScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BottomNavigationCubit()..intent(ChangeTabIntent(0)),
        ),
        BlocProvider(
          create: (_) => serviceLocator<FavoriteCubit>()..getFavorite(),
        ),
        BlocProvider(create: (_) => serviceLocator<CartCubit>()..getCart()),
      ],
      child: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
        builder: (context, state) {
          final currentIndex = context
              .watch<BottomNavigationCubit>()
              .currentIndex;

          return Scaffold(
            body: _tabs[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                context.read<BottomNavigationCubit>().intent(
                  ChangeTabIntent(index),
                );
              },
              showSelectedLabels: true,
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(
                  icon: CustomSvgIcon(
                    assetPath: 'assets/icon/home.svg',
                    index: 0,
                    currentIndex: currentIndex,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: CustomSvgIcon(
                    assetPath: "assets/icon/cart.svg",
                    index: 1,
                    currentIndex: currentIndex,
                  ),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                  icon: CustomSvgIcon(
                    assetPath: "assets/icon/favourite.svg",
                    index: 2,
                    currentIndex: currentIndex,
                  ),
                  label: "Favorite",
                ),
                BottomNavigationBarItem(
                  icon: CustomSvgIcon(
                    assetPath: "assets/icon/profile.svg",
                    index: 3,
                    currentIndex: currentIndex,
                  ),
                  label: "Account",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
