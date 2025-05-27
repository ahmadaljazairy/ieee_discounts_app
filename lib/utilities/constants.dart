import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const kPrimaryCrimsonDepth = Color(0xFF2C1818);
  static const kPrimaryGoldenSunrise = Color(0xFFFAA41A);
  static const kPrimaryDesertSand = Color(0xFFD8BD82);
  static const kSecondaryOceanBreeze = Color(0xFF508EC2);
  static const kSecondaryMintLagoon = Color(0xFF97D0C9);
  static const kBasicSoftPearl = Color(0xFFF6F6F6);
  static const kBasicMidnightBlack = Color(0xFF000000);

  static const LinearGradient gradientPrimary = LinearGradient(
    colors: [Color(0xFF6D2E2E), Color(0xFF2C1818)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient gradientAccent = LinearGradient(
    colors: [Color(0xFFFFD883), Color(0xFFFAA41A)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient gradientHero = LinearGradient(
    colors: [Color(0xFFFAA41A), Color(0xFFFFC769)],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    stops: [0.0017, 1.0],
    transform: GradientRotation(268.09 * (3.141592653589793 / 180)),
  );

  static const LinearGradient gradientYellow = LinearGradient(
    colors: [Color(0xFFFACC15), Color(0xFFF97316)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient gradientPurple = LinearGradient(
    colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient gradientGreen = LinearGradient(
    colors: [Color(0xFF4ADE80), Color(0xFF3B82F6)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient gradientBlue = LinearGradient(
    colors: [Color(0xFF60A5FA), Color(0xFF6366F0)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient gradientRed = LinearGradient(
    colors: [Color(0xFFEF4444), Color(0xFFEC4899)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient revGradientYellow = LinearGradient(
    colors: [Color(0xFFFACC15), Color(0xFFF97316)],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static const LinearGradient revGradientPurple = LinearGradient(
    colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static const LinearGradient revGradientGreen = LinearGradient(
    colors: [Color(0xFF4ADE80), Color(0xFF3B82F6)],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static const LinearGradient revGradientBlue = LinearGradient(
    colors: [Color(0xFF60A5FA), Color(0xFF6366F0)],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static const LinearGradient revGradientRed = LinearGradient(
    colors: [Color(0xFFEF4444), Color(0xFFEC4899)],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static const List<LinearGradient> gradients = [
    gradientPrimary,
    gradientAccent,
    gradientYellow,
    gradientPurple,
    gradientGreen,
    gradientBlue,
    gradientRed,
    revGradientYellow,
    revGradientPurple,
    revGradientGreen,
    revGradientBlue,
    revGradientRed,
  ];
  static final _random = Random(27);

  static LinearGradient getRandomGradient() {
    return gradients[1 + _random.nextInt(gradients.length - 1)];
  }
}
