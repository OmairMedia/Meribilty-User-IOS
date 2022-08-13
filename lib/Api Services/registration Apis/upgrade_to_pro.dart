import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:meribiltyapp/config/constants.dart';
import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/screens/home/home.dart';

upgradeToPro(
    {required String name,
    required String email,
    required String bussiness_name,
    required String bussiness_address,
    required String Ntn,
    required String landline,
    required owner,
    required String point_of_contact,
    required String cargo_volumne_per_month,
    required String credit_duration,
    required String credit_requirement_per_month,
    required context,
    required TextEditingController controller1,
    required TextEditingController controller2,
    required TextEditingController controller3,
    required TextEditingController controller4,
    required TextEditingController controller5,
    required TextEditingController controller6,
    required TextEditingController controller7,
    required TextEditingController controller8,
    required TextEditingController controller9,
    required TextEditingController controller10}) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST', Uri.parse('https://staging-api.meribilty.com/auth/pro/send_application'));
  request.body = json.encode({
    "token": "${box.read('token')}",
    "fullname": "$name",
    "email": "$email",
    "bussiness_name": "$bussiness_name",
    "bussiness_address": "$bussiness_address",
    "NTN": "$Ntn",
    "landline": "$landline",
    "owner": owner,
    "point_of_contact": "$point_of_contact",
    "cargo_volumne_per_month": "$cargo_volumne_per_month",
    "credit_duration": "$credit_duration",
    "credit_requirement_per_month": "$credit_requirement_per_month"
  });
  request.headers.addAll(headers);

  var response = await request.send();

  Map responseMap = await json.decode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    if (responseMap['status'] == true) {
      showProsubmitDialog(context);
    }
    if (responseMap['status'] == false) {
      print(responseMap['message']);
      var snackbar = SnackBar(
        content: Text(responseMap["message"]),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

    controller1.clear();
    controller2.clear();
    controller3.clear();
    controller4.clear();
    controller5.clear();
    controller6.clear();
    controller7.clear();
    controller8.clear();
    controller9.clear();
    controller10.clear();
    print(responseMap);
  } else {
    print(responseMap);
    print(response.reasonPhrase);
  }
}

showProsubmitDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "Done",
      style: TextStyle(color: Constants.Primary),
    ),
    onPressed: () {
      Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => Home()),
                (route) => false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Column(
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: Constants.Primary,
          size: 90,
        ),
        Text(
          "Application Submitted",
          style: Constants.heading3,
        )
      ],
    ),
    //  Container(
    //   child: Icon(Icons.check)
    // ),
    content: Text(
      "Our sales team will be in touch with you shortly, meanwhile you can use Meribilty without pro features",
      overflow: TextOverflow.clip,
      style: TextStyle(fontSize: 14, color: Color.fromARGB(66, 26, 22, 22)),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
