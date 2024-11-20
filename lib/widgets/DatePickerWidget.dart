import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePickerWidget extends StatelessWidget {
  final RxString selectedDate;
  final Function() onDateSelected;

  DatePickerWidget({
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedDate.value.isEmpty ? 'Select Date (YYYY-MM-DD)' : selectedDate.value,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            IconButton(
              icon: Icon(Icons.calendar_today, color: Colors.blue),
              onPressed: onDateSelected,
            ),
          ],
        ),
      );
    });
  }
}
