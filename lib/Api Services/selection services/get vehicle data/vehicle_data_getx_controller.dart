import 'package:get/get.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/get%20vehicle%20data/get_vehicle_data_api.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/get%20vehicle%20data/get_vehicle_data_model.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/selectionModelsforCreaterequest.dart';

class VehicleDataStrp1Controller extends GetxController {
  var isLoading = false.obs;
  var vehicleData = <GetVehicleDataStep1Model>[].obs;
  var vehicleCounter = [].obs;
  var selectedVehicles = [].obs;
  List selectedWeights = <dynamic>[].obs;
  List selectedMaterials = <dynamic>[].obs;
  List selecteddataforApi = <AddVehicleForapiModel>[].obs;
  List finaldata = <AddVehicleModel>[].obs;
  List finaldataLocal = <AddVehicleModelImage>[].obs;
  void fetchVehicleStep1() async {
    try {
      isLoading(true);
      var vehicles = await getVehicleDataStep1();
      if (vehicles != null) {
        vehicleData.value = vehicles;
        // vehicleCounter =
        //     List.generate(vehicleData[0].data!.length, (index) => 0).obs;

        print(vehicleData[0].data![0].id);
      }
    } finally {
      isLoading(false);
    }
    update();
  }

  addtoHomeScreen(id) {
    var index = vehicleData[0].data!.indexWhere((element) => element.id == id);
    selectedVehicles.add(vehicleData[0].data![index]);
    print(selectedVehicles);
    update();
  }

  removeForHomeScreen(id) {
    var index = vehicleData[0].data!.indexWhere((element) => element.id == id);
    selectedVehicles.remove(vehicleData[0].data![index]);
    selectedMaterials.remove(index);
    selectedWeights.remove(index);

    print(index);
    update();
  }

  removeFromHomeScreen(id) {
    var index = vehicleData[0].data!.indexWhere((element) => element.id == id);
    selectedVehicles.remove(vehicleData[0].data![index]);

    print(selectedVehicles);
    update();
  }

  removeallofsameid(id) {
    selectedVehicles.removeWhere((element) => element.id == id);
    print(selectedVehicles);
    update();
  }

  getallVehicleForCreateingreq() {
    if (selectedVehicles.isNotEmpty) {
      selectedVehicles.asMap().forEach((index, element) {
        // print(element.vehicleType);
        //  print(element.weights[index]);

        // print(index);
        selecteddataforApi.add(AddVehicleForapiModel(
            name: element.vehicleType,
            weight: element.weights[index],
            quantity: 1));
      });
      // for(var i = 0; i <=selectedVehicles.length; i++){
      //   print(selecteddataforApi);
      //   print(i);
      //    selecteddataforApi.add(AddVehicleForapiModel(
      //       name: selectedVehicles[i].vehicleType, weight: selectedWeights[i], quantity: 1));
      // }
    } else {
      print("HELLO");
    }
    update();
  }
}
