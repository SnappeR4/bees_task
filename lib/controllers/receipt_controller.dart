import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../models/receipt.dart';

class ReceiptController extends GetxController {
  var receipts = <Receipt>[].obs;
  var isLoading = true.obs;
  var isNoInternet = false.obs;
  @override
  void onInit(){
    super.onInit();
    _checkInternetConnection();
    fetchReceipts();
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.ethernet) {
      isNoInternet.value = false;
    } else {
      isNoInternet.value = true;
    }
  }

  Future<List<Receipt>> fetchReceipts() async {
    try {
      // Set loading to true when starting the API call
      isLoading.value = true;
      print('Loading receipts...');

      final dio = Dio();
      final response = await dio.get('https://673d94a10118dbfe8607d0ac.mockapi.io/receipts/receipt'); // Replace with actual API URL

      // Log the raw API response data
      print('API Response: ${response.data}');

      // Assuming the response is a List of JSON objects for receipts
      final List<Receipt> fetchedReceipts = List<Receipt>.from(
        response.data.map((receiptData) => Receipt.fromMap(receiptData)),
      );

      // Log the list of fetched receipts
      print('Fetched Receipts: $fetchedReceipts');

      // Update the receipts list and set loading to false
      receipts.value = fetchedReceipts;
      isLoading.value = false;

      if(fetchedReceipts.isNotEmpty){
        isNoInternet.value = false;
      }
      return fetchedReceipts;
    } catch (e) {
      // Log the error
      print('Error fetching receipts: $e');

      // Handle error and set loading to false
      isLoading.value = false;
      rethrow;
    }
  }
}
