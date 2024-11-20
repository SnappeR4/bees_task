import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/complaint.dart';

class ComplaintListWidget extends StatelessWidget {
  final Box<Complaint> complaintBox;
  final RxString selectedComplaintType;
  final RxString selectedDate;
  final TextEditingController descriptionController;
  final RxString filePath;

  ComplaintListWidget({
    required this.complaintBox,
    required this.selectedComplaintType,
    required this.selectedDate,
    required this.descriptionController,
    required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: complaintBox.listenable(),
      builder: (context, Box<Complaint> box, _) {
        if (box.isEmpty) {
          return const Text("No complaints available.");
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: box.length,
          itemBuilder: (context, index) {
            final complaint = box.getAt(index)!;

            return Card(
              child: ListTile(
                title: Text(complaint.type),
                subtitle: Text("${complaint.date}\n${complaint.description}"),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        // Set values for editing
                        selectedComplaintType.value = complaint.type;
                        selectedDate.value = complaint.date;
                        descriptionController.text = complaint.description;
                        filePath.value = complaint.filePath;
                        box.deleteAt(index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Show confirmation dialog before deleting
                        _showDeleteConfirmationDialog(context, box, index);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Function to show the confirmation dialog
  void _showDeleteConfirmationDialog(BuildContext context, Box<Complaint> box, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text("Are you sure you want to delete this complaint?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Dismiss the dialog without deleting
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Delete the complaint
                box.deleteAt(index);
                Navigator.of(context).pop();
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
