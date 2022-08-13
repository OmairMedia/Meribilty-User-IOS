import 'package:get/get.dart';
import 'package:meribiltyapp/Api%20Services/invite/My%20Team/myTeamApi.dart';
import 'package:meribiltyapp/Api%20Services/invite/My%20Team/myTeamModel.dart';

class MyTeamService extends GetxController {
  var isLoading = false.obs;
  var myTeam = <MyTeamModel>[].obs;
  @override
  void onInit() {
    fetchMyTeamService();
    super.onInit();
  }

  void fetchMyTeamService() async {
    try {
      isLoading(true);
      var teamData = await fetchMyTeam();
      if (teamData != null) {
        myTeam.value = teamData;
        print(myTeam[0].data![0].email);
      }
    } finally {
      isLoading(false);
    }
    update();
  }
}
