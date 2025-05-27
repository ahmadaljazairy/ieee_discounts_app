import 'dart:math' as math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ieee_discounts_application/utilities/extensions/string_arabic_extension.dart';
import 'package:ieee_discounts_application/widgets/partner_widgets/partner_card.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utilities/constants.dart';

class PartnerDetailsPartnerCard extends PartnerCard {
  const PartnerDetailsPartnerCard(
      {required super.partner, required super.width, required super.height, super.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: AppColors.gradientHero,
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: EdgeInsets.symmetric(vertical: height * 0.075, horizontal: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildImage(imageSize: math.min(width, height) * 0.25),
              SizedBox(width: width * 0.05),
              _buildTitleSection(),
            ],
          ),
          SizedBox(height: height * 0.05),
          Align(
            alignment: ((partner.description != null) ? partner.description!.isArabic : false)
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text(
              partner.description ?? partner.name,
              textDirection: ((partner.description != null) ? partner.description!.isArabic : false)
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.kBasicSoftPearl,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: height * 0.07),
          Align(
            alignment: Alignment.center,
            child: _buildSocialInfoBox(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return SizedBox(
      height: math.min(width, height) * 0.25,
      width: width * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 68,
            child: FittedBox(
              fit: BoxFit.contain,
              child: AutoSizeText(
                partner.name,
                overflow: TextOverflow.ellipsis,
                minFontSize: 14,
                style: const TextStyle(
                  fontSize: 38,
                  color: AppColors.kBasicSoftPearl,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 33,
            child: FittedBox(
              fit: BoxFit.contain,
              child: AutoSizeText(
                partner.categoryName,
                minFontSize: 12,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 26,
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

  Widget _buildSocialInfoBox(BuildContext context) {
    double iconSize = 24;
    return Container(
      height: width * 0.08,
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: AppColors.kBasicSoftPearl,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          //TODO: implement the click functionality of social info
          InkWell(
            onTap: () {
              _launchUrl(partner.facebookLink, context);
            },
            child: SvgPicture.asset(
              'lib/assets/images/icons/facebook.svg',
              width: iconSize,
              height: iconSize,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: VerticalDivider(
              color: AppColors.kPrimaryCrimsonDepth.withAlpha(120),
            ),
          ),
          InkWell(
            onTap: () {
              _launchUrl(partner.instagramLink, context);
            },
            child: SvgPicture.asset(
              'lib/assets/images/icons/instagram.svg',
              width: iconSize,
              height: iconSize,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: VerticalDivider(
              color: AppColors.kPrimaryCrimsonDepth.withAlpha(120),
            ),
          ),
          InkWell(
            onTap: () {
              _launchUrl(partner.mapLink, context);
            },
            child: SvgPicture.asset(
              'lib/assets/images/icons/location.svg',
              width: iconSize,
              height: iconSize,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String? urlString, BuildContext context) async {
    if (urlString == null || urlString.isEmpty) {
      _showSnackBar(context, 'Link is not available');
      return;
    }

    final Uri? url = Uri.tryParse(urlString);
    if (url == null) {
      _showSnackBar(context, "Couldn't open the link");
      return;
    }

    // Determine the native URL for specific platforms
    Uri nativeAppUrl;
    if (url.host.contains('facebook.com')) {
      nativeAppUrl = Uri.parse('fb://facewebmodal/f?href=$urlString');
    } else if (url.host.contains('instagram.com')) {
      final username = url.pathSegments.isNotEmpty ? url.pathSegments.first : '';
      nativeAppUrl = Uri.parse('instagram://user?username=$username');
    } else {
      nativeAppUrl = url;
    }

    try {
      // Try launching the native app URI first
      if (await canLaunchUrl(nativeAppUrl)) {
        await launchUrl(nativeAppUrl, mode: LaunchMode.externalApplication);
        return;
      }
      // Fallback to the web URL if native app is not available
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
        return;
      }
      // If both fail, show a SnackBar with a copy action
      _showSnackBar(
        context,
        'Could not open the link',
        snackBarActionLabel: 'Copy Link',
        actionOnPressed: () => Clipboard.setData(ClipboardData(text: url.toString())),
      );
    } catch (e) {
      // Handle unexpected errors
      _showSnackBar(
        context,
        'Unexpected error, please try again later',
        snackBarActionLabel: 'Copy Link',
        actionOnPressed: () => Clipboard.setData(ClipboardData(text: url.toString())),
      );
    }
  }

  _showSnackBar(BuildContext context, String message, {String? snackBarActionLabel, VoidCallback? actionOnPressed}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            message,
          ),
          action: (snackBarActionLabel != null && actionOnPressed != null)
              ? SnackBarAction(
                  textColor: AppColors.kPrimaryGoldenSunrise,
                  label: snackBarActionLabel,
                  onPressed: actionOnPressed,
                )
              : null),
    );
  }
}
