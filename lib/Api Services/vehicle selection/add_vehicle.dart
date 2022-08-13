import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:meribiltyapp/Api%20Services/vehicle%20selection/get_vehicle_service_with_getx.dart';
import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';

addVehicle(
    {required type,
     option,
    required vehicle_quantity,
    required weight,
    required material,
     option_quantity,
    context}) async {
  GetVehicleController _getVehicleController = Get.put(GetVehicleController());
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST', Uri.parse('https://staging-api.meribilty.com/api/add_vehicle_selection'));
  request.body = json.encode({
    "token": "${box.read('token')}",
    "type": "$type",
    "option": "$option",
    "vehicle_quantity": vehicle_quantity,
    "weight": "$weight",
    "material": ["$material"],
    "option_quantity": "$option_quantity"
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Map responseMap = await json.decode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
    print(responseMap);
    _getVehicleController.fetchVehicle();
    if (responseMap['status'] == false &&
        responseMap['error'] == 'Option Not Found In This Vehicle type') {
      Get.snackbar(
          "Error", "You cannot select this option with selected option type",
          colorText: Colors.red);
    }
    if (responseMap['status'] == true) {
      _getVehicleController.fetchVehicle();
      Get.back();
    }
  } else {
    print(responseMap);
    print(response.reasonPhrase);
  }
}
