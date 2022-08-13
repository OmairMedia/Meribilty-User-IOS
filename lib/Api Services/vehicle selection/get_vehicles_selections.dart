import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meribiltyapp/Api%20Services/vehicle%20selection/vehicle_selection_data_service.dart';
import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/models/vehicle_selection_models/get_vehicle_selection_model.dart';
import 'package:http/http.dart' as http;
import 'package:meribiltyapp/widgets/upcountry/selectvehiclecard.dart';

Future<List<GetVehicleSelectionModel>> fetchVehiclesData() async {
  var headers = {'Content-Type': 'application/json'};
  GetVehicleSelectionDataController _getselectionData =
      Get.put(GetVehicleSelectionDataController());
  Uri apiurl =
      Uri.parse('https://staging-api.meribilty.com/api/get_vehicle_selections');
  var response = await http.Client().post(apiurl,
      headers: headers, body: json.encode({"token": box.read('token')}));
  if (response.statusCode == 200) {
    var jsonString = response.body;
    var responseMap = await json.decode(response.body);
    print("Successfully fetched staff");
    if (responseMap['status'] == false &&
        responseMap['error'] == "No Selection Found !") {
      _getselectionData.fetchSelectionData();
      // Get.back();
      // Get.to(SelectVehicleOption());
      // Get.snackbar("${responseMap['error']}", 'Add Your Vehicle ');
    }
    if (responseMap['status'] == false &&
        responseMap['error'] == "No Selection Found !") {
      // _getselectionData.dispose();
      print("HELLO WORLD");
      Get.delete<GetVehicleSelectionDataController>();
      return [];
    }

    if (responseMap['status'] == true) {
      print(response.body);
      print(getVehicleSelectionModelFromJson(jsonString));
      return [getVehicleSelectionModelFromJson(jsonString)];
    } else {
      Get.delete<GetVehicleSelectionDataController>();
      print(responseMap);
      throw Exception('Failed to load staff');
    }
  } else {
    print(response.body);
    print("There is an error");
    throw Exception('Failed to load staff');
  }
}
