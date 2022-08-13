import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/screens/ppl/add_address_info.dart';
import 'package:meribiltyapp/screens/ppl/select_payment_method.dart';
import 'package:meribiltyapp/widgets/loading.dart';

uploadTransitDocuments(billOfLanding, invoice, gd, demand_letter,
    packaging_list, orderNo, context, vendor_phone,vendor_name, bool frombiltypage,
    {functionToRun}) async {
  // print([
  //   billOfLanding,
  //   invoice,
  //   gd,
  //   demand_letter,
  //   packaging_list,
  // ]);
  print(orderNo);
  var docLength = [
    billOfLanding,
    invoice,
    gd,
    demand_letter,
    packaging_list,
  ].where((element) => element != null).toList().length;

  print(docLength);
  showloadingDialog("Uploading Take Time", context);
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://staging-api.meribilty.com/ppl/user_upload_transit_cargo_documents'));
  request.fields
      .addAll({'token': '${box.read("token")}', 'orderNo': '$orderNo', "docLength": '$docLength', "vendor_phone": '$vendor_phone', "vendor_name": '$vendor_name'});	
  if (billOfLanding != null) {
    request.files.add(
        await http.MultipartFile.fromPath('bill_of_landing', '$billOfLanding'));
  }
  if (invoice != null) {
    request.files.add(await http.MultipartFile.fromPath('invoice', '$invoice'));
  }
  if (gd != null) {
    request.files.add(await http.MultipartFile.fromPath('gd', '$gd'));
  }
  if (demand_letter != null) {
    request.files.add(
        await http.MultipartFile.fromPath('demand_letter', '$demand_letter'));
  }
  if (packaging_list != null) {
  request.files.add(
      await http.MultipartFile.fromPath('packaging_list', '$packaging_list'));

  }
  print("sending the request");
  http.StreamedResponse response = await request.send();
  print("request sent");
  var responseMap = json.decode(await response.stream.bytesToString());
  print(responseMap);
  if (response.statusCode == 200) {
    if (responseMap['status'] == true) {
      print(responseMap);
      Fluttertoast.showToast(msg: responseMap['message']);
      frombiltypage
          ? Navigator.pop(context)
          : Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>AddAddressInfo(orderNo:orderNo,
                  functionToRun: functionToRun)));
          // Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => SelectPaymentMethod(
          //               orderNo: orderNo,
          //               functionToRun: functionToRun,
          //             )));
    }
  } else {
    Navigator.pop(context);
    print(responseMap);
    print(response.reasonPhrase);
  }
}
