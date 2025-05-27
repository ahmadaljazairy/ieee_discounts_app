import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class AppDrawer extends StatelessWidget {
  // Callback when a drawer item is tapped.
  final void Function(int index) onItemSelected;

  const AppDrawer({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.kPrimaryDesertSand,
            ),
            child: Center(
              child: Text(
                'Welcome To IEEE CS JU Discounts App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.kBasicSoftPearl,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => onItemSelected(0),
          ),
          ListTile(
            leading: Icon(Icons.people_alt_outlined),
            title: Text('Partners'),
            onTap: () => onItemSelected(1),
          ),
          ListTile(
            leading: Icon(Icons.check_circle_outline),
            title: Text('Check Membership'),
            onTap: () => onItemSelected(2),
          ),
        ],
      ),
    );
  }
}
