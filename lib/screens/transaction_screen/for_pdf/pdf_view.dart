import 'package:flutter/material.dart';
import 'package:gimme/screens/transaction_screen/for_pdf/custom_row.dart';
import 'package:gimme/screens/transaction_screen/for_pdf/preview_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:barcode_widget/barcode_widget.dart';

// Future<void> createPdf(List<Transaction> listData, BuildContext context,
//     String uuidBarcode) async {
//   final doc = pw.Document();
//   final now = DateTime.now();
//   final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
//   final List<CustomRow> data = [
//     CustomRow("Gym Name", "Date", "Package", "Type", "Price", "Duration"),
//     for (var data in listData)
//       CustomRow(
//         data.gymName!,
//         data.date!,
//         data.package!,
//         data.type!,
//         data.price!,
//         data.duration!,
//       ),
//   ];
//   pw.Widget table = gymTable(data);

//   final pdfTheme = pw.PageTheme(
//     pageFormat: PdfPageFormat.a4,
//     buildBackground: (pw.Context context) {
//       return pw.Container(
//         decoration: pw.BoxDecoration(
//           border: pw.Border.all(
//             color: PdfColor.fromHex('#FFBD59'),
//             width: 1,
//           ),
//         ),
//       );
//     },
//   );

//   doc.addPage(
//     pw.MultiPage(
//       pageTheme: pdfTheme,
//       header: (pw.Context context) {
//         return headerPdf();
//       },
//       build: (pw.Context context) {
//         return [
//           pw.Center(
//             child: pw.Column(
//               mainAxisAlignment: pw.MainAxisAlignment.center,
//               crossAxisAlignment: pw.CrossAxisAlignment.center,
//               children: [
//                 pw.Container(
//                     margin:
//                         pw.EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
//                 generate_barcode(uuidBarcode),
//                 table,
//               ],
//             ),
//           ),
//         ];
//       },
//       footer: (pw.Context context) {
//         return pw.Container(
//             color: PdfColor.fromHex('#FFBD59'),
//             child: footerPDF(formattedDate));
//       },
//     ),
//   );

//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => PreviewScreen(doc: doc),
//     ),
//   );
// }

// pw.Header headerPdf() {
//   return pw.Header(
//     margin: pw.EdgeInsets.zero,
//     outlineColor: PdfColors.amber50,
//     outlineStyle: PdfOutlineStyle.normal,
//     level: 5,
//     decoration: pw.BoxDecoration(
//       shape: pw.BoxShape.rectangle,
//       gradient: pw.LinearGradient(
//         colors: [
//           PdfColor.fromHex('#FCDF8A'),
//           PdfColor.fromHex('#F38381'),
//         ],
//         begin: pw.Alignment.topLeft,
//         end: pw.Alignment.bottomRight,
//       ),
//     ),
//     child: pw.Center(
//       child: pw.Text(
//         'Reciept Gym Transaksi',
//         style: pw.TextStyle(
//           fontWeight: pw.FontWeight.bold,
//           fontSize: 12,
//         ),
//       ),
//     ),
//   );
// }

// pw.Center footerPDF(String formattedDate) => pw.Center(
//       child: pw.Text(
//         'Created at $formattedDate',
//         style: pw.TextStyle(fontSize: 10, color: PdfColors.blue),
//       ),
//     );

// pw.Container generate_barcode(String id) {
//   return pw.Container(
//     child: pw.Padding(
//       padding: pw.EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
//       child: pw.BarcodeWidget(
//           data: id,
//           width: 200.0,
//           height: 60.0,
//           barcode: Barcode.code128(escapes: true)),
//     ),
//   );
// }
