import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primaryOrange = Color(0xFFFF9900);
  static const Color orangeLight = Color(0xFFFFB700);
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF7F8FA);
  static const Color lightGray = Color(0xFFECEEF2);
  static const Color charcoal = Color(0xFF1A1A2E);

  static const Color grayText = Color(0xFF7A7D8C);

  static const Color errorRed = Color(0xFFEF4444);
  static const Color errorBg = Color(0xFFFFF5F5);
  static const Color scaffoldBg = Color(0xFFEBEBEB);
  static const Color buttonBlack = Color(0xff212121);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryOrange, orangeLight],
  );
}
