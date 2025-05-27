import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../utilities/constants.dart';
import 'partner_card.dart';

class PartnersScreenPartnerCard extends PartnerCard {
  const PartnersScreenPartnerCard(
      {required super.partner, required super.width, required super.height, super.onTap, super.key, super.gradient});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: gradient ?? AppColors.getRandomGradient(),
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            buildImage(imageSize: height * 0.68),
            const SizedBox(width: 16.0),
            _buildTextSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextSection() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            partner.name,
            minFontSize: 8,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 24,
              color: AppColors.kBasicSoftPearl,
              fontWeight: FontWeight.w700,
            ),
          ),
          AutoSizeText(
            'UP TO ${partner.largestDiscountValue!.toInt()}% OFF',
            minFontSize: 4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.kBasicSoftPearl,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
