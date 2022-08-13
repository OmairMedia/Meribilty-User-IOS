import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:http/http.dart' as http;

// Future provinceList() async {
//   var headers = {'Content-Type': 'application/json'};
//   Uri apiurl = Uri.parse('https://staging-api.meribilty.com/ppl/get-provinces');
//   var response = await http.Client().post(apiurl,
//       headers: headers,
//       body: json.encode({}));

//   if (response.statusCode == 200) {
//     var jsonString = jsonDecode(response.body);
//     print("\n\n\n\nye mere provice hain   $jsonString\n\n");
//     // print(jsonString['message'] ?? jsonString['error']);
//     return jsonString;
//   } else {
//     print(response.body);
//     print("There is an error");
//     throw Exception('Failed to accept');
//   }
// }




class ApiResponseService {

  ProvinceListmodel? get provancies => _apiResponse;

  ProvinceListmodel? _apiResponse;

  getResponse() async {
    var forcastUrl =
    Uri.parse('https://staging-api.meribilty.com/ppl/get-provinces');

    try {
      var response = await http.get(forcastUrl,); // get

      var decodedJson = await jsonDecode(response.body) as Map<String, dynamic>;
      _apiResponse =
          await ProvinceListmodel.fromJson(decodedJson);

      print(provancies?.data?[1].provinceShortname);
      return _apiResponse;
    } catch (e) {
      throw e.toString();
    }
  } // getResponse

  // Future<APIResponse?> getResponseCity({required String? apiKey, required cityName}) async {
  //   var forcastUrl =
  //   Uri.parse(ApiBaseUrl.baseUrl + '/forecast.json?key=${apiKey}&q=${cityName}&days=1&aqi=no&alerts=no');
  //   // http://api.weatherapi.com/v1/forecast.json?key=4bbcba5c2ab44222be861518222606&q=karachi&days=1&aqi=no&alerts=no
  //   try {
  //     var response = await http.get(forcastUrl,); // get

  //     var decodedJson = jsonDecode(response.body) as Map<String, dynamic>;

  //     _apiResponse =
  //         APIResponse.fromJson(decodedJson);

  //     print(temparature);
  //     return _apiResponse;
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // } // getResponse
} // 



class ProvinceListmodel {
  List<Data>? data;

  ProvinceListmodel({this.data});

  ProvinceListmodel.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? provinceLongname;
  String? provinceShortname;
  String? value;

  Data({this.id, this.provinceLongname, this.provinceShortname, this.value});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provinceLongname = json['provinceLongname'];
    provinceShortname = json['provinceShortname'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provinceLongname'] = this.provinceLongname;
    data['provinceShortname'] = this.provinceShortname;
    data['value'] = this.value;
    return data;
  }
}