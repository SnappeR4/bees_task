import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bees/controllers/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Responsive Button 1 - Transport Management
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: controller.goToComplaintScreen,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(screenSize.width * 0.8, 50), // Button width 80% of screen
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: TextStyle(fontSize: screenSize.width * 0.05), // Responsive text size
                  ),
                  child: const Text("Complaints Management 🎓"),
                ),
              ),
              // Space between buttons
              SizedBox(height: screenSize.height * 0.03),
              // Responsive Button 2 - Receipt
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: controller.goToReceiptScreen,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(screenSize.width * 0.8, 50), // Button width 80% of screen
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: TextStyle(fontSize: screenSize.width * 0.05), // Responsive text size
                  ),
                  child: const Text("Receipts 🧾"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
