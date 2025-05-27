import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../utilities/constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 200,
        width: 200,
        child: LoadingIndicator(
          indicatorType: Indicator.ballScaleMultiple,
          colors: [AppColors.kBasicSoftPearl, AppColors.kPrimaryGoldenSunrise],
          strokeWidth: 2,
          backgroundColor: Colors.transparent,
          pathBackgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
