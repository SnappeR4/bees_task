import 'package:get/get.dart';
import 'screens/splash_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/student_complaint_screen.dart';
import 'screens/receipt_screen.dart';

class AppRoutes {
  static const splash = '/splash';
  static const dashboard = '/dashboard';
  static const studentComplaint = '/studentComplaint';
  static const receipt = '/receipt';

  static final pages = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: dashboard, page: () => DashboardScreen()),
    GetPage(name: studentComplaint, page: () => StudentComplaintScreen()),
    GetPage(name: receipt, page: () => ReceiptScreen()),
  ];
}
