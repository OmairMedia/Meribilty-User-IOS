import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';

Future getWaitingforAdminApi() async {
  var headers = {'Content-Type': 'application/json'};
  Uri apiUrl =
      Uri.parse('https://staging-api.meribilty.com/api/get_user_payment_approval_awaiting_orders');
  var response = await http.post(
    apiUrl,
    headers: headers,
    body: jsonEncode({"token": "${box.read('token')}"}),
  );
  var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    print(response);
   if(data['status'] == true){
     print(data['data']);
     return(data['data']);
   } else{
     print("There is an error");
   }
  } else {
    Exception('No such api exsist');
  }
}
