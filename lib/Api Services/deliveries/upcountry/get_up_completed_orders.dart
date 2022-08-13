import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:http/http.dart' as http;

Future fetchUpCompletedDeliveries() async {
  var headers = {'Content-Type': 'application/json'};

  Uri apiurl =
      Uri.parse('https://staging-api.meribilty.com/api/get_user_completed_orders');
  var response = await http.Client().post(apiurl,
      headers: headers, body: json.encode({"token": box.read('token')}));
  if (response.statusCode == 200) {
    var body = json.decode(response.body);
    print("Successfully fetched orders");
    // print(body['data']);
    return body['upcountry']['data'];
  } else {
    print(response.body);
    print("There is an error");
    throw Exception('Failed to load orders');
  }
}
