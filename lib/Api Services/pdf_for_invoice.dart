import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:google_directions_api/google_directions_api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:meribiltyapp/Api%20Services/pdf_formar_for_bilty.dart';
import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
//Read image data.
// final Uint8List imageData = File("assets/logo1").readAsBytesSync();
//Load the image using PdfBitmap.

Future<void> downloadOrderInvoice(
    {required customerId,
    required origin,
    required destination,
    required sender,
    required senderAddress,
    required receiver,
    required invoiceNo,
    required bookingNumber,
    required date,
    required material,
    required weight,
    required amount,
    required fuelAndOther,
    required recieverAddress,
    required vehicleType,
    required vehicleRegistration,

    required insurance,
    required invoiceAmount,
    required serviceCharges,
    required salesTax,
    required totalInWords,
    
    
    }) async {
  final ByteData imageData = await rootBundle.load('assets/logo1.png');
  final Uint8List img = imageData.buffer.asUint8List();
  //Create a PDF document.
  final PdfDocument document = PdfDocument();
  //Add page to the PDF
  final PdfPage page = document.pages.add();
  //Get page client size
  final Size pageSize = page.getClientSize();
  //Draw rectangle
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
      pen: PdfPen(PdfColor(142, 170, 219, 255)));
  //Generate PDF grid.
  final PdfGrid grid = getGrid(weight, material, amount,invoiceAmount,
      serviceCharges,
      salesTax,
      totalInWords,
      insurance,
      fuelAndOther
      );
  //Draw the header section by creating text element
  final PdfLayoutResult? result = drawHeader(
      page,
      pageSize,
      grid,
      img,
      invoiceNo,
      bookingNumber,
      date,
      customerId,
      origin,
      destination,
      sender,
      senderAddress,
      recieverAddress,
      weight,
      vehicleRegistration,
      vehicleType,
      material,
      receiver,
      invoiceAmount,
      serviceCharges,
      salesTax,
      totalInWords
      
      
      
      );
  //Draw grid
  drawGrid(page, grid, result!, amount);
      //add wording ammount
  addInwordAmount(page, pageSize, totalInWords);
  //Add invoice footer
  drawFooter(page, pageSize);
  //Save and launch the document
  final List<int> bytes = document.save();
  //Dispose the document.
  document.dispose();
  //Save and launch file.
  saveAndLaunchFile(bytes, "order${invoiceNo}invoice.pdf");
}
void addInwordAmount(PdfPage page, Size pageSize, totalInWords) {
  page.graphics.drawString(
      'Amount in words: Pakistani Rupee                    $totalInWords', PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(30, pageSize.height - 280, 0, 0));

}
//Draws the invoice header
PdfLayoutResult? drawHeader(
    PdfPage page,
    Size pageSize,
    PdfGrid grid,
    image,
    invoiceNum,
      bookingNumber,
      date,
      customerId,
      origin,
      destination,
      sender,
      senderAddress,
      recieverAddress,
      weight,
      vehicleRegistration,
      vehicleType,
      material,
      receiver,
      invoiceAmount,
      serviceCharges,
      salesTax,
      totalInWords

      
    ) {
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

  page.graphics.drawRectangle(
    bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
    // brush: PdfSolidBrush(PdfColor(91, 126, 215, 255))
  );

  final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
  //Draw string
  //Create data foramt and convert it to text.
  final DateFormat format = DateFormat.yMMMMd('en_US');
  final String invoiceNumber =
      'Invoice Number: $invoiceNum\r\n\r\nBooking Number: $bookingNumber \r\n\r\nDate: $date \r\n\r\nVehicle Registration:  $vehicleRegistration\r\n\r\nVehicle Type:  $vehicleType\r\n\r\nWeight (kg/Ton): $weight Tons';
  ;
  final Size contentSize = contentFont.measureString(invoiceNumber);
  final String address =
      'Customer ID: $customerId\r\n\r\nFrom(Origin): $origin \r\n\r\nTo(Destination): $destination \r\n\r\nCustomer Name: $sender \r\n\r\nCustomer Address: $senderAddress \r\n\r\nReceiver Name: $receiver \r\n\r\n Receiver Address: $recieverAddress \r\n\r\nAdditional description: $material ';

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
  // page.graphics.drawString(
  //     'Grand Total: ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} PKR',
  //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
  //     bounds: Rect.fromLTWH(quantityCellBounds.left, result.bounds.bottom + 10,
  //         page.getClientSize().width, page.getClientSize().height));
  page.graphics.drawString(getTotalAmount(grid).toString(),
      PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(
          totalPriceCellBounds.left, result.bounds.bottom + 10, 10, 10));
}

String noteTextInvoice =
    "1.	This is a system generated receipt and does not require any signatures.\r\n\r\n2.	All payments are made to Meribilty (Private) Limited                    \r\n\r\n3.	Meribilty (Private) Limited FBR NTN #                            \r\n\r\n4.	All tax deducted is deposited to governmental tax authorities          ";

//Draw the invoice footer data.
void drawFooter(PdfPage page, Size pageSize) {
  page.graphics.drawString(
      "Note : ", PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, pageSize.height - 160, 0, 0));
  //Added 30 as a margin for the layout
  page.graphics.drawString(
      noteTextInvoice, PdfStandardFont(PdfFontFamily.helvetica, 9),
      bounds: Rect.fromLTWH(20, pageSize.height - 140, 0, 0));

  PdfTextWebLink(
          url: 'http://www.meribilty.com/termsofservice',
          text:
              '5.	For terms and conditions please refer www.meribilty.com/termsofservice',
          font: PdfStandardFont(PdfFontFamily.helvetica, 9),
          format: PdfStringFormat())
      .draw(
          page,
          Offset(
            20,
            pageSize.height - 58,
          ));
}

//Create PDF grid and return
PdfGrid getGrid(material, weight, amount,invoiceAmount,
      serviceCharges,
      salesTax,
      totalInWords,
      insurance,fuelAndOther
      ) {
  //Create a PDF grid
  final PdfGrid grid = PdfGrid();
  //Secify the columns count to the grid.
  grid.columns.add(count: 5);
  //Create the header row of the grid.
  final PdfGridRow headerRow = grid.headers.add(1)[0];
  // returnRow() {
  //   for (var i = 0; i == 3; i++) {
  //    addProducts('', "$weight", '$material', "$amount", grid);
  //   }
  // }
  //Set style
  headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
  headerRow.style.textBrush = PdfBrushes.white;
  headerRow.cells[0].value = '';
  headerRow.cells[1].value = 'Description Of Goods';
  // headerRow.cells[2].value = 'Weight (Kg/Ton)';
  headerRow.cells[4].value = ' Amount PKR';
// Here weight is beeing used as material and material is beeing used as weight so sorry for fucking your mind
 addProducts('', "Fuel and Transit Expense", '', '$fuelAndOther', grid);
  addProducts('', "Service Charges", '', '$serviceCharges', grid);
  addProducts('', "Sales Tax ", '', '$salesTax', grid);
  addProducts('', "Insurance", '', '$insurance', grid);
  addProducts('', "", 'Grand Total', '$amount PKR', grid);
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
void addProducts(
    String empty, String productDescription, weight, freight, PdfGrid grid) {
  PdfGridRow row = grid.rows.add();
  row.cells[0].value = empty;
  row.cells[1].value = productDescription;
  row.cells[2].value = weight;
  row.cells[4].value = "$freight ";
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

getInvoiceData(orderNo) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST', Uri.parse('https://staging-api.meribilty.com/api/get_invoice_for_order'));
  request.body =
      json.encode({"token": "${box.read('token')}", "orderNo": "$orderNo"});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Map responseJson = await json.decode(await response.stream.bytesToString());
  return responseJson;
}
