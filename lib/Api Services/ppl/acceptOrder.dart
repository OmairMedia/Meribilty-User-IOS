import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:meribiltyapp/config/constants.dart';
import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';

acceptOrder({
  required orderNo, 
required context}) async {
  print("GEt in ACcept Orders $orderNo");
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST', Uri.parse('https://staging-api.meribilty.com/ppl/order_accept'));
  request.body =
      json.encode({"token": "${box.read('token')}", "orderNo": "$orderNo"});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Map responseMap = json.decode(await response.stream.bytesToString());
  print(responseMap);
  if (response.statusCode == 200) {
    print(responseMap);
    if (responseMap['status'] == true) {
      Get.snackbar("Successful", "Order Accepted Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          duration: Duration(seconds: 5),
          icon: Icon(Icons.check_circle, color: Colors.white));
    } 
    // else {
    //   Get.snackbar("Error", "${responseMap['error']}",
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: Colors.red,
    //       duration: Duration(seconds: 2),
    //       icon: Icon(Icons.check_circle, color: Colors.black));
    // }
    print(responseMap);
  } else {
    print(responseMap);
    print(response.reasonPhrase);
  }
}

showsAcceptedDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "Done",
      style: TextStyle(color: Constants.Primary),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Column(
      children: [
        
        Icon(
          Icons.check_circle_rounded,
          color: Constants.Primary,
          size: 90,
        ),
        Text(
          "Order Accepted",
          style: Constants.heading3,
        )
      ],
    ),
    //  Container(
    //   child: Icon(Icons.check)
    // ),
    content: Text(
      "Let's get going,",
      overflow: TextOverflow.clip,
      style: TextStyle(fontSize: 14, color: Color.fromARGB(66, 26, 22, 22)),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
