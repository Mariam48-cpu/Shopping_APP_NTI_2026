import 'package:flutter/material.dart';

abstract class AppColors {
  // ================= Primary =================
  static const Color primaryOrange = Color(0xFFFF9900);
  static const Color orangeLight = Color(0xFFFFB700);

  // ================= Background =================
  static const Color scaffoldBg = Color(0xFFEBEBEB);
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF7F8FA);
  static const Color lightGray = Color(0xFFECEEF2);

  // ================= Text =================
  static const Color black = Color(0xFF212121);
  static const Color charcoal = Color(0xFF1A1A2E);
  static const Color grayText = Color(0xFF7A7D8C);

  // ================= Status =================
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color errorRed = Color(0xFFEF4444);
  static const Color errorBg = Color(0xFFFFF5F5);

  // ================= Border =================
  static const Color border = Color(0xFFE5E7EB);

  // ================= Shadows =================
  static const Color shadow = Color(0x14000000);

  // ================= Gradient =================
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryOrange, orangeLight],
  );
}
