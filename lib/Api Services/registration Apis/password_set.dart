import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meribiltyapp/screens/authentication/signin.dart';
import 'package:meribiltyapp/widgets/loading.dart';

setpassword(phonenumber, password, context) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST', Uri.parse('https://staging-api.meribilty.com/api/user_app_new_password'));

  request.body =
      json.encode({"phone": "$phonenumber", "password": "$password"});
  request.headers.addAll(headers);
  showloadingDialog("Loading", context);
  http.StreamedResponse response = await request.send();
  Map responseMap = json.decode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
    if (responseMap['status'] == true) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => SignIn()));
      var snackBar = SnackBar(content: Text('${responseMap['message']}'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {}
  } else {
    Navigator.pop(context);
    print(responseMap);
    print(response.reasonPhrase);
  }
}
