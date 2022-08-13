import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meribiltyapp/Api%20Services/selection%20services/get%20vehicle%20data/get_vehicle_data_model.dart';




Future<List<GetVehicleDataStep1Model>> getVehicleDataStep1() async {
  Uri apiUrl = Uri.parse("https://staging-api.meribilty.com/api/get_vehicle_types");
  var response = await http.Client().post(apiUrl);

    var jsonString = json.decode(response.body);
    if(jsonString["status"]==true){
      print("\n\n\n\n vehicle reponse ${response.body}\n\n\n"); 
      return [getVehicleDataStep1ModelFromJson(response.body)];
      
    }else{
      throw Exception('Failed to load vehicle data');
    }

    }
  // }else{
  //   return 
  // }
