import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meribiltyapp/Api%20Services/selection%20services/materials/material_model.dart';

Future<GetMaterialModel> getMaterials() async {
  Uri apiUrl = Uri.parse("https://staging-api.meribilty.com/api/get_materials");
  var response = await http.Client().post(apiUrl);
  var jsonString = json.decode(response.body);
  if (jsonString["status"] == true) {
    print(jsonString["data"]);
    return getMaterialModelFromJson(response.body);
  } else {
    throw Exception('Failed to load vehicle data');
  }
}
