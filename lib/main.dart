import 'package:flutter/material.dart';
import 'package:ieee_discounts_application/services/api_service/api_service.dart';
import 'package:ieee_discounts_application/utilities/theme/theme.dart';
import 'package:ieee_discounts_application/widgets/app_scaffold.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider(create: (context) => ApiService()),
    ],
    child: const DiscountsApp(),
  ));
}

class DiscountsApp extends StatelessWidget {
  const DiscountsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IEEE CS JU Discounts',
      theme: AppTheme.lightTheme,
      home: AppScaffold(),
    );
  }
}
