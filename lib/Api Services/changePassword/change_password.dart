import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';

Future UserChangePassword(context,oldpassword,newpassword) async {
  var headers = {'Content-Type': 'application/json'};
  Uri apiUrl =
      Uri.parse("https://staging-api.meribilty.com/api/change_user_password");
  var response = await http.post(
    apiUrl,
    headers: headers,
    body: jsonEncode({"token": "${box.read('token')}","oldpassword":"$oldpassword","newpassword":"$newpassword"}),
  );
  var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    print(data);
   if(data['status'] == false){
    Get.snackbar("Error", "${data['error']}",backgroundColor: Colors.red);
   }
   else{
     Get.snackbar("Error", "${data['message']}",backgroundColor: Colors.green);
     Navigator.pop(context);
   }
  } else {
    Exception('No such api exsist');
  }
}
