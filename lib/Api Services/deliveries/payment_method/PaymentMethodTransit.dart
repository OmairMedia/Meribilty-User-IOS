import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/screens/ppl/select_contact_person.dart';

addPaymentMethod(
    {required orderNo,
    required paymentMethod,
    required pointOfpayment,
    required functionToRun,
    required context}) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('POST',
      Uri.parse('https://staging-api.meribilty.com/ppl/user_add_payment_method'));
  request.body = json.encode({
    "token": "${box.read("token")}",
    "orderNo": "$orderNo",
    "payment_method": "$paymentMethod",
    "point_of_payment": "$pointOfpayment"
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Map responseMap = json.decode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(responseMap);
    if (responseMap['status'] == true) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SelectContactPerson(
                    OrderNo: orderNo,
                    functionToRun: functionToRun,
                  )));
      Get.snackbar("Successful", "Payment Method Added Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
          icon: Icon(Icons.check_circle, color: Colors.white));
    } else {
      Get.snackbar("Error", "${responseMap['error']}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          icon: Icon(Icons.check_circle, color: Colors.white));
    }
  } else {
    print(responseMap);
    print(response.reasonPhrase);
  }
}
