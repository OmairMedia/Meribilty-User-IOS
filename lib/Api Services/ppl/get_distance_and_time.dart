import 'dart:convert';

import 'package:http/http.dart' as http;

 Future getDistanceAndTime(String origin, String destination) async {
  Uri apiUrl = Uri.parse(
      "https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=AIzaSyBtmA2MsfljS60NA3c_ljiVXC5gvv8TIFg");
  var response = await http.get(apiUrl);
  var data = jsonDecode(response.body);
  Map results = {
    "time": data['routes'][0]["legs"][0]["duration"]["text"],
    "distance": data['routes'][0]["legs"][0]["distance"]["text"]
  };
  print(results);
  return [results['time'], results['distance']];
}
