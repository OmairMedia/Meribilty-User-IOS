import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:http/http.dart' as http;
import 'package:meribiltyapp/widgets/loading.dart';

Future counterQoute(
    String orderNo, String amount, String vendor_phone, context) async {
  showloadingDialog("Sending Counter Offer", context);

  var headers = {'Content-Type': 'application/json'};
  Uri apiurl =
      Uri.parse('https://staging-api.meribilty.com/ppl/user_counters_vendor_qoute');
  var response = await http.Client().post(apiurl,
      headers: headers,
      body: json.encode({
        "token": box.read('token'),
        "orderNo": orderNo,
        "amount": amount,
        "vendor_phone": vendor_phone
      }));
  Navigator.pop(context);

  if (response.statusCode == 200) {
    var jsonString = jsonDecode(response.body);
    print(jsonString);
    // print(jsonString['message'] ?? jsonString['error']);
    return jsonString;
  } else {
    print(response.body);
    print("There is an error");
    throw Exception('Failed to accept');
  }
}
