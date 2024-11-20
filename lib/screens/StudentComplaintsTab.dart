import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/complaint.dart';
import '../utils/date_picker.dart';
import '../utils/file_picker.dart';
import '../widgets/ComplaintListWidget.dart';
import '../widgets/ComplaintTypeDropdown.dart';
import '../widgets/DatePickerWidget.dart';
import '../widgets/DescriptionTextField.dart';
import '../widgets/FilePickerButton.dart';

class StudentComplaintsTab extends StatefulWidget {
  @override
  _StudentComplaintsTabState createState() => _StudentComplaintsTabState();
}

class _StudentComplaintsTabState extends State<StudentComplaintsTab> {
  final RxString selectedComplaintType = 'Bus Timing'.obs;
  final RxString selectedDate = ''.obs;
  final RxString filePath = ''.obs;
  final TextEditingController descriptionController = TextEditingController();

  final List<String> complaintTypes = ['Bus Timing', 'Category 2', 'Category 3', 'Category 4'];
  final Box<Complaint> complaintBox = Hive.box<Complaint>('complaints');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ComplaintTypeDropdown(
              selectedComplaintType: selectedComplaintType,
              complaintTypes: complaintTypes,
              onChanged: (newValue) {
                selectedComplaintType.value = newValue!;
              },
            ),
            const SizedBox(height: 16.0),

            DatePickerWidget(
              selectedDate: selectedDate,
              onDateSelected: () async {
                final DateTime? pickedDate = await showCustomDatePicker(context);
                if (pickedDate != null) {
                  selectedDate.value = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                }
              },
            ),
            const SizedBox(height: 16.0),

            DescriptionTextField(controller: descriptionController),
            const SizedBox(height: 16.0),

            FilePickerButton(
              filePath: filePath,
              onPressed: () async {
                final path = await pickFile();
                if (path != null) {
                  filePath.value = path;
                }
              },
            ),
            const SizedBox(height: 8.0),

            Obx(() {
              return filePath.value.isNotEmpty
                  ? Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Selected File: ${filePath.value}'),
              )
                  : const SizedBox.shrink();
            }),
            const SizedBox(height: 16.0),

            // Send Complaint Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
                onPressed: () {
                  // Validate form fields
                  if (selectedDate.value.isEmpty) {
                    // If date is not selected
                    Get.snackbar("Error", "Please select a date", snackPosition: SnackPosition.TOP);
                    return; // Exit early if validation fails
                  }

                  if (descriptionController.text.isEmpty) {
                    // If description is empty
                    Get.snackbar("Error", "Description cannot be empty", snackPosition: SnackPosition.TOP);
                    return; // Exit early if validation fails
                  }

                  // Create complaint object after validation
                  final complaint = Complaint(
                    type: selectedComplaintType.value,
                    date: selectedDate.value,
                    description: descriptionController.text,
                    filePath: filePath.value,
                  );

                  // Save complaint to Hive
                  complaintBox.add(complaint);

                  // Reset form fields
                  selectedComplaintType.value = 'Bus Timing';
                  selectedDate.value = '';
                  filePath.value = '';
                  descriptionController.clear();

                  // Optionally show success message
                  Get.snackbar("Success", "Complaint sent successfully", snackPosition: SnackPosition.TOP);
                },

                child: const Text('Send Complaint'),
              ),
            ),
            const SizedBox(height: 24.0),

            // Complaints List Title
            const Text(
              "Complaint Requests",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),

            // Complaints List
            ComplaintListWidget(
              complaintBox: complaintBox,
              selectedComplaintType: selectedComplaintType,
              selectedDate: selectedDate,
              descriptionController: descriptionController,
              filePath: filePath,
            ),
          ],
        ),
      ),
    );
  }
}
