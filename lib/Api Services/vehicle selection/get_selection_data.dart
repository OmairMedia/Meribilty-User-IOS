import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meribiltyapp/Api%20Services/vehicle%20selection/get_selection_data_model.dart';
import 'package:meribiltyapp/constants/main_constants.dart';

Future<List<GetVehicleSelectionDataModel>> fetchvehicleselectiondata() async {
  var headers = {'Content-Type': 'application/json'};

  Uri apiurl =
      Uri.parse('https://staging-api.meribilty.com/api/get_vehicle_types_and_options');
  var response = await http.Client().post(apiurl,
      headers: headers, body: json.encode({"token": box.read('token')}));
  if (response.statusCode == 200) {
    var jsonString = response.body;
    print("Successfully fetched staff");
    print(response.body);
    print(getVehicleSelectionDataModelFromJson(jsonString));
    return [getVehicleSelectionDataModelFromJson(jsonString)];
  } else {
    print(response.body);
    print("There is an error");
    throw Exception('Failed to load staff');
  }
}
// This is the selection data provided from api