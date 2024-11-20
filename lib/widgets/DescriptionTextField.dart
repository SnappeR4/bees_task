import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DescriptionTextField extends StatelessWidget {
  final TextEditingController controller;

  DescriptionTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 4,
      decoration: const InputDecoration(
        labelText: "Complaint Description",
        border: OutlineInputBorder(),
      ),
    );
  }
}
