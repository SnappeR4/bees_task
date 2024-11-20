import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/receipt.dart';

Future<void> downloadPdf(Receipt receipt) async {
  final pdf = pw.Document();

  pdf.addPage(pw.Page(
    build: (pw.Context context) {
      return pw.Column(
        children: [
          pw.Text('Receipt No: ${receipt.recNo}'),
          pw.Text('Payment Date: ${receipt.paymentDate}'),
          pw.Text('Sem: ${receipt.sem}'),
          pw.Text('Exam Type: ${receipt.examType}'),
          pw.Text('Exam Month: ${receipt.examMonth}'),
        ],
      );
    },
  ));

  await Printing.layoutPdf(onLayout: (format) => pdf.save());
}
