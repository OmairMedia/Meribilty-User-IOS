import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/screens/home/home.dart';
import 'package:meribiltyapp/widgets/custominputfornum.dart';

userInvitesAUser({
  Function? functionToRun,
  required context,
  required name,
  required email,
  required phone,
  required TextEditingController namec,
  required TextEditingController emailc,
  required TextEditingController phonec,
}) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST', Uri.parse('https://staging-api.meribilty.com/ppl/user_invites_a_user'));
  request.body = json.encode({
    "token": "${box.read('token')}",
    "fullname": "$name",
    "email": "$email",
    "phone": "$phone"
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Map responseMap = await json.decode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(responseMap);
    if (responseMap['status'] == true) {
      namec.text = '';
      emailc.text = '';
      phonenumberforinput = '';
      Get.snackbar("Success", "${responseMap['message']}",
          colorText: Colors.green);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> Home()));
    }else if(responseMap['status'] == false){
      Get.snackbar("Error",  "${responseMap['error']}",
          colorText: Colors.red);
    }
    
  } else {
    print(response.reasonPhrase);
    print(responseMap);
  }
}
