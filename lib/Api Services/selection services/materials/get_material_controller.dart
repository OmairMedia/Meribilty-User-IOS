import 'package:get/get.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/materials/get_material.dart';

class GetMaterialsController extends GetxController {
  var Materialdata = [].obs;

  void fetchMaterial() async {
    try {
      var materials = await getMaterials();
      if (materials != null) {
        Materialdata.add(materials);
        print(Materialdata[0].data[0].name);
      }
    } finally {
      update();
    } 
  }
}
