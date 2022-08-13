import 'dart:convert';

import 'package:meribiltyapp/Api%20Services/invite/My%20Team/myTeamModel.dart';
import 'package:http/http.dart' as http;
import 'package:meribiltyapp/constants/main_constants.dart';

Future<List<MyTeamModel>> fetchMyTeam()async{
  var headers = {
  'Content-Type': 'application/json'
};
Uri apiURl = Uri.parse('https://staging-api.meribilty.com/ppl/get_contact_persons');
var response =await http.post(apiURl, headers: headers, body: json.encode({
  "token": "${box.read('token')}"
}));
var responseBody = json.decode(response.body);
if(response.statusCode==200){
   var jsonString = response.body;
  return [myTeamModelFromJson(jsonString)];
}else{
  throw Exception('Failed to load data');
}

}