import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  const EmptyStateWidget({this.message = "No data available.", super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}
