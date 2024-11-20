import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilePickerButton extends StatelessWidget {
  final RxString filePath;
  final Future<void> Function() onPressed;

  FilePickerButton({
    required this.filePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
        ),
        onPressed: onPressed,
        child: const Text('Pick File'),
      ),
    );
  }
}
