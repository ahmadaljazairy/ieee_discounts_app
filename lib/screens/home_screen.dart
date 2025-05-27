import 'package:flutter/material.dart';
import 'package:ieee_discounts_application/services/api_service/api_service.dart';
import 'package:ieee_discounts_application/utilities/hero_box_slogans.dart';
import 'package:ieee_discounts_application/widgets/hero_box.dart';
import 'package:provider/provider.dart';

import '../models/partner.dart';
import '../utilities/constants.dart';
import '../utilities/helpers/navigation_helpers.dart';
import '../widgets/helper_widgets/empty_state_widget.dart';
import '../widgets/helper_widgets/error_widget.dart';
import '../widgets/helper_widgets/loading_widget.dart';
import '../widgets/partner_widgets/partner_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return FutureBuilder<Map<String, List<Partner>>?>(
      future: context.read<ApiService>().fetchPartnersCategorized(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        }

        if (snapshot.hasError) {
          return CustomErrorWidget(snapshot.error!);
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const EmptyStateWidget(
            message: "No partners available at the moment.",
          );
        }

        final categorizedPartners = snapshot.data!;
        return _buildContentList(context, categorizedPartners, size);
      },
    );
  }

  Widget _buildContentList(
    BuildContext context,
    Map<String, List<Partner>> categorizedPartners,
    Size size,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: categorizedPartners.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildHeroBox(size);
        } else {
          final categoryIndex = index - 1;
          return _buildCategorySection(context, categorizedPartners, categoryIndex, size);
        }
      },
    );
  }

  Widget _buildHeroBox(Size size) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: HeroBox(
        width: size.width * 0.95,
        height: size.height * 0.15,
        slogan: HeroBoxSlogans.getHomeScreenSlogan(),
      ),
    );
  }

  Widget _buildCategorySection(
    BuildContext context,
    Map<String, List<Partner>> categorizedPartners,
    int categoryIndex,
    Size size,
  ) {
    final categoryName = categorizedPartners.keys.elementAt(categoryIndex);
    final partners = categorizedPartners[categoryName]!;

    final double horizontalListHeight = size.height * 0.15;
    final double partnerCardWidth = size.width * 0.55;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            categoryName,
            style: TextStyle(
              fontSize: 18,
              color: AppColors.kPrimaryCrimsonDepth,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        // Horizontal List of Partner Cards
        SizedBox(
          height: horizontalListHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: partners.length,
            itemBuilder: (context, partnerIndex) {
              return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: PartnerCard.create(
                    cardType: CardType.homeScreen,
                    partner: partners[partnerIndex],
                    width: partnerCardWidth,
                    height: horizontalListHeight,
                    onTap: () => NavigationHelper.openPartnerDetails(context, partners[partnerIndex]),
                  ));
            },
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
