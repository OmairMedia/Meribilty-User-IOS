import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meribiltyapp/Api%20Services/notifications/save_token.dart';
import 'package:meribiltyapp/Api%20Services/wallet/wallet_controller_getx.dart';
import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/screens/home/home.dart';
import 'package:meribiltyapp/screens/ppl/bussiness_pro_form.dart';

otpverification(context, pin, bool pro) async {
  print(pro);
  print("PIN IS $pin");
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('POST',
      Uri.parse('https://staging-api.meribilty.com/auth/user/register_after_otp'));
  // Navigator.pop(context);
  request.body = json.encode({"otp": "$pin"});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Map responseMap = json.decode(await response.stream.bytesToString());
  GetWalletController getWalletController = Get.put(GetWalletController());

  if (response.statusCode == 200) {
    if (responseMap['status'] == false &&
        responseMap['message'] == 'Verification Failed !') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Verification Failed !',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
      // Navigator.pop(context);
    } else if (responseMap['status'] == false) {
      var snackBar =
          SnackBar(content: Text("There is an error, please try again later"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    if (responseMap['status'] == true) {
      box.write('apiToken', '${responseMap['token']}');
      storage.setItem('apiToken', '${responseMap['token']}');
      try {
        UserCredential userloginStatus = await FirebaseAuth.instance
            .signInWithCustomToken(responseMap['token']);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
      FirebaseAuth.instance.authStateChanges().listen((User? user)async {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          FirebaseAuth.instance.currentUser
              ?.getIdToken(true)
              .then((idToken) => {box.write('token', '$idToken')});
          getWalletController.fetchWallet();
          print('User is signed in!');
          if (responseMap['profile'] != null) {
            box.write('fullname', responseMap['profile']['fullname']);
            box.write('phone', responseMap['profile']['phone']);
            box.write('email', responseMap['profile']['email']);
            box.write('type', responseMap['profile']['type']);
            storage.setItem('fullname', responseMap['profile']['fullname']);
            name = responseMap['profile']['fullname'];
           storage.setItem('phone', responseMap['profile']['phone']);
           storage.setItem('email', responseMap['profile']['email']);
           storage.setItem('type', responseMap['profile']['type']);
            // Get the token each time the application loads
          String? fcm_token = await FirebaseMessaging.instance.getToken();

          // Save the initial token to the database
          await saveTokenToDatabase(fcm_token);
            
          }
          if (pro) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => ProBussinessForm()),
                (route) => false);
          } else {
           Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => Home()),
                (route) => false);
          }
          // get idToken of user

        }
      });
    }
    //print(responseMap);
    print(responseMap);
  } else {
    // Navigator.pop(context);
    print(response.reasonPhrase);
    print(responseMap);
  }
}
