import 'package:gimme/screens/transaction_screen/for_pdf/custom_row.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget gymTable(List<CustomRow> listTransaction) {
  final List<pw.TableRow> rows = [];
  final List<PdfColor> rowColors = [PdfColors.white, PdfColors.blue50];

  for (var i = 0; i < listTransaction.length; i++) {
    final CustomRow listGym = listTransaction[i];
    final PdfColor rowColor = rowColors[i % rowColors.length];

    rows.add(
      pw.TableRow(
        children: [
          pw.Container(
            alignment: pw.Alignment.center,
            padding: const pw.EdgeInsets.all(5),
            color: rowColor,
            child: pw.Text(listGym.gymName),
          ),
          pw.Container(
            alignment: pw.Alignment.center,
            padding: const pw.EdgeInsets.all(5),
            color: rowColor,
            child: pw.Text(listGym.date),
          ),
          pw.Container(
            alignment: pw.Alignment.center,
            padding: const pw.EdgeInsets.all(5),
            color: rowColor,
            child: pw.Text(listGym.package),
          ),
          pw.Container(
            alignment: pw.Alignment.center,
            padding: const pw.EdgeInsets.all(5),
            color: rowColor,
            child: pw.Text(listGym.type),
          ),
          pw.Container(
            alignment: pw.Alignment.center,
            padding: const pw.EdgeInsets.all(5),
            color: rowColor,
            child: pw.Text(listGym.price),
          ),
          pw.Container(
            alignment: pw.Alignment.center,
            padding: const pw.EdgeInsets.all(5),
            color: rowColor,
            child: pw.Text(listGym.duration),
          ),
        ],
      ),
    );
  }
  return pw.Table(children: rows);
}
