import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/partner.dart';
import '../../utilities/constants.dart';

class DiscountWidget extends StatelessWidget {
  const DiscountWidget({super.key, required this.discount, required this.width, required this.height});

  final Discount discount;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: height * 0.075, horizontal: width * 0.05),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.kBasicSoftPearl,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            offset: const Offset(0, 2),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: SvgPicture.asset('lib/assets/images/icons/discount.svg')),
          SizedBox(width: width * 0.05),
          Expanded(flex: 9, child: _buildTextSection())
        ],
      ),
    );
  }

  Widget _buildTextSection() {
    print(discount.name);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 7,
          child: FittedBox(
            fit: BoxFit.contain,
            child: AutoSizeText(
              discount.name,
              overflow: TextOverflow.ellipsis,
              minFontSize: 8,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.kPrimaryCrimsonDepth,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Flexible(
          flex: 3,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              discount.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.kPrimaryCrimsonDepth,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
