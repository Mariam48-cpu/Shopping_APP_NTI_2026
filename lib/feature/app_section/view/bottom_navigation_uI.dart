import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping_app/feature/app_section/view_model/bottom_navigation_state.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../view_model/bottom_navigation_cubit.dart';

class BottomNavigationUi extends StatefulWidget {
  const BottomNavigationUi({super.key});

  @override
  State<BottomNavigationUi> createState() => _BottomNavigationUiState();
}

class _BottomNavigationUiState extends State<BottomNavigationUi> {
  final List<Widget> _tabs = const [
    Center(child: Text('Home ')),
    Center(child: Text('Cart ')),
    Center(child: Text('Favorite')),
    Center(child: Text('Account')),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationCubit()..intent(ChangeTabIntent(1)),
      child: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
        builder: (BuildContext context, BottomNavigationState state) {
          return Scaffold(
            body: IndexedStack(
              index: context.read<BottomNavigationCubit>().currentIndex,
              children: _tabs,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: context.read<BottomNavigationCubit>().currentIndex,
              onTap: (index) {
                context.read<BottomNavigationCubit>().intent(
                  ChangeTabIntent(index),
                );
              },

              backgroundColor: Theme.of(
                context,
              ).bottomNavigationBarTheme.backgroundColor,
              selectedItemColor: Theme.of(
                context,
              ).bottomNavigationBarTheme.selectedItemColor,
              unselectedItemColor: Theme.of(context).hintColor,
              elevation: Theme.of(context).bottomNavigationBarTheme.elevation,
              selectedLabelStyle: Theme.of(context).textTheme.labelSmall
                  ?.copyWith(
                    color: Theme.of(
                      context,
                    ).bottomNavigationBarTheme.selectedItemColor,
                    fontWeight: FontWeight.w600,
                  ),
              unselectedLabelStyle: Theme.of(context).textTheme.labelSmall,
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icon/home.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(
                            context,
                          ).bottomNavigationBarTheme.unselectedItemColor ??
                          AppColors.grayText,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icon/cart.svg",
                    colorFilter: ColorFilter.mode(
                      Theme.of(
                            context,
                          ).bottomNavigationBarTheme.unselectedItemColor ??
                          AppColors.grayText,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icon/favourite.svg",
                    colorFilter: ColorFilter.mode(
                      Theme.of(
                            context,
                          ).bottomNavigationBarTheme.unselectedItemColor ??
                          AppColors.grayText,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: "Favorite",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icon/profile.svg",
                    colorFilter: ColorFilter.mode(
                      Theme.of(
                            context,
                          ).bottomNavigationBarTheme.unselectedItemColor ??
                          AppColors.grayText,
                      BlendMode.srcIn,
                    ),
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
