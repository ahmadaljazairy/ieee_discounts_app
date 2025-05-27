import 'package:flutter/material.dart';

import '../../services/api_service/exceptions.dart';

class CustomErrorWidget extends StatelessWidget {
  final Object error;
  const CustomErrorWidget(this.error, {super.key});

  @override
  Widget build(BuildContext context) {
    String errorMessage;
    IconData errorIcon;

    if (error is NoInternetConnectionException) {
      errorMessage = "No internet connection. Please check your network.";
      errorIcon = Icons.wifi_off;
    } else if (error is RequestTimeoutException) {
      errorMessage = "The request timed out. Please try again later.";
      errorIcon = Icons.timer_off;
    } else if (error is ApiException) {
      errorMessage = "Failed to connect to the server.";
      errorIcon = Icons.cloud_off;
    } else {
      errorMessage = "An unexpected error occurred, please try again later.";
      errorIcon = Icons.error_outline;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(errorIcon, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
