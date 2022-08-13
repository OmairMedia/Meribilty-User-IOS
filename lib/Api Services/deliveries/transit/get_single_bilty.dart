import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';

Future getSingleBilty(biltyNo) async {
  var headers = {'Content-Type' : 'application/json'};
  Uri apiUrl = Uri.parse('https://staging-api.meribilty.com/ppl/get_single_bilty');
  var response = await http.post(apiUrl,
  headers: headers,
  body: jsonEncode({'token' : '${box.read('token')}',"biltyNo":"$biltyNo"}),
  );
  var data = jsonDecode(response.body);
  if (response.statusCode == 200){
   return data['data'];
  }
  else{
    Exception('No such api exsist');
  }

}