// import 'package:get/get.dart';
// import 'package:meribiltyapp/Api%20Services/vehicle%20selection/get_selection_data.dart';
// import 'package:meribiltyapp/Api%20Services/vehicle%20selection/get_selection_data_model.dart';
import 'package:get/get.dart';
import 'package:meribiltyapp/Api%20Services/vehicle%20selection/get_selection_data.dart';
import 'package:meribiltyapp/Api%20Services/vehicle%20selection/get_selection_data_model.dart';

class GetVehicleSelectionDataController extends GetxController {
  var isLoading = false.obs;
  var selectionDataList = <GetVehicleSelectionDataModel>[].obs;
  @override
  void onInit() {
    fetchSelectionData();
    super.onInit();
  }

  @override
  void dispose() {
    Get.delete<GetVehicleSelectionDataController>();
    super.dispose();
  }

  // @override
  // void close(){
  //   print('log if close is invoked');
  //   _streamController.close();
  //   super.close();
  // }


  void fetchSelectionData() async {
    try {
      isLoading(true);
      var vehicles = await fetchvehicleselectiondata();
      if (vehicles != null) {
        selectionDataList.value = vehicles;
        print(selectionDataList);
        // print(vehicleList[0].data[0].userPhone);
        // print(vehicleList[0].data.length);
      }
    } finally {
      isLoading(false);
    }
    update();
  }
}

// class GetVehicleSelectionDataController extends GetxController {
//   var isLoading = false.obs;
//   var vehicleselectionDataList = [].obs;
//   @override
//   void inInit() {
//     fetchVehicleselectionData();
//     super.onInit();
//   }

//   void fetchVehicleselectionData() async {
//     try {
//       isLoading(true);
//       var vehicleselectionData = await fetchvehicleselectiondata();
//       if (vehicleselectionData != null) {
//         vehicleselectionDataList.value = vehicleselectionData;
//         print(vehicleselectionData[0].materials);
//         // print(vehicleList[0].data[0].userPhone);
//         // print(vehicleList[0].data.length);
//       }
//     } finally {
//       isLoading(false);
//     }
//     update();
//   }
// }
