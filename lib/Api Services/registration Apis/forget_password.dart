import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meribiltyapp/screens/authentication/otpverificationfor_forgerpassword.dart';
import 'package:meribiltyapp/widgets/loading.dart';

forgetPassword(phoneNumber, context) async {
  showloadingDialog("Loading", context);
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('POST',
      Uri.parse('https://staging-api.meribilty.com/api/user_app_forgot_password'));
  request.body = json.encode({"phone": '$phoneNumber'});
  request.headers.addAll(headers);

  var response = await http.post(
      Uri.parse('https://staging-api.meribilty.com/api/user_app_forgot_password'),
      headers: headers,
      body: json.encode({"phone": '$phoneNumber'}));
  var jsonResponse = json.decode(response.body.toString());

  if (response.statusCode == 200) {
    print(jsonResponse['status']);
    if (jsonResponse['status'] == true) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => CheckOtpforforgetpassword()));
    }
//  Map responseMap = json.decode(await response.stream.bytesToString());
  } else {
    Navigator.pop(context);
    print(response.reasonPhrase);
  }
}
