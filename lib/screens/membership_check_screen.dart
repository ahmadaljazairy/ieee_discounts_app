import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../models/member.dart';
import '../services/api_service/api_service.dart';
import '../utilities/constants.dart';
import '../utilities/hero_box_slogans.dart';
import '../widgets/hero_box.dart';

//TODO : Check the Null Safety of Member features(attributes)
class MembershipCheckScreen extends StatefulWidget {
  const MembershipCheckScreen({super.key});

  @override
  State<MembershipCheckScreen> createState() => _MembershipCheckScreenState();
}

class _MembershipCheckScreenState extends State<MembershipCheckScreen> {
  final TextEditingController _controller = TextEditingController();

  Widget _createHeroBox(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: HeroBox(
        width: size.width * 0.95,
        height: size.height * 0.15,
        slogan: HeroBoxSlogans.getHomeScreenSlogan(),
      ),
    );
  }

  void _showMemberPopup(Member? member) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: AppColors.kBasicSoftPearl,
        child: Stack(
          children: [
            SizedBox(
              height: 300,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (member != null) ...[
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(member.imagePath!),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: SvgPicture.asset(
                              'lib/assets/images/icons/verification-filled-gold.svg',
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        member.name!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.kPrimaryCrimsonDepth,
                        ),
                      ),
                    ] else ...[
                      SvgPicture.asset(
                        'lib/assets/images/icons/unverified-dark-red.svg',
                        width: 150,
                        height: 150,
                      ),
                      Text(
                        'Sorry, this ID does not belong to a member.',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.kPrimaryCrimsonDepth,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ]
                  ],
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.grey),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkMembership() async {
    String id = _controller.text;
    if (id.isEmpty) return;

    try {
      final member = await context.read<ApiService>().fetchMember(id);
      _showMemberPopup(member);
    } catch (e) {
      _showMemberPopup(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _createHeroBox(MediaQuery.of(context).size),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Membership ID',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kPrimaryCrimsonDepth,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.kPrimaryCrimsonDepth),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'e.g. 123456789',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _controller.clear(),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: AppColors.kPrimaryCrimsonDepth,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Clear',
                          style: TextStyle(color: AppColors.kPrimaryGoldenSunrise),
                        ),
                      ),
                    ),
                    SizedBox(width: 35),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _checkMembership,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.kPrimaryGoldenSunrise,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Check',
                          style: TextStyle(color: AppColors.kPrimaryCrimsonDepth),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
