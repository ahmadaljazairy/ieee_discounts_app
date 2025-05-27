import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ieee_discounts_application/widgets/partner_widgets/home_screen_partner_card.dart';
import 'package:ieee_discounts_application/widgets/partner_widgets/partner_details_screen_partner_card.dart';
import 'package:ieee_discounts_application/widgets/partner_widgets/partners_screen_partner_card.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../models/partner.dart';
import '../../services/api_service/api_constants.dart';

enum CardType {
  homeScreen,
  partnerDetailsScreen,
  partnersScreen,
}

/// A reusable card widget that displays partner information in different layouts.
abstract class PartnerCard extends StatelessWidget {
  final Partner partner;
  final double width;
  final double height;
  final VoidCallback? onTap;
  final Gradient? gradient;

  const PartnerCard({
    required this.partner,
    required this.width,
    required this.height,
    this.onTap,
    super.key,
    this.gradient,
  });

  /// Creates a [PartnerCard] based on the specified [cardType].
  factory PartnerCard.create({
    required Partner partner,
    required CardType cardType,
    required double width,
    required double height,
    VoidCallback? onTap,
    Gradient? gradient,
  }) {
    switch (cardType) {
      case CardType.homeScreen:
        return HomeScreenPartnerCard(
          partner: partner,
          width: width,
          height: height,
          onTap: onTap ?? () {},
        );
      case CardType.partnerDetailsScreen:
        return PartnerDetailsPartnerCard(
          partner: partner,
          width: width,
          height: height,
          onTap: onTap ?? () {},
        );
      case CardType.partnersScreen:
        return PartnersScreenPartnerCard(
          partner: partner,
          width: width,
          height: height,
          onTap: onTap ?? () {},
          gradient: gradient,
        );
    }
  }

  Widget buildImage({required double imageSize}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: CachedNetworkImage(
        imageUrl: '${ApiConstants.baseUrl}/${partner.imagePath}',
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildLoadingIndicator(imageSize: imageSize),
        errorWidget: (context, url, error) {
          return _buildErrorImage(imageSize: imageSize);
        },
      ),
    );
  }

  Widget _buildLoadingIndicator({required double imageSize}) {
    return SizedBox(
      width: imageSize,
      height: imageSize,
      child: Center(
        child: LoadingIndicator(
          indicatorType: Indicator.ballScale,
          colors: const [Colors.white],
        ),
      ),
    );
  }

  Widget _buildErrorImage({required double imageSize}) {
    return SizedBox(
      width: imageSize,
      height: imageSize,
      child: Center(
        child: Icon(Icons.broken_image, color: Colors.grey.shade400),
      ),
    );
  }
}
