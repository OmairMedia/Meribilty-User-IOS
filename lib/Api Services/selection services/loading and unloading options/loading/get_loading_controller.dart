import 'package:get/get.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/loading/get_loading_model.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/loading/get_loading_service.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/loading/loading_options_local.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/selectionModelsforCreaterequest.dart';

class LoadingDataController extends GetxController {
  var isLoading = false.obs;
  var loadingData = <GetLoadingOptionsModel>[].obs;
  // var selectedLoadingData = <LoadingSelectedData>[].obs;
  List selecteddataforApi = <LoadingForapiModel>[].obs;
  List selecteddataforapi2= <LoadingForapiModelWithImage>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchLoading();
  }

  void fetchLoading() async {
    try {
      isLoading(true);
      var loadingOptions = await getLoadingOptionService();
      if (loadingOptions != null) {
        loadingData.value = loadingOptions;
        print(loadingData[0].data![0].id);
      }
    } finally {
      isLoading(false);
    }
    update();
  }

  // addtoHomeScreen(id, LoadingSelectedData data) {
  //   var index = loadingData[0].data!.indexWhere((element) => element.id == id);
  //   selectedLoadingData.add(data);
  //   print(selectedLoadingData);
  //   update();
  // }

  // removeFromHomeScreen(id, LoadingSelectedData data) {
  //   var index = loadingData[0].data!.indexWhere((element) => element.id == id);
  //   selectedLoadingData.remove(data);
  //   print(selectedLoadingData);
  //   update();
  // }

  // removeallofsameid(id, LoadingSelectedData data) {
  //   selectedLoadingData.removeWhere((element) => element.id == id);
  //   print(selectedLoadingData);
  //   update();
  // }

  // getallValuesLoading() {
  //   if (selectedLoadingData.isNotEmpty) {
  //     selectedLoadingData.forEach((element) {
  //       // print(element.weight);
  //       selecteddataforApi.add(LoadingForapiModel(
  //           name: element.name, weight: element.weight, quantity: 1));
  //     });
  //   } else {
  //     print("HELLO");
  //   }
  //   update();
  // }
}
