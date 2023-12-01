import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gimme/screens/transaction_screen/for_pdf/preview_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:gimme/constants.dart';

Future<void> createPdf(Map<String, dynamic> detail, BuildContext context) async {
  final doc = pw.Document();
  final now = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

  final pdfTheme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    buildBackground: (pw.Context context) {
      return pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: PdfColor.fromHex('#FFBD59'),
            width: 1,
          ),
        ),
      );
    },
  );

  doc.addPage(
    pw.MultiPage(
      pageTheme: pdfTheme,
      header: (pw.Context context) {
        return headerPdf();
      },
      build: (pw.Context context) {
        return [
          pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Table(
                  border: pw.TableBorder.all(
                    color: PdfColor.fromHex('#FFBD59'),
                    width: 1,
                  ),
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(
                            'Gym Name',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(
                            detail['receipt'],
                            style: pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(
                            'Date',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(
                            detail['date'].toString(),
                            style: pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(
                            'Price',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(
                            "Rp. ${moneyFormat(detail['price'])}",
                            style: pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(
                            'Type',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(
                            detail['type'],
                            style: pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(
                            'Package',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(
                            detail['bundle'],
                            style: pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(
                            'Duration',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(
                            detail['type'] == 'Monthly'
                                ? '1 Month' : '1 Year',
                            style: pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.Image(
                  width: 100,
                  height: 100,
                  pw.MemoryImage(
                    base64Decode(dataUser['photoURL'])
                  ),
                ),
                pw.Container(
                    margin:
                        pw.EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
                generate_barcode(detail['transaction_id']),
              ],
            ),
          ),
        ];
      },
      footer: (pw.Context context) {
        return pw.Container(
            color: PdfColor.fromHex('#FFBD59'),
            child: footerPDF(formattedDate));
      },
    ),
  );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PreviewScreen(doc: doc),
    ),
  );
}

pw.Header headerPdf() {
  return pw.Header(
    margin: pw.EdgeInsets.zero,
    outlineColor: PdfColors.amber50,
    outlineStyle: PdfOutlineStyle.normal,
    level: 5,
    decoration: pw.BoxDecoration(
      shape: pw.BoxShape.rectangle,
      gradient: pw.LinearGradient(
        colors: [
          PdfColor.fromHex('#FCDF8A'),
          PdfColor.fromHex('#F38381'),
        ],
        begin: pw.Alignment.topLeft,
        end: pw.Alignment.bottomRight,
      ),
    ),
    child: pw.Center(
      child: pw.Text(
        'Reciept Gym Transaksi',
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 12,
        ),
      ),
    ),
  );
}

pw.Center footerPDF(String formattedDate) => pw.Center(
      child: pw.Text(
        'Created at $formattedDate',
        style: pw.TextStyle(fontSize: 10, color: PdfColors.blue),
      ),
    );

pw.Container generate_barcode(String id) {
  return pw.Container(
    child: pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: pw.BarcodeWidget(
          data: id,
          width: 200.0,
          height: 60.0,
          barcode: Barcode.code128(escapes: true)),
    ),
  );
}
