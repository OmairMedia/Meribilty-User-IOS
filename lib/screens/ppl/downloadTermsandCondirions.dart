import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

//Read image data.
// final Uint8List imageData = File("assets/logo1").readAsBytesSync();
//Load the image using PdfBitmap.

Future<void> downloadTermsandConditions()  async {
  print("terms waly me aya");
  final ByteData imageData = await rootBundle.load('assets/logo1.png');
  final Uint8List img = imageData.buffer.asUint8List();
  //Create a PDF document.
  final PdfDocument document = PdfDocument();
  //Add page to the PDF
  // final PdfPage page = document.pages.add();
  final PdfPage page1 = document.pages.add();
  //Get page client size
  final Size pageSize = page1.getClientSize();
  //Draw rectangle
 
  page1.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
      pen: PdfPen(PdfColor(142, 170, 219, 255)));
  //Generate PDF grid.


  //Page # 01
  drawTermsAndConditions(page1, pageSize,img);
  final List<int> bytes = document.save();
  //Dispose the document.
  document.dispose();
  //Save and launch file.
  saveAndLaunchFile(bytes, "TermsAndConditions.pdf");
}


void drawTermsAndConditions(PdfPage page1, Size pageSize,image) {
  final PdfBitmap img = PdfBitmap(image);
  //Draw rectangle
  page1.graphics.drawRectangle(
      // brush: PdfSolidBrush(PdfColor(91, 126, 215, 255)),
      bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
  //Draw string
  page1.graphics.drawImage(
    img,
    Rect.fromLTWH(15, 0, 190, 90),
  );
  
  
  page1.graphics.drawString(
      "Terms and Conditions : ", PdfStandardFont(PdfFontFamily.helvetica, 9,style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(20, 150, 0, 0));
  //Added 30 as a margin for the layout
  page1.graphics.drawString(
      "1.	This request will remain active for three (3) hours. Please continue to refresh to explore the best rate. Please \n        note that the request will be cancelled if there is no activity for three (3) hours.",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 170, 0, 0));
  page1.graphics.drawString(
      "2.	Insurance if not opted then Meribilty takes no responsibility.",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 200, 0, 0));
  page1.graphics.drawString(
      "3.	For damages/loss Meribilty is not responsible for fire, theft, accidents, unforeseen situations, political activity \n        and acts-of-God.",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 220, 0, 0));
  page1.graphics.drawString(
      "4.	Meribilty will not be responsible for:",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 250, 0, 0));
  page1.graphics.drawString(
      "        a.	Container detention charges",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 270, 0, 0));
  page1.graphics.drawString(
      "        b.	If container is dirty and/or",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 280, 0, 0));
  page1.graphics.drawString(
      "        c.	If container is damaged.",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 290, 0, 0));
  page1.graphics.drawString(
      "5.	Loading and unloading if not opted then Meribilty takes no responsibility.  In this case Loading and unloading \n        will be arranged by the customer.",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 310, 0, 0));
  page1.graphics.drawString(
      "6.	Truck detention charges are:",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 340, 0, 0));
  page1.graphics.drawString(
      "         a.	Nationwide:",
      PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(20, 360, 0, 0));
  page1.graphics.drawString(
      "                 i.	24 hours free thereafter for PKR 4,000 for 20’ and PKR 5,000 for 40’. PKR 10,000 for low-bed.",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 380, 0, 0));

  page1.graphics.drawString(
      "         b.	Transit:",
      PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(20, 410, 0, 0));
  page1.graphics.drawString(
      "                i.	72 hours free thereafter for PKR 5,000 for 20’ and PKR 6,000 for 40’, PKR 15,000 for low-bed.",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 430, 0, 0));    
  
}



Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
final path;
  if (Platform.isIOS) {
    final path1 = await getApplicationDocumentsDirectory();
    path = path1.path;
  } else {
    path = (await getExternalStorageDirectory())!.path;
  }
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$fileName');
}

