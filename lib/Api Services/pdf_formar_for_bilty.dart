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

Future<void> downloadInvoiceBilty(
    {required customerId,
    required origin,
    required destination,
    required sender,
    required senderAddress,
    required receiver,
    required biltyNo,
    required bookingNumber,
    required date,
    required material,
    required weight,
    required amount,
    required vehicleType,
    required recieverName,
    required recieverAddress}) async {
  final ByteData imageData = await rootBundle.load('assets/logo1.png');
  final Uint8List img = imageData.buffer.asUint8List();
  //Create a PDF document.
  final PdfDocument document = PdfDocument();
  //Add page to the PDF
  final PdfPage page = document.pages.add();
  final PdfPage page1 = document.pages.add();
  //Get page client size
  final Size pageSize = page.getClientSize();
  //Draw rectangle
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
      pen: PdfPen(PdfColor(142, 170, 219, 255)));
  page1.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
      pen: PdfPen(PdfColor(142, 170, 219, 255)));
  //Generate PDF grid.
  final PdfGrid grid = getGrid(weight, material, vehicleType, amount);
  //Draw the header section by creating text element
  final PdfLayoutResult? result = drawHeader(
      page,
      pageSize,
      grid,
      img,
      biltyNo,
      bookingNumber,
      date,
      customerId,
      origin,
      destination,
      sender,
      senderAddress,
      recieverAddress,
      recieverName);
  //Draw grid
  drawGrid(page, grid, result!, amount);
  //Add invoice footer
  drawFooter(page, pageSize);
  //Save and launch the document

  //Page # 02
  drawTermsAndConditions(page1, pageSize);
  final List<int> bytes = document.save();
  //Dispose the document.
  document.dispose();
  //Save and launch file.
  saveAndLaunchFile(bytes, "${biltyNo}.pdf");
}

//Draws the invoice header
PdfLayoutResult? drawHeader(
    PdfPage page,
    Size pageSize,
    PdfGrid grid,
    image,
    biltyNo,
    bookingNumber,
    date,
    customerId,
    origin,
    destination,
    sender,
    senderAddress,
    recieverAddress,
    recieverName) {
  final PdfBitmap img = PdfBitmap(image);
  //Draw rectangle
  page.graphics.drawRectangle(
      // brush: PdfSolidBrush(PdfColor(91, 126, 215, 255)),
      bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
  //Draw string
  page.graphics.drawImage(
    img,
    Rect.fromLTWH(15, 0, 190, 90),
  );

  final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
  //Draw string
  //Create data foramt and convert it to text.
  final DateFormat format = DateFormat.yMMMMd('en_US');
  final String invoiceNumber =
      'Bilty Number: $biltyNo\r\n\r\nOrder Number: $bookingNumber \r\n\r\nDate: $date';
  ;
  final Size contentSize = contentFont.measureString(invoiceNumber);
  final String address =
      'Customer ID: $customerId \r\n\r\nCustomer Name: $sender \r\n\r\nCustomer Address: $senderAddress\r\n\r\nReceiver Name: $recieverName \r\n\r\nReceiver Address: $recieverAddress \r\n\r\nFrom(Origin): $origin \r\n\r\nTo(Destination): $destination';

  PdfTextElement(text: invoiceNumber, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
          contentSize.width + 30, pageSize.height - 120));

  return PdfTextElement(text: address, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(30, 120, pageSize.width - (contentSize.width + 30),
          pageSize.height - 120));
}

//Draws the grid
void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result, amount) {
  Rect totalPriceCellBounds = result.bounds;
  Rect quantityCellBounds = result.bounds;
  //Invoke the beginCellLayout event.
  grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
    final PdfGrid grid = sender as PdfGrid;
    if (args.cellIndex == grid.columns.count - 1) {
      totalPriceCellBounds = args.bounds;
    } else if (args.cellIndex == grid.columns.count - 2) {
      quantityCellBounds = args.bounds;
    }
  };
  //Draw the PDF grid and get the result.
  result = grid.draw(
      page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;

  //Draw grand total.
  // page.graphics.drawString('Grand Total: ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} PKR',
  //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
  //     bounds: Rect.fromLTWH(quantityCellBounds.left, result.bounds.bottom + 10,
  //         page.getClientSize().width, page.getClientSize().height));
  page.graphics.drawString(getTotalAmount(grid).toString(),
      PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(
          totalPriceCellBounds.left, result.bounds.bottom + 10, 10, 10));
}

String noteText =
    "1.	This is a system generated receipt and does not require any signatures.\r\n\r\n";
// 2.	All payments are made to Meribilty (Private) Limited                    \r\n\r\n3.	Meribilty (Private) Limited FBR NTN # 4604731                           \r\n\r\n4.	All tax deducted is deposited to governmental tax authorities          ";

//Draw the invoice footer data.
void drawFooter(PdfPage page, Size pageSize) {
  page.graphics.drawString(
      "Note : ", PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, pageSize.height - 160, 0, 0));
  //Added 30 as a margin for the layout
  page.graphics.drawString(
      noteText, PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, pageSize.height - 140, 0, 0));

  PdfTextWebLink(
          url: 'http://www.meribilty.com/termsofservice',
          text:
              '2.	For terms and conditions please refer www.meribilty.com/termsofservice',
          font: PdfStandardFont(PdfFontFamily.helvetica, 9),
          format: PdfStringFormat())
      .draw(
          page,
          Offset(
            20,
            pageSize.height - 122,
          ));
}

void drawTermsAndConditions(PdfPage page1, Size pageSize) {
  page1.graphics.drawString(
      "Terms and Conditions : ", PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 20, 0, 0));
  //Added 30 as a margin for the layout
  page1.graphics.drawString(
      "1.	 The shipping goods should be insured before booking; otherwise, the company will not be answerable for any\n        damages",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 40, 0, 0));
  page1.graphics.drawString(
      "2.	 In case of theft, fire, or any other mishap, the company will not be responsible.",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 70, 0, 0));
  page1.graphics.drawString(
      "3.	 The bilty is valid only for 30 days; after that, it will be considered invalid. Furthermore, the goods will\n        not be allowed to receive after 30 days. In case of no bilty or no delivery of goods, a written complaint should\n        be filed where the booking was issued within 10 days. Otherwise, the goods will be considered delivered. ",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 90, 0, 0));
  page1.graphics.drawString(
      "4.	 The trader should write the information about the shipping goods in the bilty, and he will be responsible\n        for everything. ",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 130, 0, 0));
  page1.graphics.drawString(
      "5.	 The responsibility for dangerous goods and misdeclaration of illegal acts will be on the trader. Any damage\n        caused by dangerous chemical substances and flammable things will result in legal action, a fine on the trader,\n        and all the other expenses. ",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 160, 0, 0));
  page1.graphics.drawString(
      "6.	 In case of police, excise officer, or customs court guard ask for the imported goods' shipping papers, then\n        the trader has to provide them. If the vehicle must stop for days because of incomplete or invalid papers, then the\n        and all the other expenses. ",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 200, 0, 0));
  page1.graphics.drawString(
      "7.	 The responsibility of insurance for leaking items, chemicals, expensive,fragile items, and weather-sensitive\n        things will be on the trader. The company will not pay any fine or claim. Only the transport company\n        will pay the claim whose insurance has been paid to the insurance company. ",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 240, 0, 0));
  page1.graphics.drawString(
      "8.	 The company or agency will not be considered responsible in case of items like oil, ghee, preserved fruits,\n        and other liquid goods are wasted due to inadequate packaging.",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 280, 0, 0));
  page1.graphics.drawString(
      "9.	 The responsibility of bank bilty without any written agreement will be on the trader.",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 310, 0, 0));
  page1.graphics.drawString(
      "10.   The company is not responsible for storing the goods; thus, the company will not pay any claims.",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 330, 0, 0));
  page1.graphics.drawString(
      "11.	The bilty will be transferred to the address given by the trader. The trader must thoroughly check the delivered\n         goods and receive them on time",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 350, 0, 0));
  page1.graphics.drawString(
      "12.	The goods will be delivered in one place, and more dues will be charged in case of more than one place of\n         delivery.",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 380, 0, 0));
  page1.graphics.drawString(
      "13.	The trader has to write the correct weight on the bilty. The company will demand more money if the ,\n         weight of shipping goods will be more than mentioned on the bilty. The trader also has to pay any\n         overloading fine. ",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 410, 0, 0));
  page1.graphics.drawString(
      "14.	The company or agency will not be considered responsible in case of items like oil, ghee, preserved fruits,\n         and other liquid goods are wasted due to inadequate packaging.",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 450, 0, 0));
  page1.graphics.drawString(
      "15.	The delivery charges will be the same as written on the bilty, and any rectification concerning and other\n          liquid goods are wasted due to inadequate packaging.",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 480, 0, 0));
  page1.graphics.drawString(
      "16.	The delivery charges will be the same as written on the bilty, and any rectification concerning charges \n         or any other information will be possible within 6 hours of the issuance of the bilty. ",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 510, 0, 0));
  page1.graphics.drawString(
      "17.	The company will submit an FIR complaint of any robbery or theft during the transportation of goods,\n          and then the trader will be responsible for further legal procedures. ",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 540, 0, 0));
  page1.graphics.drawString(
      "18.	The company will not be responsible if items packed in paper bags, sanitary, glass, or furniture are \n         damaged during the process of transportation.",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 570, 0, 0));
  page1.graphics.drawString(
      "19.	In case of any dispute, only those instructions will be followed where the bilty was issued.",
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, 600, 0, 0));
}

//Create PDF grid and return
PdfGrid getGrid(material, weight, vehicleType, amount) {
  //Create a PDF grid
  final PdfGrid grid = PdfGrid();
  //Secify the columns count to the grid.
  grid.columns.add(count: 5);
  //Create the header row of the grid.
  final PdfGridRow headerRow = grid.headers.add(1)[0];
  //Set style
  headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
  headerRow.style.textBrush = PdfBrushes.white;
  headerRow.cells[0].value = '';
  headerRow.cells[1].value = 'Description Of Goods';
  headerRow.cells[2].value = 'Weight (Kg/Ton)';
  headerRow.cells[4].value = 'Vehicle Type';
  addProducts('', "$weight", '$material', vehicleType, grid);
// Here weight is beeing used as material and material is beeing used as weight so sorry for fucking your mind
  //Apply the grid built-in style
  grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
  grid.columns[1].width = 200;
  for (int i = 0; i < headerRow.cells.count; i++) {
    headerRow.cells[i].style.cellPadding =
        PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
  }
  for (int i = 0; i < grid.rows.count; i++) {
    final PdfGridRow row = grid.rows[i];
    for (int j = 0; j < row.cells.count; j++) {
      final PdfGridCell cell = row.cells[j];
      if (j == 0) {
        cell.stringFormat.alignment = PdfTextAlignment.center;
      }
      cell.style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
  }
  return grid;
}

//Create and row for the grid.
void addProducts(String empty, String productDescription, weight, vehicleType,
    PdfGrid grid) {
  PdfGridRow row = grid.rows.add();
  row.cells[0].value = empty;
  row.cells[1].value = productDescription;
  row.cells[2].value = weight;
  row.cells[4].value = vehicleType;
}

//Get the total amount.
double getTotalAmount(PdfGrid grid) {
  // double total = 0;
  // for (int i = 0; i < grid.rows.count; i++) {
  //   final String value = grid.rows[i].cells[grid.columns.count - 1].value;
  //   total += double.parse(value);
  // }
  return 222;
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

getBiltyInvoice(biltyNo, orderNo) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('POST',
      Uri.parse('https://staging-api.meribilty.com/api/get_invoice_for_bilty'));
  request.body = json.encode({"biltyNo": "$biltyNo", "orderNo": "$orderNo"});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Map responseJson = await json.decode(await response.stream.bytesToString());
  return responseJson;
}
