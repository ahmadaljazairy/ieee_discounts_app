import 'package:flutter/material.dart';
import 'package:ieee_discounts_application/screens/partners_screen.dart';

import '../screens/home_screen.dart';
import '../screens/membership_check_screen.dart';
import '../utilities/constants.dart';
import 'app_drawer.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  // Index to control the active screen.
  int _selectedIndex = 0;

  // List of main screens.
  final List<Widget> _screens = const [
    HomeScreen(),
    PartnersScreen(),
    MembershipCheckScreen(),
  ];

  void _onDrawerItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop(); // Close the drawer after selection.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBasicSoftPearl,
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          // Use a const constructor if the asset path is fixed
          child: Image.asset('lib/assets/images/logos/ieee cs logo black.png'),
        ),
        backgroundColor: AppColors.kBasicSoftPearl,
        elevation: 0, // Remove shadow if desired
      ),
      // Reuse the custom common drawer widget.
      endDrawer: AppDrawer(
        onItemSelected: _onDrawerItemSelected,
      ),
      // The body remains fixed and swaps content via IndexedStack.
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
    );
  }
}
