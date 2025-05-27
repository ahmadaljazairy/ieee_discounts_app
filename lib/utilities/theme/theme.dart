import 'package:flutter/material.dart';

import '../constants.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'MontserratArabic',
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.kBasicSoftPearl,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.kPrimaryCrimsonDepth,
      contentTextStyle: TextStyle(
        color: AppColors.kBasicSoftPearl,
        fontSize: 16,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 6,
    ),
  );
}
