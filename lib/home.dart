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
    const String number = '202-323-232';
    var pageHalfWidth = pageSize.width / 2;

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

    ///adding number on right side of title
    PdfTextElement(
            text: number,
            format: PdfStringFormat(alignment: PdfTextAlignment.right),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 20, pageSize.width, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    ///Cutomer name
    final PdfLayoutResult nameLayout = PdfTextElement(
            text: "Customer Name: ________________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 70, pageSize.width, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    // page.graphics.drawLine(PdfPen(PdfColor(300, 0, 0)),
    //     Offset(20, nameLayout.bounds.right), const Offset(40, 20));

    ///customer address
    final PdfLayoutResult customerAddressLayout = PdfTextElement(
            text:
                "Customer Address: ________________________\n                                  ________________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 100, pageSize.width, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    ///date of visit
    final PdfLayoutResult dateOfVisitLayout = PdfTextElement(
            text: "Date of Visit: ________________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 160, pageSize.width, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    ///maint tech
    final PdfLayoutResult maintTextLayout = PdfTextElement(
            text: "Maint. Tech: Anthony Manning ",
            format: PdfStringFormat(alignment: PdfTextAlignment.right),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 160, pageSize.width, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    ///line
    page.graphics.drawLine(
        PdfPen(PdfColor(0, 0, 0)),
        Offset(0, maintTextLayout.bounds.bottom + 20),
        Offset(pageSize.width, maintTextLayout.bounds.bottom + 20));

//exterior
    final PdfLayoutResult exteriorLayout = PdfTextElement(
            text:
                "Exterior Conditions -__________________\n___________________________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 220, pageSize.width / 2, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

// rh
    final PdfLayoutResult rHLayout = PdfTextElement(
            text: "RH% outside -__________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageSize.width / 2, 220, pageSize.width / 2, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    ///check box
    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: const Rect.fromLTWH(0, 262, 10, 10));
//crawl space
    final PdfLayoutResult crawlSpaceLayput = PdfTextElement(
            text: "Crawlspace - SF __________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(15, 260, pageSize.width / 2, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    //Pan CHecked

    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: Rect.fromLTWH(pageHalfWidth, 262, 10, 10));

    final PdfLayoutResult panCheckedLayout = PdfTextElement(
            text: "Pan Checked",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth + 15, 260, pageSize.width / 2, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    ///check box
    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: const Rect.fromLTWH(0, 282, 10, 10));

    final PdfLayoutResult basementLayput = PdfTextElement(
            text: "Basement - SF________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(15, 280, pageSize.width / 2, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    //water check box

    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: Rect.fromLTWH(pageHalfWidth, 282, 10, 10));

    final PdfLayoutResult waterLayout = PdfTextElement(
            text: "Water Alarm Checked",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth + 15, 280, pageSize.width / 2, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    // rh
    final PdfLayoutResult rHInsideLayout = PdfTextElement(
            text: "RH% inside -________________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 300, pageSize.width / 2, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;
//workProp
    final PdfLayoutResult workPropLayout = PdfTextElement(
            text: "Working Properly?     Yes     No",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth, 300, pageSize.width / 2, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    // wood struct
    final PdfLayoutResult woodstructLayout = PdfTextElement(
            text: "Wood Structure",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(250, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 320, pageSize.width / 2, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;
//comments
    final PdfLayoutResult comments = PdfTextElement(
            text: "Comments -__________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth, 320, pageSize.width / 2, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    ///check box
    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: const Rect.fromLTWH(0, 342, 10, 10));

    final PdfLayoutResult suspectLayput = PdfTextElement(
            text: "Suspect Visible Mold______________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(15, 340, pageSize.width / 2, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    // sump
    final PdfLayoutResult sumpLayout = PdfTextElement(
            text: "Sump Pump",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(250, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth, 340, pageSize.width / 2, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

//moisture
    final PdfLayoutResult moistureLayout = PdfTextElement(
            text: "Moisture Content -______________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 360, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    // pump
    final PdfLayoutResult pumpLayout = PdfTextElement(
            text: "Pump & Basin Type -__________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth, 360, pageSize.width / 2, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    ///check box
    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: const Rect.fromLTWH(0, 382, 10, 10));

    final PdfLayoutResult maxLayput = PdfTextElement(
            text: "Max Gaurd",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(15, 380, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    //pattery backup

    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: Rect.fromLTWH(pageHalfWidth, 382, 10, 10));

    final PdfLayoutResult batteryLayout = PdfTextElement(
            text: "Battery Backup",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth + 15, 380, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    //comments left
    final PdfLayoutResult commentsLayout = PdfTextElement(
            text: "Comments -__________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 400, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    //comments right
    final PdfLayoutResult commentsrightLayout = PdfTextElement(
            text: "Comments -__________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth, 400, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    // basement
    final PdfLayoutResult basementLayout = PdfTextElement(
            text: "Basemen Walls",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(250, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 420, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    // sump right
    final PdfLayoutResult sumprightLayout = PdfTextElement(
            text: "Sump Pump Maintainance",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(250, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth, 420, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    ///check box
    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: const Rect.fromLTWH(0, 442, 10, 10));
//Masonry Guard
    final PdfLayoutResult masonryLayput = PdfTextElement(
            text: "Masonry Guard",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(15, 440, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: Rect.fromLTWH(pageHalfWidth, 442, 10, 10));
//opump flushed
    final PdfLayoutResult pumpflushedLayout = PdfTextElement(
            text: "Pump Flushed",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth + 15, 440, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    //comments left
    final PdfLayoutResult commentsleftLayout = PdfTextElement(
            text: "Comments -__________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 460, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: Rect.fromLTWH(pageHalfWidth, 462, 10, 10));
    //pumpo and basin
    final PdfLayoutResult pumpAndBasinLayout = PdfTextElement(
            text: "Pump & Basin Cleaned - (Full Service)",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth + 15, 460, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    // basement
    final PdfLayoutResult CrawlspaceLayout = PdfTextElement(
            text: "Crawlspace Vapor Barrier",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(250, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 480, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: Rect.fromLTWH(pageHalfWidth, 482, 10, 10));
    //water and alarm
    final PdfLayoutResult waterandalarmLayout = PdfTextElement(
            text: "Water Alarm Checked (Probe or Puck)",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth + 15, 480, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    //curent tyoe

    final PdfLayoutResult currenttypeLayout = PdfTextElement(
            text: "Current Type -___________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 500, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    //working prop
    final PdfLayoutResult workingpropLayout = PdfTextElement(
            text: "Working Properly?     Yes     No",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth, 500, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    //condition
    final PdfLayoutResult condOfBarLayout = PdfTextElement(
            text: "Condition of Barrier",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 520, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    final PdfLayoutResult condOfBarCommentsLayout = PdfTextElement(
            text: "Comments - __________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth, 520, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    PdfTextElement(
            text: "Comments - __________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 540, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    ///MISC Items
    PdfTextElement(
            text: "MISC Items",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(250, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth, 540, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    //Dehumidifier
    PdfTextElement(
            text: "Dehumidifier",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(250, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 560, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

//everlast door
    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: Rect.fromLTWH(pageHalfWidth, 562, 10, 10));
    //water and alarm
    final PdfLayoutResult everlastLayout = PdfTextElement(
            text: "Everlast Door",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth + 15, 560, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    //curent type left

    final PdfLayoutResult currenttypeleftLayout = PdfTextElement(
            text: "Current Type -__________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 580, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    //working prop
    final PdfLayoutResult workingproprightLayout = PdfTextElement(
            text: "Working Properly?     Yes     No",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth, 580, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    PdfTextElement(
            text: "RH% output -__________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 600, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    PdfTextElement(
            text: "Comments -__________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth, 600, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    //working prop
    PdfTextElement(
            text: "Working Properly?     Yes     No",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 620, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: Rect.fromLTWH(pageHalfWidth, 622, 10, 10));
    //plumbin
    final PdfLayoutResult PlumbingLayout = PdfTextElement(
            text: "Plumbing Leaks - where? _____________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth + 15, 620, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    PdfTextElement(
            text: "Comments - ______________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 640, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    PdfTextElement(
            text: "____________________________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth, 640, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

//Dehumidifier
    PdfTextElement(
            text: "Dehumidifier Maintanance",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(250, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 660, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

//HVAC right
    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: Rect.fromLTWH(pageHalfWidth, 662, 10, 10));
    //hvac
    PdfTextElement(
            text: "HVAC & Duct Issues - ___________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth + 15, 660, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    ///Filter Changed / Pre-Filter Cleaned
    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: const Rect.fromLTWH(0, 682, 10, 10));
    //Filter Changed / Pre-Filter Cleaned
    PdfTextElement(
            text: "Filter Changed / Pre-Filter Cleaned",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(15, 680, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    ///Insects / Pest -
    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: Rect.fromLTWH(pageHalfWidth, 682, 10, 10));
    //Insects / Pest -
    PdfTextElement(
            text: "Insects / Pest - ___________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth + 15, 680, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    ///Dehu Drain Hose Checked
    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: const Rect.fromLTWH(0, 702, 10, 10));
    //Dehu Drain Hose Checked
    PdfTextElement(
            text: "Dehu Drain Hose Checked",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(15, 700, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    ///Pictures Taken – (Available on Request)
    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: Rect.fromLTWH(pageHalfWidth, 702, 10, 10));
    //Pictures Taken – (Available on Request)
    PdfTextElement(
            text: "Pictures Taken - (Available on Request)",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth + 15, 700, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    ///Condensate Pump Checked
    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: const Rect.fromLTWH(0, 722, 10, 10));
    //Condensate Pump Checked
    PdfTextElement(
            text: "Condensate Pump Checked",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(15, 720, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    ///Estimate Needed
    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: Rect.fromLTWH(pageHalfWidth, 722, 10, 10));
    //Estimate Needed
    PdfTextElement(
            text: "Estimate Needed",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                pageHalfWidth + 15, 720, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    ///Condensate Pump Cleaned & Flushed
    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: const Rect.fromLTWH(0, 737, 10, 10));
    //Condensate Pump Cleaned & Flushed
    PdfTextElement(
            text: "Condensate Pump Cleaned & Flushed",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(15, 735, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    ///Condensate Tube Checked
    page.graphics.drawRectangle(
        pen: PdfPen(PdfColor(0, 200, 0), width: 1),
        bounds: const Rect.fromLTWH(0, 750, 10, 10));
    //Condensate Tube Checked
    PdfTextElement(
            text: "Condensate Tube Checked",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(15, 747, pageHalfWidth, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    //Overall Comments from Visit -
    final PdfLayoutResult overallLayout = PdfTextElement(
            text:
                "Overall Comments from Visit -___________________________________________________ \n _____________________________________________________________________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 760, pageSize.width, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;
    PdfTextElement(
            text:
                "\n\n\n\n*ACTION REQUIRED:_______________________________________\n_________________________________________________________",
            format: PdfStringFormat(alignment: PdfTextAlignment.left),
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              16,
              style: PdfFontStyle.bold,
            ),
            brush: PdfSolidBrush(PdfColor(250, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 760, pageSize.width, pageSize.height),
            format: PdfLayoutFormat(
              layoutType: PdfLayoutType.paginate,
            ))!;

    // ///ACTION REQUIRED
    // PdfTextElement(
    //         text: "*ACTION REQUIRED: ",
    //         format: PdfStringFormat(alignment: PdfTextAlignment.left),
    //         font: PdfStandardFont(
    //           PdfFontFamily.helvetica,
    //           16,
    //           style: PdfFontStyle.bold,
    //         ),
    //         brush: PdfSolidBrush(PdfColor(0, 0, 0)))
    //     .draw(
    //         page: page,
    //         bounds: Rect.fromLTWH(0, 790, pageSize.width, pageSize.height),
    //         format: PdfLayoutFormat(
    //           layoutType: PdfLayoutType.paginate,
    //         ))!;

    ////

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
              onPressed: _createPdf,
            )
          ],
        ),
      ),
    );
  }
}
