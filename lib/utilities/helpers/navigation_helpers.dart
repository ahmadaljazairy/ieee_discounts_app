import 'package:flutter/material.dart';
import 'package:ieee_discounts_application/models/partner.dart';
import 'package:ieee_discounts_application/screens/partner_details_screen.dart';
import 'package:ieee_discounts_application/services/api_service/api_service.dart';
import 'package:provider/provider.dart';

class NavigationHelper {
  static Future<void> openPartnerDetails(BuildContext context, Partner partner) async {
    final String partnerId = partner.id;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final fetchedPartner = await context.read<ApiService>().fetchPartner(partnerId);

      if (context.mounted) {
        Navigator.of(context).pop(); // remove the loading dialog
      }

      if (fetchedPartner != null && context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PartnerDetailsScreen(partner: fetchedPartner),
          ),
        );
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Partner Description is not available.")),
        );
      }
    } catch (error) {
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Unexpected error occurred, please try again later.")),
        );
      }
    }
  }
}
