import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

 cancellation_reason() async{
  final response =await http.get(Uri.parse('https://staging-api.meribilty.com/api/get_cancellation_reasons'));
  var data = jsonDecode(response.body);
  if(response.statusCode == 200){
    if(data['status'] == true){
      return(data);
    }
    else{
      print(data["message"]);
    }
  }
  else{
    print('There is a error');
  }
}