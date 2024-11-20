import 'package:bees/routes.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  void goToComplaintScreen(){
    Get.toNamed(AppRoutes.studentComplaint);
  }
  void goToReceiptScreen(){
    Get.toNamed(AppRoutes.receipt);
  }
}