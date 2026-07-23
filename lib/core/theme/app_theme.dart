import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',



    scaffoldBackgroundColor: AppColors.scaffoldBg,
    cardColor: AppColors.white,
    hintColor: AppColors.grayText,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.scaffoldBg,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.charcoal),
      titleTextStyle: TextStyle(
        color: AppColors.charcoal,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
    ),
    textTheme: const TextTheme(

      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.charcoal,
      ),


      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.charcoal,
      ),


      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.charcoal,
      ),


      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.charcoal,
      ),


      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.grayText,
      ),


      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),


      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.grayText,
      ),
    ),


    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.scaffoldBg,
      selectedItemColor: AppColors.primaryOrange,

      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );
}
