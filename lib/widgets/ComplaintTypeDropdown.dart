import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ComplaintTypeDropdown extends StatelessWidget {
  final RxString selectedComplaintType;
  final List<String> complaintTypes;
  final Function(String?) onChanged;

  ComplaintTypeDropdown({
    required this.selectedComplaintType,
    required this.complaintTypes,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: DropdownButton<String>(
          value: selectedComplaintType.value,
          isExpanded: true,
          underline: SizedBox(),
          onChanged: onChanged,
          items: complaintTypes.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      );
    });
  }
}
