import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meribiltyapp/screens/ppl/select_payment_method.dart';

addAddressInfo(
    orderNo,
    fromName,
    fromAddress,
    fromCity,
    fromProvince,
    fromCountry,
    toName,
    toAddress,
    toCity,
    toProvince,
    toCountry,
    context,
    functionToRun) async {
  // print({
  //   "orderNo": "$orderNo",
  //   "from": {
  //     "name": "$fromName",
  //     "address": "$fromAddress",
  //     "city": "$fromCity",
  //     "province": "$fromProvince",
  //     "country": "$fromCountry"
  //   },
  //   "to": {
  //     "name": "$toName",
  //     "address": "$toAddress",
  //     "city": "$toCity",
  //     "province": "$toProvince",
  //     "country": "$toCountry"
  //   }
  // });
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST', Uri.parse('https://staging-api.meribilty.com/ppl/add_more_address_info'));
  request.body = json.encode({
    "orderNo": "$orderNo",
    "from": {
      "name": "$fromName",
      "address": "$fromAddress",
      "city": "$fromCity",
      "province": "$fromProvince",
      "country": "$fromCountry"
    },
    "to": {
      "name": "$toName",
      "address": "$toAddress",
      "city": "$toCity",
      "province": "$toProvince",
      "country": "$toCountry"
    }
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Map responseMap = json.decode(await response.stream.bytesToString());
  print(responseMap);
  if (response.statusCode == 200) {
    if (responseMap['status'] == true) {
      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectPaymentMethod(
                                orderNo: orderNo,
                                functionToRun: functionToRun,
                              )));
    }
  } else {
    print(response.reasonPhrase);
  }
}
