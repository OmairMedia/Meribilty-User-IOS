import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:meribiltyapp/screens/authentication/passwordset.dart';
import 'package:meribiltyapp/widgets/loading.dart';

validateInvitedUserOtp(context, otp, phone) async {
  var headers = {'Content-Type': 'application/json'};
  showloadingDialog("Loading", context);
  var request = http.Request('POST',
      Uri.parse('https://staging-api.meribilty.com/api/validate_invited'));
  request.body = json.encode({"otp": otp});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Map responseMap = json.decode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
    if(responseMap['status']==false&&responseMap['message']=='Verification Failed !'){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Verification Failed !',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ));
           Navigator.pop(context);
    }
    print(responseMap);
    if (responseMap['status'] == true) {
      Navigator.pushReplacement(      
          context,
          MaterialPageRoute(
              builder: (_) => PasswordSet(phoneNumber: '$phone')));
    }
  } else {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Verification Failed !',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    print(response.reasonPhrase);
  }
}
