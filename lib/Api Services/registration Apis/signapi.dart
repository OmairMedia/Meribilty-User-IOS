import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:meribiltyapp/screens/authentication/passwordcheck.dart';
import 'package:meribiltyapp/screens/authentication/passwordset.dart';
import 'dart:convert';

import 'package:meribiltyapp/screens/authentication/signin.dart';
import 'package:meribiltyapp/screens/authentication/signupcheck.dart';
import 'package:meribiltyapp/screens/authentication/validate_invited_user_otp.dart';
import 'package:meribiltyapp/widgets/loading.dart';

signin(phonenum, context) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST', Uri.parse('https://staging-api.meribilty.com/api/user_login_1'));
  request.body = json.encode({"phone": "$phonenum"});
  request.headers.addAll(headers);
  showloadingDialog("Authenticating", context);
  http.StreamedResponse response = await request.send();
  Map responseMap = json.decode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
    print(responseMap);

    print(responseMap['status']);

    if (responseMap['active'] == true) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => PasswordCheck(
                phonenum: phonenum,
              )));
    } else if (responseMap['active'] == false) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => ValidateInvitedUserOtp(phone: phonenum,)
          // PasswordSet(
          //       phoneNumber: phonenum.toString(),
          //     )
              ));
    }
    if (responseMap['status'] == false &&
        responseMap["error"] == "User Not Found !") {
      var snackbar = SnackBar(
        content: Text('User Not Found !'),
      );
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  } else {
     Navigator.pop(context);
    print(response.reasonPhrase);
    print(responseMap);
  }
}
