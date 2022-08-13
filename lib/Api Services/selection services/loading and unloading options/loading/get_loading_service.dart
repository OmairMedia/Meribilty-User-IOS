import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/loading/get_loading_model.dart';

Future<List<GetLoadingOptionsModel>> getLoadingOptionService() async {
  Uri apiUrl = Uri.parse("https://staging-api.meribilty.com/api/get_loading_options");
  var response = await http.Client().post(apiUrl);

    var jsonString = json.decode(response.body);
    if(jsonString["status"]==true){
      return [getLoadingOptionsModelFromJson(response.body)];
    }else{
      throw Exception('Failed to load vehicle data');
    }

    }
