import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:meribiltyapp/Api%20Services/ppl/acceptOrder.dart';

import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_deliveries.dart';

ManageByTeamMember(
    {required orderNo,
    required phone,
    required context,
    required name,
    required Function functionToRun}) async {
  // print(orderNo);

  // acceptOrder(orderNo: '$orderNo', context: context);
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://staging-api.meribilty.com/ppl/user_add_contact_person_to_request'));
  request.body = json.encode(
    {
      "token": "${box.read('token')}",
      "orderNo": "$orderNo",
      "phone": "${phone}"
    },
  );
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Map responseMap = json.decode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(responseMap);
    print("YAHA PAR AAGAY");
    acceptOrder(orderNo: orderNo, context: context);
    if (responseMap['status'] == true) {
      Get.snackbar("Sucessful", "Set Manage by $name",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyDeliveries()));
    } else if (responseMap['status'] == false) {
      print(responseMap);
      Get.snackbar("Error", "${responseMap['error']}",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  } else {
    print(response.reasonPhrase);
  }
}
