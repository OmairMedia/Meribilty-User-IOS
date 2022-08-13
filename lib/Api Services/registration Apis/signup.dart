import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meribiltyapp/Api%20Services/registration%20Apis/otp_verification.dart';
import 'dart:convert';

import 'package:meribiltyapp/screens/authentication/checkotp.dart';
import 'package:meribiltyapp/screens/authentication/signupforuser.dart';
import 'package:meribiltyapp/widgets/loading.dart';

// import 'package:mariblity_rider/Sign_In&onboard/checkotp.dart';

SignUpUser(
    {required fullname,
    required phone,
    required email,
    required password,
    required pro,
    required context}) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('POST',
      Uri.parse('https://staging-api.meribilty.com/auth/user/send_register_otp'));
  request.body = json.encode({
    "fullname": "$fullname",
    "phone": "$phone",
    "email": "$email",
    "password": "$password",
    "pro": pro
  });
  request.headers.addAll(headers);
  showloadingDialog("Registering", context);
  http.StreamedResponse response = await request.send();
  Map responseMap = json.decode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
    if (responseMap['status'] == true) {
      print(responseMap);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => CheckOtp(ontap: () {}, isPro: pro,)));
    } else if (responseMap['status'] == false) {
      Navigator.pop(context);
      var snackBar = SnackBar(content: Text("${responseMap['error']}"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(responseMap);
    }
  } else {
    Navigator.pop(context);
    var snackBar =
        SnackBar(content: Text("${responseMap['errors'][0]['msg']}"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print(responseMap);
  }
} 
  
    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //     builder: (_) => CheckOtp(ontap: () {
    //           print("HELO WORLD");
            // })));

  
  // print(company_address);
  // print(company_name);
  // print(owner_email);
  // print(owner_phone);
  // print(account_manager_email);
  // print(do_cargo_movement_out_of_pak);
  // print("Ntn number is $NTN_number");
