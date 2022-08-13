import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:meribiltyapp/config/constants.dart';
import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/screens/home/home.dart';
//import 'package:meribiltyapp/screens/home/home.dart';

cancelOrder({
  required orderNo,
  context,
}) async {
  print("Get in ACcept Orders $orderNo");
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST', Uri.parse('https://staging-api.meribilty.com/ppl/order_reject_2'));
  request.body =
      json.encode({"token": "${box.read('token')}", "orderNo": "$orderNo"});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Map responseMap = json.decode(await response.stream.bytesToString());
  //print(responseMap);
  if (response.statusCode == 200) {
    //print(responseMap);
    if (responseMap['status'] == true) {
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Home()));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>Home()), (route) => false);
      Get.snackbar("Successful", "Order Cancelled Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
          icon: Icon(Icons.check_circle, color: Colors.white));

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const Home()),
      // );
    } else {
      Get.snackbar("Error", "${responseMap['error']}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          icon: Icon(Icons.check_circle, color: Colors.white));
    }
    //print(responseMap);
  } else {
    print(responseMap);
    print(response.reasonPhrase);
  }
}
