import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'models/complaint.dart';
import 'routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Register the Complaint adapter
  Hive.registerAdapter(ComplaintAdapter());

  // Open the complaints box
  await Hive.openBox<Complaint>('complaints');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Student Complaint & Receipt App',
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}