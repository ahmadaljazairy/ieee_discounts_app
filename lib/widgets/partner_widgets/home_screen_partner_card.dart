import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../utilities/constants.dart';
import 'category_label.dart';
import 'partner_card.dart';

class HomeScreenPartnerCard extends PartnerCard {
  const HomeScreenPartnerCard({
    required super.partner,
    required super.width,
    required super.height,
    super.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: AppColors.getRandomGradient(),
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: EdgeInsets.symmetric(vertical: height * 0.075, horizontal: width * 0.05),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildImage(imageSize: height * 0.525),
              SizedBox(height: height * 0.025),
              _buildTextSection(),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: CategoryLabel(categoryName: partner.categoryName),
          ),
        ]),
      ),
    );
  }

  Widget _buildTextSection() {
    return SizedBox(
      height: height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: FittedBox(
              fit: BoxFit.contain,
              child: AutoSizeText(
                partner.name,
                overflow: TextOverflow.ellipsis,
                minFontSize: 14,
                style: const TextStyle(
                  fontSize: 24,
                  color: AppColors.kBasicSoftPearl,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                'UP TO ${partner.largestDiscountValue?.toInt() ?? 0}% OFF',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.kBasicSoftPearl,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
