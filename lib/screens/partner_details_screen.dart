import 'package:flutter/material.dart';
import 'package:ieee_discounts_application/widgets/partner_widgets/partner_card.dart';

import '../models/partner.dart';
import '../utilities/constants.dart';
import '../widgets/partner_widgets/discount_widget.dart';

class PartnerDetailsScreen extends StatelessWidget {
  const PartnerDetailsScreen({super.key, required this.partner});

  final Partner partner;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final discounts = partner.discounts ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(partner.name),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 16),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PartnerCard.create(
              cardType: CardType.partnerDetailsScreen,
              width: size.width * 0.95,
              height: size.height * 0.3,
              partner: partner,
            ),
          ),
          if (discounts.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'No discounts available for this partner.',
                  style: TextStyle(fontSize: 24, color: AppColors.kPrimaryCrimsonDepth, fontWeight: FontWeight.w500),
                ),
              ),
            )
          else
            ...discounts.map((discount) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: DiscountWidget(
                  discount: discount,
                  width: size.width,
                  height: size.height * 0.12,
                ),
              );
            }),
        ],
      ),
    );
  }
}
