import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/theme/app_colors.dart';

class CustomSvgIcon extends StatelessWidget {
  const CustomSvgIcon({
    super.key,
    required this.assetPath,
    this.currentIndex,
    required this.index,
  });

  final String assetPath;
  final int? index;
  final int? currentIndex;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == currentIndex;
    final selectedColor =
        Theme.of(context).bottomNavigationBarTheme.selectedItemColor ??
        AppColors.primaryOrange;
    final unselectedColor =
        Theme.of(context).bottomNavigationBarTheme.unselectedItemColor ??
        AppColors.grayText;
    return SvgPicture.asset(
      assetPath,
      colorFilter: ColorFilter.mode(
        isSelected ? selectedColor : unselectedColor,
        BlendMode.srcIn,
      ),
    );
  }
}
