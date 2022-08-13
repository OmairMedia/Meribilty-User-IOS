import 'package:get/get.dart';
import 'package:meribiltyapp/Api%20Services/wallet/get_wallet_info.dart';
import 'package:meribiltyapp/Api%20Services/wallet/get_wallet_model.dart';

class GetWalletController extends GetxController {
  var isLoading = false.obs;
  var wallletData =[].obs;
  @override
  void inInit() {
    fetchWallet();
    super.onInit();
  }

  fetchWallet() async {
    try {
      isLoading(true);
      var vehicles = await fetchwallet();
      if (vehicles != null) {
        wallletData.value = vehicles;
        print("$wallletData from controller" );
        // print(vehicles[0].data!.amount);
      }
    } finally {
      isLoading(false);
    }
    update();
  }
}
