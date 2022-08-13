import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:meribiltyapp/Api%20Services/vehicle%20selection/get_vehicle_service_with_getx.dart';
import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';

removeVehicle(id) async {
  var headers = {'Content-Type': 'application/json'};
  GetVehicleController _getvehiclecontroller = Get.put(GetVehicleController());
  var request = http.Request(
      'POST', Uri.parse('https://staging-api.meribilty.com/api/remove_vehicle_selection'));
  request.body = json.encode({"token": "${box.read('token')}", "id": "$id"});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Map responseMap = json.decode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    if (responseMap['status'] == true) {
      _getvehiclecontroller.fetchVehicle();
    }
  } else {
    print(response.reasonPhrase);
  }
}
