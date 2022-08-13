import 'package:get/state_manager.dart';
import 'package:meribiltyapp/Api%20Services/vehicle%20selection/get_vehicles_selections.dart';
import 'package:meribiltyapp/models/vehicle_selection_models/get_vehicle_selection_model.dart';

class GetVehicleController extends GetxController {
  var isLoading = false.obs;
  var vehicleList = <GetVehicleSelectionModel>[].obs;
  @override
  void inInit() {
    fetchVehicle();
    super.onInit();
  }

  void fetchVehicle() async {
    try {
      isLoading(true);
      var vehicles = await fetchVehiclesData();
      if (vehicles != null) {
        vehicleList.value = vehicles;
        // print(vehicleList[0].data[0].userPhone);
        // print(vehicleList[0].data!.length);
      }
    } finally {
      isLoading(false);
    }
    update();
  }
}
