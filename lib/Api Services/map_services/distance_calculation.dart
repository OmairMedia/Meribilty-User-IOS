import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:meribiltyapp/models/get_destination_model.dart';

Future<GetdestinationModel> calculateDuration(LatLng pickupLatLng,
    LatLng dropofflatlng, apikey, duration, distance) async {
  try {
    Uri apiRul = Uri.parse(
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${pickupLatLng.latitude},${pickupLatLng.longitude}&destinations=${dropofflatlng.latitude},${dropofflatlng.longitude}&key=$apikey');
    var response = await http.get(apiRul);
    var result = await jsonDecode(response.body);
    var jsonString = response.body;
    GetdestinationModel data = getdestinationModelFromJson(jsonString);
    var rowData = data.rows;
    // var abc = rowData.elementAt(1);
    // print(rowData);
    print(jsonString);
    return getdestinationModelFromJson(jsonString);
  } catch (e) {
    throw Exception(e);
  }
}
