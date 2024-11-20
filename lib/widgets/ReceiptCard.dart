import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';  // For saving files to external storage
import 'package:permission_handler/permission_handler.dart';  // For permission handling

class ReceiptCard extends StatelessWidget {
  final String recNo;
  final String paymentDate;
  final String sem;
  final String examType;
  final String examMonth;

  ReceiptCard({
    required this.recNo,
    required this.paymentDate,
    required this.sem,
    required this.examType,
    required this.examMonth,
  });

  @override
  Widget build(BuildContext context) {
    // Convert the examType to an integer to check for even/odd
    int examTypeNumber = int.tryParse(examType) ?? 0;
    String examTypeStatus = (examTypeNumber % 2 == 0) ? 'Regular' : 'Backlog';

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.black, width: 1), // Black border for the card
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        title: Column(
          children: [
            Row(
              children: [
                Text(
                  "RecNo",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow[700], // Golden color for RecNo
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.download,
                    color: Colors.yellow[700],
                  ),
                  onPressed: () {
                    _downloadCard(context);
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  recNo,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold, // Make black text bold
                    color: Colors.black, // Black color for recNo
                  ),
                ),
              ],
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment Date',
                  style: TextStyle(
                    color: Colors.yellow[700], // Golden color
                  ),
                ),
                Text(
                  'Sem',
                  style: TextStyle(
                    color: Colors.yellow[700], // Golden color
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  paymentDate,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, // Make black text bold
                    color: Colors.black, // Black color
                  ),
                ),
                Text(
                  '$sem SEMESTER',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, // Make black text bold
                    color: Colors.black, // Black color
                  ),
                ),
              ],
            ),
            const Divider(),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Exam Type',
                      style: TextStyle(
                        color: Colors.yellow[700], // Golden color
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Exam Month',
                      style: TextStyle(
                        color: Colors.yellow[700], // Golden color
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      examTypeStatus,  // Display Regular or Backlog based on examType number
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Make black text bold
                        color: Colors.black, // Black color
                      ),
                    ),
                    const Spacer(),
                    Text(
                      examMonth,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Make black text bold
                        color: Colors.black, // Black color
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Simulate the download action and save a file in the public Downloads folder
  Future<void> _downloadCard(BuildContext context) async {
    // Request permission to access storage
    if (await Permission.storage.request().isGranted) {
      try {
        // Access the Downloads folder in external storage
        final directory = Directory('/storage/emulated/0/Download');  // Public Downloads folder path on Android
        if (await directory.exists()) {
          final file = File('${directory.path}/receipt_${recNo}.txt');
          await file.writeAsString(
              'Receipt Details\nRecNo: $recNo\nPayment Date: $paymentDate\nSem: $sem\nExam Type: $examType\nExam Month: $examMonth');

          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Receipt saved to Downloads')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Download directory not found')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error saving file')));
      }
    } else {
      // Show a message if permission is not granted
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permission to access storage denied')));
    }
  }
}
