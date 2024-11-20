import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../screens/dashboard_screen.dart';  // For device info


class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 2), () {
      checkPermissionsAndNavigate();
    });
  }
  // Check for storage permission
  Future<bool> _getStoragePermission() async {
    bool permissionGranted = false;
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    AndroidDeviceInfo android = await plugin.androidInfo;

    if (android.version.sdkInt < 33) {
      if (await Permission.storage.request().isGranted) {
        permissionGranted = true;
      } else if (await Permission.storage.request().isPermanentlyDenied) {
        await openAppSettings();
      } else if (await Permission.storage.request().isDenied) {
        permissionGranted = false;
      }
    } else {
      if (await Permission.photos.request().isGranted) {
        permissionGranted = true;
      } else if (await Permission.photos.request().isPermanentlyDenied) {
        await openAppSettings();
      } else if (await Permission.photos.request().isDenied) {
        permissionGranted = false;
      }
    }
    return permissionGranted;
  }

  // Perform permission check and navigate to next screen
  void checkPermissionsAndNavigate() async {
    bool permissionGranted = await _getStoragePermission();
    if (permissionGranted) {
      Get.offAll(DashboardScreen());
    } else {
      // Handle case when permission is not granted, you can show a message or take action
      Get.snackbar('Permission Denied', 'Storage permission is required to proceed');
    }
  }
}