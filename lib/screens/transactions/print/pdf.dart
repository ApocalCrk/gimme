import 'package:gimme/constants.dart';
import 'package:gimme/data/Transaction.dart';
import 'package:gimme/screens/transactions/print/previewScreen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';

Future<void> generateInvoice(Transaction data, BuildContext context) async {
  final doc = pw.Document();
  const pdfTheme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
  );

  doc.addPage(
    pw.MultiPage(
      pageTheme: pdfTheme,
      footer: (pw.Context context) {
        return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  data.gym!['name'],
                  style: const pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.Text(
                  data.gym!['place'],
                  style: const pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  'Invoice Number: ${data.id_transaction.toString()}',
                  style: const pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.SizedBox(height: 40),
                pw.Text(
                  'Date: ${formatStringDate(data.updated_at.toString())}',
                  style: const pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        );
      },
      build: (pw.Context context) {
        return [
          pw.Column(
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.only(top: 30),
                child: pw.Column(
                  children: [
                    pw.Text(
                      'Invoice Transaction',
                      style: const pw.TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    pw.Text(
                      '${data.gym!['name']}',
                      style: const pw.TextStyle(
                        fontSize: 20,
                        color: PdfColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.only(top: 30),
                child: pw.Column(
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'Invoice Number',
                          style: const pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        pw.Text(
                          data.id_transaction.toString(),
                          style: const pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'Date Transaction',
                          style: const pw.TextStyle(
                            fontSize: 15,
      
                          ),
                        ),
                        pw.Text(
                          formatStringDate(data.updated_at.toString()),
                          style: const pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'Payment Method',
                          style: const pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        pw.Text(
                          data.payment_method.toString(),
                          style: const pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'Payment Status',
                          style: const pw.TextStyle(
                            fontSize: 15,
      
                          ),
                        ),
                        pw.Text(
                          data.payment_status.toString(),
                          style: const pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              )
            ],
          ),
          pw.Container(
            padding: const pw.EdgeInsets.only(top: 30),
            child: pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Bundle',
                      style: const pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    pw.Text(
                      data.bundle.toString(),
                      style: const pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Type Membership',
                      style: const pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    pw.Text(
                      data.type_membership.toString(),
                      style: const pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Payment Amount',
                      style: const pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    pw.Text(
                      "Rp. ${moneyFormat(data.payment_amount)},00",
                      style: const pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
              ],
            )
          )
        ];
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