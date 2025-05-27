import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../utilities/constants.dart';

class CategoryLabel extends StatelessWidget {
  const CategoryLabel({required this.categoryName, super.key});
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: AppColors.kBasicSoftPearl,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.discount,
            color: AppColors.kPrimaryGoldenSunrise,
            size: 10,
          ),
          const SizedBox(width: 4.0),
          // FittedBox will handle the scaling
          FittedBox(
            child: AutoSizeText(
              categoryName,
              minFontSize: 6.0,
              maxFontSize: 8.0,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.kPrimaryCrimsonDepth,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
