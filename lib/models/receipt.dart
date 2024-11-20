import 'package:intl/intl.dart';

class Receipt {
  int? id;
  String recNo;
  DateTime paymentDate;
  String sem;
  String examType;
  String examMonth;

  Receipt({
    this.id,
    required this.recNo,
    required this.paymentDate,
    required this.sem,
    required this.examType,
    required this.examMonth,
  });

  // Convert a Receipt into a Map
  Map<String, dynamic> toMap() {
    return {
      'recNo': recNo,
      'paymentDate': paymentDate.millisecondsSinceEpoch,
      'sem': sem,
      'examType': examType,
      'examMonth': examMonth,
    };
  }

  // Convert a Map into a Receipt
  factory Receipt.fromMap(Map<String, dynamic> map) {
    return Receipt(
      id: int.tryParse(map['id'].toString()), // Ensure the id is parsed correctly as an integer
      recNo: map['recNo'].toString(),
      paymentDate: DateTime.fromMillisecondsSinceEpoch(map['paymentDate'] * 1000), // Convert timestamp to DateTime
      sem: map['sem'].toString(),
      examType: map['examType'],
      examMonth: map['examMonth'],
    );
  }

  String get formattedPaymentDate {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(paymentDate);
  }
}
