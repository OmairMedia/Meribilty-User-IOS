import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
class LocationService {
  final  String  key =  'AIzaSyBtmA2MsfljS60NA3c_ljiVXC5gvv8TIFg';

  Future<Map<String, dynamic>> getDirections(String origin,String destination) async{
    final String url = 'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$key';
    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);

    var results = {
      'bounds_ne' : data['routes'][0]['bounds']['northeast'],
      'bounds_sw' : data['routes'][0]['bounds']['southwest'],
      'start_location' : data['routes'][0]['legs'][0]['start_location'],
      'end_location' : data['routes'][0]['legs'][0]['end_location'],
      'polyline_points' : data['routes'][0]['overview_polyline']['points'],
      'polyline_decode' : PolylinePoints().decodePolyline("${data['routes'][0]['overview_polyline']['points']}")
    };
    return(results);
  }

  Future<Map<String, dynamic>> getDirectionsFromLatLng(originLat, originLng, destinationLat, destinationLng) async{
    final String url = 'https://maps.googleapis.com/maps/api/directions/json?origin=$originLat,$originLng&destination=$destinationLat,$destinationLng&key=$key';
    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    print('https://maps.googleapis.com/maps/api/directions/json?origin=$originLat,$originLng&destination=$destinationLat,$destinationLng&key=$key');
    var results = {
      'bounds_ne' : data['routes'][0]['bounds']['northeast'],
      'bounds_sw' : data['routes'][0]['bounds']['southwest'],
      'start_location' : data['routes'][0]['legs'][0]['start_location'],
      'end_location' : data['routes'][0]['legs'][0]['end_location'],
      'polyline_points' : data['routes'][0]['overview_polyline']['points'],
      'polyline_decode' : PolylinePoints().decodePolyline("${data['routes'][0]['overview_polyline']['points']}")
    };
    return(results);
  }

  // Future<void> getPlaceID(inputId) async {
  //   String url = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$inputId&inputtype=textquery&key=$key";
  //   var response = await http.get(Uri.parse(url));
  //   var data = json.decode(response.body);
  //   print(data);
  // }
}