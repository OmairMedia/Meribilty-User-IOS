import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/get%20vehicle%20data/get_vehicle_data_model.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/get%20vehicle%20data/vehicle_data_getx_controller.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/loading/get_loading_controller.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/unloading/get_unloading_option_controller.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/materials/get_material_controller.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/selectionModelsforCreaterequest.dart';

import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_deliveries.dart';

import 'VehicleSelectionHome.dart';

class WeightAndMaterialTemp extends StatefulWidget {
  WeightAndMaterialTemp({
    Key? key,
    required this.pickupLatLng,
    required this.dropOffLatLng,
    required this.pickup_address,
    required this.dropOff_address,
    required this.containerDropOff,
    required this.type,
    required this.selectedVehicles,
    required this.selectedVehicles2,
    required this.markers,
    required this.polyline,
  }) : super(key: key);
  LatLng? pickupLatLng;
  LatLng? dropOffLatLng;
  String? pickup_address;
  String? dropOff_address;
  String? containerDropOff;
  List<Marker>? markers;
  final Set<Polyline>? polyline;
  final int type;
  List<AddVehicleModel> selectedVehicles;
  List<AddVehicleModelImage> selectedVehicles2;

  @override
  State<WeightAndMaterialTemp> createState() => _WeightAndMaterialTempState();
}

class _WeightAndMaterialTempState extends State<WeightAndMaterialTemp> {
  List dropdownValueWeight = [];
  List selectedmaterials = [];
  List weightforeveryone = [];
  List everyoneImages = [];
  List alldata = [];
  VehicleDataStrp1Controller _vehicledata =
      Get.put(VehicleDataStrp1Controller());

  GetMaterialsController _materialController =
      Get.put(GetMaterialsController());
  // @override
  // void initState() {
  //   super.initState();
  //   for (var i = 0; i < _vehicledata.vehicleData[0].data!.length; i++) {
  //     // print(_vehicledata.vehicleData[i].data!
  //     //     .where((element) => element.vehicleType == widget.selectedVehicles[i].name).toList());
  //     //  if(widget.selectedVehicles[i].name==_vehicledata.vehicleData[0].data![i].vehicleType){
  //     //    alldata.add(_vehicledata.vehicleData[0].data![i]);
  //     //  }
  //   }
  //   print(alldata);
  // }
  final dataKey = new GlobalKey();
  ScrollController _controller = new ScrollController();

  void _goToElement(int index) {
    _controller.animateTo(
        (100.0 *
            index), // 100 is the height of container and index of 6th element is 5
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Step 2',
              style: Constants.heading3.copyWith(color: Colors.white),
            ),
            Text(
              'Select Weight & Material',
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
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: ListView.builder(
                controller: _controller,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: widget.selectedVehicles.length,
                itemBuilder: (context, index) {
                  if (dropdownValueWeight.length <
                      widget.selectedVehicles.length) {
                    dropdownValueWeight.add("Select Weight");
                  }
                  if (selectedmaterials.length <
                      widget.selectedVehicles.length) {
                    selectedmaterials.add("Select Material");
                  }
                  return ListTile(
                    leading: Container(
                      height: 60,
                      width: 60,
                      child: Image(
                          image: NetworkImage(
                        "${widget.selectedVehicles2[index].image}",
                      )),
                    ),
                    // CircleAvatar(
                    //   radius: 30,
                    //   backgroundColor: Colors.white,
                    //   backgroundImage: NetworkImage(
                    //     "${widget.selectedVehicles2[index].image}",
                    //   ),
                    // ),
                    title: Text(
                      "${widget.selectedVehicles[index].name}",
                      style: Constants.heading4,
                    ),
                    trailing: SizedBox(
                      height: 40,
                      child: FittedBox(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 17),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                dropdownValueWeight[index] != "Select Weight"
                                    ? "${dropdownValueWeight[index]} Tons"
                                    : "${dropdownValueWeight[index]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Constants.Primary),
                              ),
                              DropDownMenuFb1(
                                  icon: Icon(Icons.arrow_drop_down),
                                  menuList: [
                                    PopupMenuItem(
                                      
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: SizedBox(
                                        // height: 170,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Column(
                                          children: [
                                            ListView.builder(
                                              controller: _controller,
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              itemBuilder: (context, ind) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        print(
                                                          _materialController
                                                              .Materialdata[0]
                                                              .data[index]
                                                              .name,
                                                        );
                                                      },
                                                      child: ListTile(
                                                        onTap: () {
                                                          print(
                                                              "${widget.selectedVehicles2[index].weightList[ind]}");
                                                          setState(() {
                                                            dropdownValueWeight[
                                                                    index] =
                                                                "${widget.selectedVehicles2[index].weightList[ind]}";
                                                            widget
                                                                    .selectedVehicles[
                                                                        index]
                                                                    .weight =
                                                                "${widget.selectedVehicles2[index].weightList[ind]}";

                                                            widget
                                                                    .selectedVehicles2[
                                                                        index]
                                                                    .weight =
                                                                "${widget.selectedVehicles2[index].weightList[ind]}";
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        title: Text(
                                                          "${widget.selectedVehicles2[index].weightList[ind]}",
                                                          style: Constants
                                                              .regular5,
                                                        ),
                                                      )),
                                                );
                                              },
                                              itemCount: widget
                                                  .selectedVehicles2[index]
                                                  .weightList
                                                  .length,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  width: 110,
                                                  child: TextField(
                                                    onTap: () {
                                                 
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller:
                                                        weightController,
                                                    // onChanged: (val) {
                                                    //   setState(() {
                                                    //     dropdownValueWeight[index] = val;
                                                    //     widget.selectedVehicles[index]
                                                    //         .weight = val;
                                                    //         widget.selectedVehicles2[index]
                                                    //         .weight = val;
                                                    //   });
                                                    // },
                                                    decoration: InputDecoration(
                                                      hintText: "Other",
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: TextButton(
                                                      onPressed: () {
                                                        if (num.parse(
                                                                weightController
                                                                    .text) <=
                                                            num.parse(widget
                                                                .selectedVehicles2[
                                                                    index]
                                                                .maxLimit)) {
                                                          setState(() {
                                                            dropdownValueWeight[
                                                                    index] =
                                                                weightController
                                                                    .text;
                                                            widget
                                                                    .selectedVehicles[
                                                                        index]
                                                                    .weight =
                                                                weightController
                                                                    .text;
                                                            widget
                                                                    .selectedVehicles2[
                                                                        index]
                                                                    .weight =
                                                                weightController
                                                                    .text;
                                                          });
                                                          weightController
                                                              .clear();
                                                          Navigator.pop(context);
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Please Enter Under Maximum Limit: ${widget.selectedVehicles2[index].maxLimit} Ton",
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .BOTTOM,
                                                              fontSize: 16.0);
                                                        }
                                                      },
                                                      child: Text("SAVE")),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                    subtitle: SizedBox(
                      height: 30,
                      child: FittedBox(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${selectedmaterials[index]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Constants.Primary,
                              ),
                            ),
                            DropDownMenuFb1(
                                icon: Icon(Icons.arrow_drop_down),
                                menuList: [
                                  PopupMenuItem(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: SizedBox(
                                      // height: 170,
                                      width: 190,
                                      child: Column(
                                        children: [
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: ScrollPhysics(),
                                            itemBuilder: (context, ind) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: ListTile(
                                                  onTap: () {
                                                    print(
                                                        "${_materialController.Materialdata[0].data[ind].name}");
                                                    setState(() {
                                                      selectedmaterials[index] =
                                                          "${_materialController.Materialdata[0].data[ind].name}";
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  title: Text(
                                                    _materialController
                                                        .Materialdata[0]
                                                        .data[ind]
                                                        .name,
                                                    style: Constants.regular5,
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount: _materialController
                                                .Materialdata[0].data.length,
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            width: 190,
                                            child: TextField(
                                              onChanged: (val) {
                                                setState(() {
                                                  selectedmaterials[index] =
                                                      val;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                hintText: "   Other",
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
          //Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Constants.Primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 46.0),
                      child: Text(
                        "Back",
                        style:
                            Constants.regular3.copyWith(color: Constants.White),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Constants.Primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 46.0),
                      child: Text(
                        "Save",
                        style:
                            Constants.regular3.copyWith(color: Constants.White),
                      ),
                    ),
                  ),
                  onTap: () async {
                    if (selectedmaterials.contains("Select Material")) {
                      Get.snackbar(
                        "Error",
                        "Please fill al fields before proceeding",
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.black,
                        margin: EdgeInsets.all(10),
                      );
                    } else if (dropdownValueWeight.contains("Select Weight")) {
                      Get.snackbar(
                        "Error",
                        "Please fill al fields before proceeding",
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.black,
                        margin: EdgeInsets.all(10),
                      );
                    } else {
                      print(widget.selectedVehicles[0].weight);
                      //     _vehicledata.selectedWeights = dropdownValueWeight;
                      _vehicledata.selectedMaterials = selectedmaterials;

                      setState(() {
                        _vehicledata.finaldata = widget.selectedVehicles;
                        _vehicledata.finaldataLocal = widget.selectedVehicles2;
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => VehicleSelectionHomePage(
                                    pickupLatLng: widget.pickupLatLng,
                                    dropOffLatLng: widget.dropOffLatLng,
                                    pickup_address: widget.pickup_address,
                                    dropOff_address: widget.dropOff_address,
                                    containerDropOff: widget.containerDropOff,
                                    type: widget.type,
                                    polyline: widget.polyline,
                                    markers: widget.markers,
                                  )));
                    }
                  },
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  TextEditingController weightController = TextEditingController();
  saveMaterialandWeight() async {}
}
