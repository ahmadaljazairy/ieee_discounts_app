import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class HeroBox extends StatelessWidget {
  const HeroBox({super.key, required this.width, required this.height, required this.slogan});
  final double width;
  final double height;
  final String slogan;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Hero box displaying slogan: $slogan',
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: AppColors.gradientHero,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(70),
              offset: const Offset(0, 2),
              blurRadius: 6,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AutoSizeText(
              slogan,
              textAlign: TextAlign.center,
              maxLines: 2,
              minFontSize: 18,
              maxFontSize: 24,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.kBasicSoftPearl,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
