import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:meribiltyapp/Api%20Services/notifications/send_notification_to_all_vendor.dart';
import 'package:meribiltyapp/Api%20Services/ppl/get_distance_and_time.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/get%20vehicle%20data/vehicle_data_getx_controller.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/loading/get_loading_controller.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/unloading/get_unloading_option_controller.dart';
import 'dart:convert';
import 'package:meribiltyapp/widgets/loading.dart';
import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/screens/ppl/finding_best_qoute.dart';
import 'package:meribiltyapp/widgets/transit/cargovalue.dart';

class CreateRequest {
  UnloadingDataController _unloadingDataController =
      Get.put(UnloadingDataController());
  LoadingDataController _loadingDataController =
      Get.put(LoadingDataController());
  VehicleDataStrp1Controller _vehicleDataStrp1Controller =
      Get.put(VehicleDataStrp1Controller());

  createRequest(
      {required time,
      required type,
      required bool cargo_insurance,
      required desLat,
      required desLng,
      required desText,
      required disText,
      required orgLat,
      required orgLng,
      required orgText,
      required originAddress,
      required destinationAddress,
      required containerReturn,
      required context}) async {
    var timeanddistance;
    showloadingDialog("Creating your request...", context);
    try {
      await getDistanceAndTime("$orgLat,$orgLng", "$desLat,$desLng")
          .then((value) => timeanddistance = value);
    } catch (e) {
      print(e);
    }

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://staging-api.meribilty.com/ppl/create_request'));
    request.body = json.encode({
      "token": "${box.read("token")}",
      "date": "$time",
      "type": "$type",
      "cargo_insurance": cargo_insurance,
      "cargo_value": cargo_insurance == true ? "$insurance_value" : "0",
      "desLat": "$desLat",
      "desLng": "$desLng",
      "desText": "$desText",
      "disText": timeanddistance == null ? " " : "${timeanddistance[1]}",
      "durText": timeanddistance == null ? " " : "${timeanddistance[0]} ",
      "orgLat": "$orgLat",
      "orgLng": "$orgLng",
      "orgText": "$orgText",
      // "emptyLat": "53.21",
      // "emptyLng": "67.088",
      // "emptyText": "Pata nhi",
      "security_deposit": "00",
      "originAddress": "$orgText",
      "destinationAddress": "$desText",
      "containerReturnAddress": "$containerReturn",
      "selections": {
        "vehicles": _vehicleDataStrp1Controller.finaldata,
        //  [
        //     {
        //         "name": "Mazda 14ft open local",
        //         "weight": "1-3",
        //         "quantity": "1"
        //     }
        // ],
        "loading_options": _loadingDataController.selecteddataforApi,
        "unloading_options": _unloadingDataController.selecteddataforApi,
        "materials": _vehicleDataStrp1Controller.selectedMaterials
      }
    });
    request.headers.addAll(headers);
    if (_vehicleDataStrp1Controller.finaldata.isEmpty) {
      Get.snackbar("Error", "Please select vehicle",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          icon: Icon(Icons.error, color: Colors.white));
    } else {
      http.StreamedResponse response = await request.send();
      Map responseMap = json.decode(await response.stream.bytesToString());
      Navigator.pop(context);
      if (response.statusCode == 200) {
        print(responseMap['request']['createdAt']);
        if (responseMap['status'] == true) {
          _vehicleDataStrp1Controller.finaldata = [];
          _vehicleDataStrp1Controller.finaldataLocal = [];

          _loadingDataController.selecteddataforApi = [];
          _unloadingDataController.selecteddataforApi = [];
          _loadingDataController.selecteddataforapi2 = [];
          _unloadingDataController.selecteddataforapi2 = [];
          //Notification APi Commented
          // sendNotificationOnJobCreation();

          // Get.to(FindingBestQoute(orderNo: responseMap['orderNo'],));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (_) => FindingBestQoute(
                        orderNo: responseMap['orderNo'], createdAt: responseMap['request']['createdAt']
                      )),
              (route) => false);
          var snackbar = SnackBar(content: Text(responseMap['message']));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          // _vehicleDataStrp1Controller.vehicleCounter.clear();
        }
        if (responseMap['status'] == false) {
          var snackbar = SnackBar(content: Text(responseMap['error']));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      } else {
        print(responseMap);
        print(response.reasonPhrase);
      }
    }
  }
}
