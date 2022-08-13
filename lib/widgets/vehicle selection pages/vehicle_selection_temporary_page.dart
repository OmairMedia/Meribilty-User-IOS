import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/get%20vehicle%20data/vehicle_data_getx_controller.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/selectionModelsforCreaterequest.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/vehicle%20selection%20pages/select_weight_and_material_temp.dart';

class VehicleStep1SelectionTemp extends StatefulWidget {
  VehicleStep1SelectionTemp(
      {Key? key,
      required this.pickupLatLng,
      required this.dropOffLatLng,
      required this.pickup_address,
      required this.dropOff_address,
      required this.containerDropOff,
      required this.markers,
      required this.polyline,
      required this.type})
      : super(key: key);
  LatLng? pickupLatLng;
  LatLng? dropOffLatLng;
  String? pickup_address;
  String? dropOff_address;
  String? containerDropOff;
  List<Marker>? markers;
  final Set<Polyline>? polyline;
  final int type;
  @override
  State<VehicleStep1SelectionTemp> createState() => _VehicleSelectionState();
}

class _VehicleSelectionState extends State<VehicleStep1SelectionTemp> {
  String image = 'assets/images/vehicle_images/suzuki.png';
  List everyoneImages = [];
  List everyoneWeights = [];
  List vehicleCounter = [];

  // List<int> _loadingcounter = [];
  List<int> selectedIndexesVehicle = [];
  List<AddVehicleModel> selectedVehiclesmodel = [];
  List<AddVehicleModelImage> selectedVehiclesmodel2 = [];

  //int _count = 0;
  List<int> _counter = [];
  VehicleDataStrp1Controller _vehicledata =
      Get.put(VehicleDataStrp1Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Step 1',
              style: Constants.heading3.copyWith(color: Colors.white),
            ),
            Text(
              'Select Vehicle',
              style: Constants.heading3.copyWith(color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Constants.Primary,
        leading: InkWell(
          child: Icon(FontAwesomeIcons.chevronLeft),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          InkWell(
            onTap: (){
             Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => super.widget));
            },
            child: Center(
              child: Text("Refresh",
                  style: Constants.regular4.copyWith(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (_vehicledata.vehicleData.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top:55, bottom: 55),
                  child: CircularProgressIndicator(),
                );
              }
              if (_vehicledata.isLoading == true) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: _vehicledata.vehicleData[0].data!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (vehicleCounter.length <
                          _vehicledata.vehicleData[0].data!.length) {
                        vehicleCounter = List.generate(
                            _vehicledata.vehicleData[0].data!.length,
                            (index) => 0).obs;
                      }
                      return ListTile(
                        onTap: () {
                          if (selectedIndexesVehicle.contains(index)) {
                            setState(() {
                              selectedIndexesVehicle.remove(index);
                              selectedVehiclesmodel.removeWhere((element) =>
                                  element.name ==
                                  _vehicledata
                                      .vehicleData[0].data![index].vehicleType);

                              selectedVehiclesmodel2.removeWhere((element) =>
                                  element.name ==
                                  _vehicledata
                                      .vehicleData[0].data![index].vehicleType);
                              vehicleCounter[index] = 0;
                              print(selectedVehiclesmodel);
                            });
                          } else {
                            setState(() {
                              selectedIndexesVehicle.add(index);
                              selectedVehiclesmodel.add(AddVehicleModel(
                                name:
                                    '${_vehicledata.vehicleData[0].data![index].vehicleType}',
                                quantity: "1",
                                weight: "0",
                                image:
                                    '${_vehicledata.vehicleData[0].data![index].vehicleImage}',
                              ));

                              selectedVehiclesmodel2.add(AddVehicleModelImage(
                                name:
                                    '${_vehicledata.vehicleData[0].data![index].vehicleType}',
                                quantity: "1",
                                weight: "0",
                                image:
                                    '${_vehicledata.vehicleData[0].data![index].vehicleImage}',
                                weightList: _vehicledata
                                    .vehicleData[0].data![index].weights,
                                maxLimit: _vehicledata
                                    .vehicleData[0].data![index].vehicleLimit,
                              ));
                              vehicleCounter[index]++;

                              print(selectedVehiclesmodel);
                            });
                          }
                        },
                        tileColor: selectedIndexesVehicle.contains(index)
                            ? Constants.Primary
                            : null,
                        leading: Container(
                          height: 60,
                          width: 60,
                          child: Image(
                              image: NetworkImage(
                            '${_vehicledata.vehicleData[0].data![index].vehicleImage}',
                          )),
                        ),
                        //  CircleAvatar(
                        //   backgroundColor: Colors.white,
                        //   radius: 30,
                        //   backgroundImage: NetworkImage(
                        //     '${_vehicledata.vehicleData[0].data![index].vehicleImage}',
                        //   ),
                        // ),
                        title: Text(
                          '${_vehicledata.vehicleData[0].data![index].vehicleType}',
                          style: Constants.heading4.copyWith(
                              color: selectedIndexesVehicle.contains(index)
                                  ? Colors.white
                                  : Color(0xff2F4D84)),
                        ),
                        subtitle: Text(
                            "Max Limit ${'${_vehicledata.vehicleData[0].data![index].vehicleLimit}'} Tons",
                            style:
                                Constants.regular4.copyWith(color: Colors.grey)
                            // selectedIndex == index
                            //     ? Colors.white
                            //     : Color(0xff2F4D84)),
                            ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            OutlinedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: selectedIndexesVehicle
                                                      .contains(index)
                                                  ? Colors.white
                                                  : Color(0xff2F4D84),
                                              width: 3))),
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(20, 20)),
                                  maximumSize: MaterialStateProperty.all(
                                      const Size(39, 36)),
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (vehicleCounter[index] > 0) {
                                      if (vehicleCounter[index] == 1) {
                                        selectedIndexesVehicle.remove(index);
                                      }
                                      vehicleCounter[index]--;
                                      var indextoremove = selectedVehiclesmodel
                                          .indexWhere((element) =>
                                              element.name ==
                                              _vehicledata.vehicleData[0]
                                                  .data![index].vehicleType);
                                      selectedVehiclesmodel
                                          .removeAt(indextoremove);
                                      selectedVehiclesmodel2
                                          .removeAt(indextoremove);

                                      // selectedVehiclesmodel.removeWhere(
                                      //     (element) =>
                                      //         element.name ==
                                      //         _vehicledata
                                      //             .vehicleData[0].data![index]
                                      //             .vehicleType);
                                      // selectedVehiclesmodel.remove((element) =>
                                      // element.name ==
                                      //  _vehicledata
                                      // .vehicleData[0].data![index].vehicleType);
                                      // selectedVehiclesmodel2.remove((element) =>
                                      // element.name ==
                                      //  _vehicledata
                                      // .vehicleData[0].data![index].vehicleType);

                                      print(selectedVehiclesmodel);
                                    }
                                    // _vehicledata.vehicleCounter[index]--;

                                    // print(indextominus);
                                    // selectedVehiclesmodel.remove(
                                    //     selectedVehiclesmodel.where((element) =>
                                    //         element.name ==
                                    //         '${_vehicledata.vehicleData[0].data![index].vehicleType}'));
                                    // print(selectedVehiclesmodel);
                                  });
                                },
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          selectedIndexesVehicle.contains(index)
                                              ? Colors.white
                                              : Color(0xff2F4D84)),
                                )),
                            Text(
                              !selectedIndexesVehicle.contains(index)
                                  ? "0"
                                  : vehicleCounter[index].toString(),
                              style: TextStyle(
                                  color: selectedIndexesVehicle.contains(index)
                                      ? Colors.white
                                      : Color(0xff2F4D84)),
                            ),
                            OutlinedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(),
                                  )),
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(20, 20)),
                                  maximumSize: MaterialStateProperty.all(
                                      const Size(39, 36)),
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (!selectedIndexesVehicle
                                        .contains(index)) {
                                      selectedIndexesVehicle.add(index);
                                    }
                                    vehicleCounter[index]++;
                                    selectedVehiclesmodel.add(AddVehicleModel(
                                      name:
                                          '${_vehicledata.vehicleData[0].data![index].vehicleType}',
                                      quantity: "1",
                                      weight: "0",
                                      image:
                                          '${_vehicledata.vehicleData[0].data![index].vehicleImage}',
                                    ));

                                    selectedVehiclesmodel2
                                        .add(AddVehicleModelImage(
                                      name:
                                          '${_vehicledata.vehicleData[0].data![index].vehicleType}',
                                      quantity: "1",
                                      weight: "0",
                                      image:
                                          '${_vehicledata.vehicleData[0].data![index].vehicleImage}',
                                      weightList: _vehicledata
                                          .vehicleData[0].data![index].weights,
                                      maxLimit: _vehicledata.vehicleData[0]
                                          .data![index].vehicleLimit,
                                    ));
                                    print(selectedVehiclesmodel);
                                  });
                                },
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          selectedIndexesVehicle.contains(index)
                                              ? Colors.white
                                              : Color(0xff2F4D84)),
                                )),
                          ],
                        ),
                      );
                    });
              }
            }),
           
            CustomBtn(
                outlinebtn: false,
                onpreased: () {
                  print(vehicleCounter);
                  if(_vehicledata.vehicleData.isEmpty){
                    
                  }else{
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => WeightAndMaterialTemp(
                                pickupLatLng: widget.pickupLatLng,
                                dropOffLatLng: widget.dropOffLatLng,
                                pickup_address: widget.pickup_address,
                                dropOff_address: widget.dropOff_address,
                                containerDropOff: widget.containerDropOff,
                                polyline: widget.polyline,
                                markers: widget.markers,
                                type: widget.type,
                                selectedVehicles: selectedVehiclesmodel,
                                selectedVehicles2: selectedVehiclesmodel2,
                              )));

                  }

                  print(selectedIndexesVehicle);
                },
                text: ("Next")),
          ],
        ),
      ),
    );
  }
}
