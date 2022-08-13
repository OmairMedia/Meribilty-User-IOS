import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/screens/ppl/add_address_info.dart';
import 'package:meribiltyapp/screens/ppl/select_payment_method.dart';
import 'package:meribiltyapp/widgets/loading.dart';

uploadUpcountryDocuments(detail_packing_list,billOfLanding,
    orderNo, context, bool frombiltypage,
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
    detail_packing_list,
  ].where((element) => element != null).toList().length;

  print(docLength);
  showloadingDialog("Uploading Take Time", context);
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://staging-api.meribilty.com/ppl/user_upload_upcountry_documents'));
  request.fields
      .addAll({'token': '${box.read("token")}', 'orderNo': '$orderNo', "docLength": '$docLength'});
  if (detail_packing_list != null) {
    request.files.add(
        await http.MultipartFile.fromPath('detail_packing_list', '$detail_packing_list'));
  }
  if (billOfLanding != null) {
    request.files.add(
        await http.MultipartFile.fromPath('bill_of_landing', '$billOfLanding'));
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
