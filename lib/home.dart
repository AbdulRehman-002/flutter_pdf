import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String path = '';
  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    //final  path = (await getExternalStorageDirectories()).path;
    // Directory appDocDirectory = await getApplicationDocumentsDirectory();
    // final path = appDocDirectory.path;

    // final file = File('$path/$fileName');
    // await file.writeAsBytes(bytes, flush: true);
    // OpenFile.open(path);

    final path = (await getExternalStorageDirectory())?.path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
  }

  // ignore: unused_element
  Future<void> _createPdf() async {
    PdfDocument document = PdfDocument();

    // final page = document.pages.add();
    // page.graphics.drawString(
    //     'Welcome to PDF!', PdfStandardFont(PdfFontFamily.helvetica, 30));

// Add a new page to the document.
    final PdfPage page = document.pages.add();
    final Size pageSize = page.getClientSize();
    PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 12);

    PdfFont titleFont = PdfStandardFont(PdfFontFamily.helvetica, 20,
        style: PdfFontStyle.underline);
    // PdfStandardFont(
    //   PdfFontFamily.helvetica,
    //   16,
    //   // style: PdfFontStyle.bold,
    // );

    const String website = 'alabamamold.com';
    const String title = 'Maintenance Findings';

    final PdfLayoutResult websiteLayout = PdfTextElement(
            text: website,
            format: PdfStringFormat(alignment: PdfTextAlignment.right),
            font: PdfStandardFont(PdfFontFamily.helvetica, 12,
                style: PdfFontStyle.bold),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
            format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;

    // page.graphics.drawLine(
    //     PdfPen(PdfColor(0, 0, 0)),
    //     Offset(0, websiteLayout.bounds.bottom + 10),
    //     Offset(pageSize.width, websiteLayout.bounds.bottom + 10));

    // Title Layout
    PdfTextElement(
            text: title,
            format: PdfStringFormat(
              alignment: PdfTextAlignment.center,
            ),
            font: titleFont,
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 10, pageSize.width, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

// Draw the next paragraph/content.
    // page.graphics.drawLine(
    //     PdfPen(PdfColor(255, 0, 0)),
    //     Offset(0, layoutResult.bounds.bottom + 10),
    //     Offset(pageSize.width, layoutResult.bounds.bottom + 10));

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, "Output.pdf");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                child: const Text(
                  'Generate PDF',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _createPdf)
          ],
        ),
      ),
    );
  }
}
