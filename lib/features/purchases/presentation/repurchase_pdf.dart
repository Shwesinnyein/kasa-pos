import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class RepurchasePdfLine {
  const RepurchasePdfLine({required this.name, required this.unit, required this.pack, required this.single});

  final String name;
  final String unit;
  final double pack;
  final double single;
}

Future<Uint8List> buildRepurchasePdf({required String shopName, required DateTime date, required List<RepurchasePdfLine> lines}) async {
  final regular = pw.Font.ttf(await rootBundle.load('assets/fonts/NotoSansMyanmar-Regular.ttf'));
  final bold = pw.Font.ttf(await rootBundle.load('assets/fonts/NotoSansMyanmar-Bold.ttf'));
  final latin = [pw.Font.helvetica()];
  final document = pw.Document();
  document.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      theme: pw.ThemeData.withFont(base: regular, bold: bold, fontFallback: latin),
      build: (context) => [
        pw.Text(shopName, style: pw.TextStyle(font: bold, fontFallback: latin, fontSize: 14)),
        pw.SizedBox(height: 6),
        pw.Text('ပြန်ဝယ်စာရင်း', style: pw.TextStyle(font: bold, fontFallback: latin, fontSize: 22)),
        pw.SizedBox(height: 4),
        pw.Text('${date.day}/${date.month}/${date.year}', style: pw.TextStyle(font: regular, fontFallback: latin, fontSize: 12, color: PdfColors.grey700)),
        pw.SizedBox(height: 16),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.6),
          columnWidths: const {
            0: pw.FlexColumnWidth(3),
            1: pw.FlexColumnWidth(1.2),
            2: pw.FlexColumnWidth(1.6),
          },
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey200),
              children: [
                _cell('ကုန်ပစ္စည်း', bold, latin, header: true),
                _cell('ဖာ', bold, latin, header: true),
                _cell('ချင်း', bold, latin, header: true),
              ],
            ),
            for (final line in lines)
              pw.TableRow(
                children: [
                  _cell(line.name, regular, latin),
                  _cell(line.pack > 0 ? _plain(line.pack) : '-', regular, latin),
                  _cell(line.single > 0 ? '${_plain(line.single)} ${line.unit}' : '-', regular, latin),
                ],
              ),
          ],
        ),
      ],
    ),
  );
  return document.save();
}

pw.Widget _cell(String text, pw.Font font, List<pw.Font> fallback, {bool header = false}) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    child: pw.Text(
      text,
      style: pw.TextStyle(font: font, fontFallback: fallback, fontSize: header ? 12 : 13, fontWeight: header ? pw.FontWeight.bold : pw.FontWeight.normal),
    ),
  );
}

String _plain(double value) => value == value.roundToDouble() ? value.round().toString() : value.toString();
