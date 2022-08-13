import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> updateUserProfile(
    String fullname, String email) async {
  var headers = {'Content-Type': 'application/json'};
  Uri apiurl = Uri.parse('https://staging-api.meribilty.com/api/update_user_profile');
  var response = await http.Client().post(apiurl,
      headers: headers,
      body: json.encode(
          {"token": box.read('token'), "fullname": fullname, "email": email}));

  if (response.statusCode == 200) {
    var jsonString = jsonDecode(await response.body);
    print(jsonString['message'] ?? jsonString['error']);
    return jsonString;
  } else {
    print(response.body);
    print("There is an error");
    throw Exception('Failed to update');
  }
}
