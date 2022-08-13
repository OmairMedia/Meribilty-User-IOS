import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_deliveries.dart';
import 'package:meribiltyapp/screens/home/home.dart';

// import 'package:meribiltyapp/screens/authentication/signin.dart';
// import 'package:meribiltyapp/widgets/loading.dart';

giveRatings(ratingCmnts, starRating,orderNo,context) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST', Uri.parse('https://staging-api.meribilty.com/api/user_give_rating'));

  request.body =
      json.encode({"token": box.read('token'), "orderNo": "${orderNo}", "rating": starRating ,"experience": "${ratingCmnts}" });
  request.headers.addAll(headers);
  //showloadingDialog("Loading", context);
  http.StreamedResponse response = await request.send();
  Map responseMap = json.decode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
    if (responseMap['status'] == true) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => MyDeliveries()));
      var snackBar = SnackBar(content: Text('${responseMap['message']}'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      var snackBar = SnackBar(content: Text('${responseMap['message']}'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  } else {
    // Navigator.pop(context);
    print(responseMap);
    print(response.reasonPhrase);
  }
}