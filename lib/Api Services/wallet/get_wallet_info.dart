import 'dart:convert';

import 'package:meribiltyapp/Api%20Services/wallet/get_wallet_model.dart';
import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:http/http.dart' as http;
Future fetchwallet() async {
  var headers = {'Content-Type': 'application/json'};

  Uri apiurl =
      Uri.parse('https://staging-api.meribilty.com/api/get_wallet');
  var response = await http.Client().post(apiurl,
      headers: headers, body: json.encode({"token": storage.getItem('token')}));
  if (response.statusCode == 200) {
    var jsonString = response.body;
    print("Successfully fetched wallet");
    print(response.body);

    return [jsonString];
  } else {
    print(response.body);
    print("There is an error");
    throw Exception('Failed to load wallet');
  }
}


Future fetchwalletData() async {
  var headers = {'Content-Type': 'application/json'};

  Uri apiurl =
      Uri.parse('https://staging-api.meribilty.com/api/get_wallet');
  var response = await http.Client().post(apiurl,
      headers: headers, body: json.encode({"token": box.read('token')}));
  if (response.statusCode == 200) {
    var jsonString = response.body;
    print("Successfully fetched wallet");
    Map responseMap = await json.decode(jsonString);

    return responseMap;
  } else {
    print(response.body);
    print("There is an error");
    throw Exception('Failed to load wallet');
  }
}
