import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';

inviteFriend(phoneNumber, context) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST', Uri.parse('https://staging-api.meribilty.com/api/invite_friends'));
  request.body =
      json.encode({"token": "${box.read('token')}", "phone": "$phoneNumber"});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Map responseMap = await json.decode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(responseMap);
    if (responseMap['status'] == true &&
        responseMap['message'] == "User has been invited !") {
      var snackBar = SnackBar(content: Text('${responseMap['message']}'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    }
  } else {
    print(responseMap);
    print(response.reasonPhrase);
  }
}