import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/receipt_controller.dart';
import '../models/receipt.dart';
import '../widgets/ReceiptCard.dart';

class ReceiptScreen extends StatelessWidget {
  final ReceiptController controller = Get.put(ReceiptController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipts'),
        centerTitle: true,
        backgroundColor: Colors.green, // Set the background color to green
        foregroundColor: Colors.white, // Set the text and icon color to white
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          // SizedBox(height: 10,),
          Expanded(
            child: Obx(() {


              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.isNoInternet.value) {
                // Display "No Internet" image
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/no_internet.png', width: 200), // Add an image for no internet
                      const SizedBox(height: 20),
                      const Text(
                        'No Internet Connection',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }

              if (controller.receipts.isEmpty) {
                return const Center(child: Text('No receipts found.'));
              }

              final receipts = controller.receipts;

              return ListView.builder(
                itemCount: receipts.length,
                itemBuilder: (context, index) {
                  final receipt = receipts[index];
                  return ReceiptCard(
                    recNo: receipt.recNo,
                    paymentDate: receipt.formattedPaymentDate,
                    sem: receipt.sem,
                    examType: receipt.examType,
                    examMonth: receipt.examMonth,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

Widget _buildSearchBar() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      decoration: InputDecoration(
        labelText: 'Search Receipts',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    ),
  );
}
