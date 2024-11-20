import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/SplashController.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use the SplashController to check permissions
    final splashController = Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image centered on the screen
            Image.asset(
              'assets/images/app_logo/bees_logo.png',  // Update with the path to your image
              width: 300,  // You can adjust the size as needed
              height: 300,  // You can adjust the size as needed
            ),
            const SizedBox(height: 20),  // Add space between image and text
            const Text(
              'Splash Screen',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}