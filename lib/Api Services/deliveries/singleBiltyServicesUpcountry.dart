import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';

Future getSingleBiltyTransitApi(biltyNo) async {
  print("function running");
  var headers = {'Content-Type': 'application/json'};
  Uri apiUrl =
      Uri.parse('https://staging-api.meribilty.com/api/get_single_bilty_transit');
  var response = await http.post(
    apiUrl,
    headers: headers,
    body: jsonEncode({'token': '${box.read('token')}', "biltyNo": "$biltyNo"}),
  );
  var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    print(data);
    return data['data'];
  } else {
    Exception('No such api exsist');
  }
}


Future getSingleBiltyUpcountryApi(biltyNo) async {
  print("function running");
  var headers = {'Content-Type': 'application/json'};
  Uri apiUrl =
      Uri.parse('https://staging-api.meribilty.com/api/get_single_bilty_upcountry');
  var response = await http.post(
    apiUrl,
    headers: headers,
    body: jsonEncode({'token': '${box.read('token')}', "biltyNo": "$biltyNo"}),
  );
  var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    print(data);
    return data['data'];
  } else {
    Exception('No such api exsist');
  }
}

