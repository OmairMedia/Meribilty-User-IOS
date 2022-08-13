import 'package:get/get.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/unloading/get_unloading_option_model.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/unloading/get_unloading_service.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/unloading/unloading_options_locally.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/selectionModelsforCreaterequest.dart';

class UnloadingDataController extends GetxController {
  var isLoading = false.obs;
  var unloadingData = <GetUnloadingOptionsModel>[].obs;
  var selectedUnloadingData = <UnLoadingSelectedData>[].obs;
  List selecteddataforApi = <UnLoadingForapiModel>[].obs;
  List selecteddataforapi2= <UnLoadingForapiModelWithImage>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchLoading();
  }

  void fetchLoading() async {
    try {
      isLoading(true);
      var unloadingOptions = await getUnloadingOptionService();
      if (unloadingOptions != null) {
        unloadingData.value = unloadingOptions;
        print(unloadingData[0].data![0].id);
      }
    } finally {
      isLoading(false);
    }
    update();
  }

  addtoHomeScreen(id, UnLoadingSelectedData data) {
    var index =
        unloadingData[0].data!.indexWhere((element) => element.id == id);
    selectedUnloadingData.add(data);
    print(selectedUnloadingData);
    update();
  }

  removeFromHomeScreen(id, UnLoadingSelectedData data) {
    var index =
        unloadingData[0].data!.indexWhere((element) => element.id == id);
    selectedUnloadingData.remove(data);
    print(selectedUnloadingData);
    update();
  }

  removeallofsameid(id, UnLoadingSelectedData data) {
    selectedUnloadingData.removeWhere((element) => element.id == id);
    print(selectedUnloadingData);
    update();
  }

  // getallValues() {
  //   if (selectedUnloadingData.isNotEmpty) {
  //     selectedUnloadingData.forEach((element) {
  //       selecteddataforApi.add(UnLoadingForapiModel(
  //           name: element.name, weight: element.weight, quantity: 1));
  //     });
  //   }else{
  //     print("HELLO");
  //   }

  //   update();
  // }
}
