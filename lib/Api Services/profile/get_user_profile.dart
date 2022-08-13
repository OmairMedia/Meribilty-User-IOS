import 'dart:convert';
import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:http/http.dart' as http;

fetchUserProfile() async {
  var headers = {'Content-Type': 'application/json'};

  Uri apiurl = Uri.parse('https://staging-api.meribilty.com/api/get_user_profile');
  var response = await http.post(apiurl,
      headers: headers, body: json.encode({"token": box.read('token')}));
  var result = await json.decode(response.body);
  if (response.statusCode == 200) {
    print("Successfully fetched profile");

    return result;
  } else {
    print(response.body);
    print("There is an error");
    throw Exception('Failed to load staff');
  }
}
