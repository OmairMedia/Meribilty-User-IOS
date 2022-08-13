import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:http/http.dart' as http;

Future acceptQoute(String orderNo, String vendor_phone) async {
  print("Quote Accept API IS RUNNING");
  var headers = {'Content-Type': 'application/json'};
  Uri apiurl =
      Uri.parse('https://staging-api.meribilty.com/ppl/user_accept_vendor_qoute');
  var response = await http.Client().post(apiurl,
      headers: headers,
      body: json.encode({
        "token": box.read('token'),
        "orderNo": orderNo,
        "vendor_phone": vendor_phone
      }));

  if (response.statusCode == 200) {
    var jsonString = jsonDecode(response.body);
    print(jsonString);
    // print(jsonString['message'] ?? jsonString['error']);
    return jsonString;
  } else {
    print(response.body);
    print("There is an error");
    throw Exception('Failed to accept');
  }
}
