import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:meribiltyapp/Api%20Services/notifications/save_token.dart';
import 'package:meribiltyapp/Api%20Services/registration%20Apis/always_login.dart';
import 'package:meribiltyapp/Api%20Services/wallet/wallet_controller_getx.dart';
import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/screens/home/home.dart';
import 'package:meribiltyapp/screens/home/homebackup.dart';
import 'package:meribiltyapp/screens/pro/pro_home.dart';
import 'package:meribiltyapp/widgets/loading.dart';

signinapi2(context, phonenum, password) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST', Uri.parse('https://staging-api.meribilty.com/api/user_login_2'));
  request.body = json.encode({"phone": "$phonenum", "password": "$password"});
  request.headers.addAll(headers);
  showloadingDialog("Signing in", context);
  http.StreamedResponse response = await request.send();
  Map responseMap = json.decode(await response.stream.bytesToString());
  GetWalletController _walletController = Get.put(GetWalletController());
  if (response.statusCode == 200) {
    print(responseMap);

    if (responseMap['status'] == true) {
      box.write('userType', responseMap['type']);
      storage.setItem('userType', responseMap['type']);
      try {
        box.write('apiToken', '${responseMap['token']}');
        storage.setItem('apiToken', '${responseMap['token']}');
        UserCredential userloginStatus = await FirebaseAuth.instance
            .signInWithCustomToken(responseMap['token']);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.pop(context);
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }

      await FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          // get idToken of user
          await FirebaseAuth.instance.currentUser
              ?.getIdToken(true)
              .then((idToken) => {box.write('token', '$idToken')});
          print('${box.read('token')}');
          Timer.periodic(Duration(minutes: 57), (timer) {
            always_login();
          });
          if (responseMap['profile'] != null) {
            box.write('fullname', responseMap['profile']['fullname']);
            box.write('phone', responseMap['profile']['phone']);
            box.write('email', responseMap['profile']['email']);
            box.write('type', responseMap['profile']['type']);
            name = responseMap['profile']['fullname'];
            storage.setItem('fullname', responseMap['profile']['fullname']);
            storage.setItem('phone', responseMap['profile']['phone']);
            storage.setItem('email', responseMap['profile']['email']);
            storage.setItem('type', responseMap['profile']['type']);
          }

          // Get the token each time the application loads
          String? fcm_token = await FirebaseMessaging.instance.getToken();

          // Save the initial token to the database
          await saveTokenToDatabase(fcm_token);

          // Any time the token refreshes, store this in the database too.
          FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);

          if (responseMap['type'] == 'user') {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) => Home()), (route) => false);
          } else if (responseMap['type'] == 'pro') {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) => ProHome()), (route) => false);
          }

          _walletController.fetchWallet();
          print('User is signed in!');
        }
      });
    } else if (responseMap['status'] == false &&
        responseMap['message'] == "Password Is Incorrect !") {
      Fluttertoast.showToast(msg: responseMap['message']);
      Navigator.pop(context);
    }
  } else {
    print("Response Time Out");
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Network Error")));
    Navigator.pop(context);
    print(response.reasonPhrase);
  }
}
