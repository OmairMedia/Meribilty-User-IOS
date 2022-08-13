import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';


getNotifications() async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST', Uri.parse('https://staging-api.meribilty.com/api/get_notifications'));
  request.body = json.encode({"token": "${box.read("token")}"});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Map responseMap = json.decode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(responseMap);
    return responseMap;
  } else {
    print(response.reasonPhrase);
  }
}

getNotificationsRead(context, NotificationID) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST', Uri.parse("https://staging-api.meribilty.com/api/read_unread_notification"));
  request.body = json.encode({"token": "${box.read("token")}","notificationID": "$NotificationID"});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Map responseMap = json.decode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
   // print(responseMap['data']);
     Get.snackbar(
        "Notification", "Notifications Read Successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2));
  } else {
    print(response.reasonPhrase);
  }
}
