import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/loading/get_loading_controller.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/loading/loading_options_local.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/unloading/get_unloading_option_controller.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/unloading/unloading_options_locally.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/selectionModelsforCreaterequest.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_deliveries.dart';
import 'package:meribiltyapp/widgets/animated_toggle.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/vehicle%20selection%20pages/VehicleSelectionHome.dart';
import 'package:meribiltyapp/widgets/vehicle%20selection%20pages/material_selection.dart';
import 'package:meribiltyapp/widgets/vehicle%20selection%20pages/weight_picker.dart';

class SelectLoadingUnloadingOption extends StatefulWidget {
  SelectLoadingUnloadingOption(
      {Key? key,
      required this.pickupLatLng,
      required this.dropOffLatLng,
      required this.pickup_address,
      required this.dropOff_address,
      required this.containerDropOff,
      required this.type,
      required this.markers,
      required this.polyline})
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
  State<SelectLoadingUnloadingOption> createState() =>
      _SelectLoadingUnloadingOptionState();
}

class _SelectLoadingUnloadingOptionState
    extends State<SelectLoadingUnloadingOption> {
  List dropdownValueWeightLoading = [];
  List dropdownValueWeightUnLoading = [];
  TextEditingController loadingotherweightController = TextEditingController();
  TextEditingController unloadingotherweightController =
      TextEditingController();

  List<int> _loadingcounter = [];
  List<int> _unloadinguncounter = [];
  List<int> selectedIndexesloading = [];
  List<int> selectedIndexesunloading = [];
  UnloadingDataController _unloadingData = Get.put(UnloadingDataController());
  LoadingDataController _loadingData = Get.put(LoadingDataController());
  List<LoadingForapiModel> _loadingforapi = [];
  List<UnLoadingForapiModel> _unloadingforapi = [];
  List<LoadingForapiModelWithImage> _loadingforapilocal = [];
  List<UnLoadingForapiModelWithImage> _unloadingforapilocal = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Constants.Primary,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 14.0, left: 8),
                  child: Text(
                    widget.type == 0
                        ? "Select Loading Option(Optional)"
                        : "Select Loading and UnLoading Option ",
                    style: Constants.heading3,
                  ),
                ),
              ),
              Obx(() {
                if (_loadingData.loadingData.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top:55, bottom: 55),
                  child: Text("No loading option in the database", style: Constants.heading2,textAlign: TextAlign.center,),
                );
              }
                if (_loadingData.isLoading == true) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _loadingData.loadingData[0].data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (_loadingcounter.length <
                            _loadingData.loadingData[0].data!.length) {
                          _loadingcounter.add(1);
                        }
                        if (dropdownValueWeightLoading.length <
                            _loadingData.loadingData[0].data!.length) {
                          dropdownValueWeightLoading.add("Weight");
                        }

                        final data = _loadingData.loadingData[0].data![index];

                        return Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                if (selectedIndexesloading.contains(index)) {
                                  selectedIndexesloading.remove(index);
                                  _loadingforapi.removeWhere(
                                      (element) => element.name == data.name);
                                  //
                                  _loadingforapilocal.removeWhere(
                                      (element) => element.name == data.name);
                                  _loadingcounter[index] = 0;
                                } else {
                                  if (dropdownValueWeightLoading[index] ==
                                          "Weight" &&
                                      data.name.toString().toLowerCase() != "labour") {
                                    Fluttertoast.showToast(
                                        msg: "Please Select Weight",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        fontSize: 16.0);
                                  } else {
                                    selectedIndexesloading.add(index);
                                    _loadingforapi.add(LoadingForapiModel(
                                        name: data.name,
                                        weight:
                                            dropdownValueWeightLoading[index],
                                        quantity: 1,
                                        image: data.image!));
                                    _loadingforapilocal.add(
                                        LoadingForapiModelWithImage(
                                            name: data.name,
                                            weight: dropdownValueWeightLoading[
                                                index],
                                            quantity: 1,
                                            image: data.image!));
                                  }
                                }
                              });
                              print(_loadingforapi);
                            },
                            tileColor: selectedIndexesloading.contains(index)
                                ? Constants.Primary
                                : null,
                            leading: Container(
                              height: 60,
                              width: 60,
                              child: Image(
                                  image: NetworkImage(
                                "${_loadingData.loadingData[0].data![index].image}",
                              )),
                            ),
                            // CircleAvatar(
                            //     backgroundColor:
                            //         selectedIndexesloading.contains(index)
                            //             ? Constants.Primary
                            //             : Colors.white,
                            //     radius: 30,
                            //     backgroundImage: NetworkImage(
                            //         "${_loadingData.loadingData[0].data![index].image}"))
                            //         ,
                            title: Text(
                              _loadingData.loadingData[0].data![index].name
                                  .toString(),
                              style: Constants.heading3.copyWith(
                                  color: selectedIndexesloading.contains(index)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            subtitle: data.name.toString().toLowerCase() == 'labour'
                                ? Text(' ')
                                : Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          dropdownValueWeightLoading[index] !=
                                                  "Weight"
                                              ? "${dropdownValueWeightLoading[index]} Tons"
                                              : "${dropdownValueWeightLoading[index]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Constants.Grey),
                                        ),
                                        DropDownMenuFb1(
                                            icon: Icon(Icons.arrow_drop_down),
                                            menuList: [
                                              PopupMenuItem(
                                                child: SizedBox(
                                                  // height: 170,
                                                  width: 150,
                                                  child: Column(
                                                    children: [
                                                      ListView.builder(
                                                          shrinkWrap: true,
                                                          physics:
                                                              ScrollPhysics(),
                                                          itemBuilder:
                                                              (context, ind) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                              child:
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                        // print(
                                                                        //   _materialController
                                                                        //       .Materialdata[0]
                                                                        //       .data[index]
                                                                        //       .name,
                                                                        // );
                                                                      },
                                                                      child:
                                                                          ListTile(
                                                                        onTap:
                                                                            () {
                                                                          // print(
                                                                          //     "${_vehicledata.selectedVehicles[index].weights![ind]}");
                                                                          setState(
                                                                              () {
                                                                            dropdownValueWeightLoading[index] =
                                                                                "${_loadingData.loadingData[0].data![index].weight![ind]}";
                                                                          });
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        title:
                                                                            Text(
                                                                          "${_loadingData.loadingData[0].data![index].weight![ind]}",
                                                                          style:
                                                                              Constants.regular5,
                                                                        ),
                                                                      )),
                                                            );
                                                          },
                                                          itemCount: _loadingData
                                                                      .loadingData[
                                                                          0]
                                                                      .data![
                                                                          index]
                                                                      .weight ==
                                                                  null
                                                              ? 0
                                                              : _loadingData
                                                                  .loadingData[
                                                                      0]
                                                                  .data![index]
                                                                  .weight
                                                                  .length),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10),
                                                            width: 105,
                                                            child: TextField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              controller:
                                                                  loadingotherweightController,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "   Other",
                                                              ),
                                                            ),
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                if (num.parse(loadingotherweightController
                                                                            .text) >=
                                                                        210 ||
                                                                    num.parse(loadingotherweightController
                                                                            .text) <=
                                                                        0) {
                                                                  Fluttertoast.showToast(
                                                                      msg:
                                                                          "Please Enter Weight Less Than 250 Tons",
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_SHORT,
                                                                      gravity:
                                                                          ToastGravity
                                                                              .BOTTOM,
                                                                      fontSize:
                                                                          16.0);
                                                                } else {
                                                                  setState(() {
                                                                    dropdownValueWeightLoading[
                                                                            index] =
                                                                        loadingotherweightController
                                                                            .text;
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                  loadingotherweightController
                                                                      .clear();
                                                                }
                                                              },
                                                              icon: Icon(Icons
                                                                  .add_circle))
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
                                                  color: selectedIndexesloading
                                                          .contains(index)
                                                      ? Colors.white
                                                      : Color(0xff2F4D84),
                                                  width: 3))),
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(20, 20)),
                                      maximumSize: MaterialStateProperty.all(
                                          const Size(39, 36)),
                                    ),
                                    onPressed: !selectedIndexesloading
                                            .contains(index)
                                        ? null
                                        : () {
                                            if (_loadingcounter[index] > 1) {
                                              setState(() {
                                                _loadingcounter[index] -= 1;
                                                var indextoremove =
                                                    _loadingforapi.indexWhere(
                                                        (element) =>
                                                            element.name ==
                                                            _loadingData
                                                                .loadingData[0]
                                                                .data![index]
                                                                .name);
                                                _loadingforapi
                                                    .removeAt(indextoremove);
                                                _loadingforapilocal
                                                    .removeAt(indextoremove);
                                              });
                                            }
                                          },
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: selectedIndexesloading
                                                  .contains(index)
                                              ? Colors.white
                                              : Color(0xff2F4D84)),
                                    )),
                                Text(
                                  !selectedIndexesloading.contains(index)
                                      ? "0"
                                      : _loadingcounter[index].toString(),
                                  style: TextStyle(
                                      color:
                                          selectedIndexesloading.contains(index)
                                              ? Colors.white
                                              : Color(0xff2F4D84)),
                                ),
                                OutlinedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(),
                                      )),
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(20, 20)),
                                      maximumSize: MaterialStateProperty.all(
                                          const Size(39, 36)),
                                    ),
                                    onPressed: !selectedIndexesloading
                                            .contains(index)
                                        ? null
                                        : () {
                                            setState(() {
                                              if (dropdownValueWeightUnLoading[
                                                          index] ==
                                                      "Weight" &&
                                                  data.name.toString().toLowerCase() != 'labour') {
                                                Fluttertoast.showToast(
                                                    msg: "Please Select Weight",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    fontSize: 16.0);
                                              } else {
                                                _loadingcounter[index]++;
                                                if (!selectedIndexesloading
                                                    .contains(index)) {
                                                  selectedIndexesloading
                                                      .add(index);
                                                }
                                                _loadingforapi.add(
                                                    LoadingForapiModel(
                                                        name: data.name,
                                                        weight:
                                                            "${dropdownValueWeightUnLoading[index]}",
                                                        quantity: 1,
                                                        image: data.image!));
                                                _loadingforapilocal.add(
                                                    LoadingForapiModelWithImage(
                                                        name: data.name,
                                                        weight:
                                                            "${dropdownValueWeightUnLoading[index]}",
                                                        quantity: 1,
                                                        image: data.image!));
                                              }
                                            });
                                          },
                                    child: Text(
                                      "+",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: selectedIndexesloading
                                                  .contains(index)
                                              ? Colors.white
                                              : Color(0xff2F4D84)),
                                    )),
                              ],
                            ),
                          ),
                        );
                      });
                }
              }),

              // if (widget.type == 0)
              Obx(() {
                if (_loadingData.loadingData.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top:55, bottom: 55),
                  child: Text("No unloading option in the database", style: Constants.heading2,textAlign: TextAlign.center,),
                );
              }
                if (_unloadingData.isLoading == true) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 14.0, left: 8),
                          child: Text(
                            "Select Unloading Option(Optional)",
                            style: Constants.heading3,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                _unloadingData.unloadingData[0].data!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (_unloadinguncounter.length <
                                  _unloadingData
                                      .unloadingData[0].data!.length) {
                                _unloadinguncounter.add(1);
                              }
                              if (dropdownValueWeightUnLoading.length <
                                  _unloadingData
                                      .unloadingData[0].data!.length) {
                                dropdownValueWeightUnLoading.add("Weight");
                              }
                              final data =
                                  _unloadingData.unloadingData[0].data![index];

                              return Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: ListTile(
                                    subtitle:
                                        _unloadingData.unloadingData[0]
                                                    .data![index].name.toString().toLowerCase() !=
                                                "labour"
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      dropdownValueWeightUnLoading[
                                                                  index] !=
                                                              "Weight"
                                                          ? "${dropdownValueWeightUnLoading[index]} Tons"
                                                          : "${dropdownValueWeightUnLoading[index]}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Constants.Grey),
                                                    ),
                                                    DropDownMenuFb1(
                                                        icon: Icon(Icons
                                                            .arrow_drop_down),
                                                        menuList: [
                                                          PopupMenuItem(
                                                            child: SizedBox(
                                                              // height: 170,
                                                              width: 150,
                                                              child: Column(
                                                                children: [
                                                                  ListView
                                                                      .builder(
                                                                          shrinkWrap:
                                                                              true,
                                                                          physics:
                                                                              ScrollPhysics(),
                                                                          itemBuilder: (context,
                                                                              ind) {
                                                                            return Padding(
                                                                              padding: const EdgeInsets.only(left: 10),
                                                                              child: GestureDetector(
                                                                                  onTap: () {
                                                                                    Navigator.pop(context);
                                                                                    // print(
                                                                                    //   _materialController
                                                                                    //       .Materialdata[0]
                                                                                    //       .data[index]
                                                                                    //       .name,
                                                                                    // );
                                                                                  },
                                                                                  child: ListTile(
                                                                                    onTap: () {
                                                                                      // print(
                                                                                      //     "${_vehicledata.selectedVehicles[index].weights![ind]}");
                                                                                      setState(() {
                                                                                        dropdownValueWeightUnLoading[index] = "${_unloadingData.unloadingData[0].data![index].weight![ind]}";
                                                                                      });
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    title: Text(
                                                                                      "${_unloadingData.unloadingData[0].data![index].weight![ind]}",
                                                                                      style: Constants.regular5,
                                                                                    ),
                                                                                  )),
                                                                            );
                                                                          },
                                                                          itemCount: _unloadingData.unloadingData[0].data![index].weight == null
                                                                              ? 0
                                                                              : _unloadingData.unloadingData[0].data![index].weight.length),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 10),
                                                                        width:
                                                                            105,
                                                                        child:
                                                                            TextField(
                                                                          keyboardType:
                                                                              TextInputType.number,
                                                                          controller:
                                                                              unloadingotherweightController,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            hintText:
                                                                                "   Other",
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            if (num.parse(unloadingotherweightController.text) >=
                                                                                250) {
                                                                              Fluttertoast.showToast(msg: "Please Enter Weight Less Than 250 Tons", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 16.0);
                                                                            } else {
                                                                              setState(() {
                                                                                dropdownValueWeightUnLoading[index] = unloadingotherweightController.text;
                                                                              });
                                                                              Navigator.pop(context);
                                                                              unloadingotherweightController.clear();
                                                                            }
                                                                          },
                                                                          icon:
                                                                              Icon(Icons.add_circle))
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ]),
                                                  ],
                                                ),
                                              )
                                            : SizedBox(),

                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        OutlinedButton(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: BorderSide(
                                                          color:
                                                              selectedIndexesunloading
                                                                      .contains(
                                                                          index)
                                                                  ? Colors.white
                                                                  : Color(
                                                                      0xff2F4D84),
                                                          width: 3))),
                                              minimumSize:
                                                  MaterialStateProperty.all(
                                                      const Size(20, 20)),
                                              maximumSize:
                                                  MaterialStateProperty.all(
                                                      const Size(39, 36)),
                                            ),
                                            onPressed:
                                                !selectedIndexesunloading
                                                        .contains(index)
                                                    ? null
                                                    : () {
                                                        if (_unloadinguncounter[
                                                                index] >
                                                            1) {
                                                          setState(() {
                                                            _unloadinguncounter[
                                                                index] -= 1;

                                                            // unLoadingOptionsName[
                                                            //         "${_unloadingData.unloadingData[0].data![index].name} ${_unloadingData.unloadingData[0].data![index].weight}"]
                                                            //     [1] -= 1;
                                                            setState(() {
                                                              _unloadinguncounter[
                                                                  index] -= 1;
                                                              var indextoremove = _unloadingforapi.indexWhere((element) =>
                                                                  element
                                                                      .name ==
                                                                  _unloadingData
                                                                      .unloadingData[
                                                                          0]
                                                                      .data![
                                                                          index]
                                                                      .name);
                                                              _unloadingforapi
                                                                  .removeAt(
                                                                      indextoremove);
                                                              _unloadingforapilocal
                                                                  .removeAt(
                                                                      indextoremove);
                                                            });
                                                          });
                                                        }
                                                      },
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      selectedIndexesunloading
                                                              .contains(index)
                                                          ? Colors.white
                                                          : Color(0xff2F4D84)),
                                            )),
                                        Text(
                                          !selectedIndexesunloading
                                                  .contains(index)
                                              ? "0"
                                              : _unloadinguncounter[index]
                                                  .toString(),
                                          style: TextStyle(
                                              color: selectedIndexesunloading
                                                      .contains(index)
                                                  ? Colors.white
                                                  : Color(0xff2F4D84)),
                                        ),
                                        OutlinedButton(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(),
                                              )),
                                              minimumSize:
                                                  MaterialStateProperty.all(
                                                      const Size(20, 20)),
                                              maximumSize:
                                                  MaterialStateProperty.all(
                                                      const Size(39, 36)),
                                            ),
                                            onPressed: !selectedIndexesunloading
                                                    .contains(index)
                                                ? null
                                                : () {
                                                    setState(() {
                                                      if (dropdownValueWeightUnLoading[
                                                                  index] ==
                                                              "Weight" &&
                                                          data.name.toString().toLowerCase() !=
                                                              'labour') {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Please Select Weight",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            fontSize: 16.0);
                                                      } else {
                                                        if (!selectedIndexesunloading
                                                            .contains(index)) {
                                                          selectedIndexesloading
                                                              .add(index);
                                                        }
                                                        _unloadinguncounter[
                                                            index]++;
                                                        _unloadingforapi.add(
                                                            UnLoadingForapiModel(
                                                                name: data.name,
                                                                weight:
                                                                    "${dropdownValueWeightUnLoading[index]}",
                                                                quantity: 1,
                                                                image: data
                                                                    .image!));
                                                        _unloadingforapilocal.add(
                                                            UnLoadingForapiModelWithImage(
                                                                name: data.name,
                                                                weight:
                                                                    "${dropdownValueWeightUnLoading[index]}",
                                                                quantity: 1,
                                                                image: data
                                                                    .image!));
                                                      }
                                                    });
                                                  },
                                            child: Text(
                                              "+",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      selectedIndexesunloading
                                                              .contains(index)
                                                          ? Colors.white
                                                          : Color(0xff2F4D84)),
                                            )),
                                      ],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (selectedIndexesunloading
                                            .contains(index)) {
                                          selectedIndexesunloading
                                              .remove(index);
                                          _unloadingforapi.removeWhere(
                                              (element) =>
                                                  element.name == data.name);
                                          _unloadinguncounter[index] = 1;
                                          //
                                          _unloadingforapilocal.removeWhere(
                                              (element) =>
                                                  element.name == data.name);
                                        } else {
                                          if (dropdownValueWeightUnLoading[
                                                      index] ==
                                                  "Weight" &&
                                              data.name.toString().toLowerCase() != 'labour') {
                                            Fluttertoast.showToast(
                                                msg: "Please Select Weight",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                fontSize: 16.0);
                                          } else {
                                            selectedIndexesunloading.add(index);
                                            _unloadingforapi.add(
                                                UnLoadingForapiModel(
                                                    name: data.name,
                                                    weight:
                                                        "${dropdownValueWeightUnLoading[index]}",
                                                    quantity: 1,
                                                    image: data.image!));
                                            _unloadingforapilocal.add(
                                                UnLoadingForapiModelWithImage(
                                                    name: data.name,
                                                    weight:
                                                        "${dropdownValueWeightUnLoading[index]}",
                                                    quantity: 1,
                                                    image: data.image!));
                                          }
                                        }
                                      });
                                      print(_unloadingforapilocal);
                                    },
                                    tileColor:
                                        selectedIndexesunloading.contains(index)
                                            ? Constants.Primary
                                            : null,
                                    leading: Container(
                                      height: 60,
                                      width: 60,
                                      child: Image(
                                          image: NetworkImage(
                                        "${_unloadingData.unloadingData[0].data![index].image}",
                                      )),
                                    ),
                                    //  CircleAvatar(
                                    //     backgroundColor:
                                    //         selectedIndexesunloading
                                    //                 .contains(index)
                                    //             ? Constants.Primary
                                    //             : Constants.White,
                                    //     radius: 30,
                                    //     backgroundImage: NetworkImage(
                                    //         "${_unloadingData.unloadingData[0].data![index].image}")),

                                    title: Text(
                                      "${_unloadingData.unloadingData[0].data![index].name}",
                                      style: Constants.heading3.copyWith(
                                          color: selectedIndexesunloading
                                                  .contains(index)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ));
                            }),
                      )
                    ],
                  );
                }
              }),

              //Spacer(),
              CustomBtn(
                  text: 'Save',
                  onpreased: () {
                    checkWeight();
                    //  print(dropdownValueWeightLoading.contains((element) => element=="Weight"));

                    _loadingData.selecteddataforApi = _loadingforapi;
                    _loadingData.selecteddataforapi2 = _loadingforapilocal;
                    _unloadingData.selecteddataforApi = _unloadingforapi;
                    _unloadingData.selecteddataforapi2 = _unloadingforapilocal;
                    //  await _loadingData.getallValuesLoading();
                    //  await _unloadingData.getallValues();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => VehicleSelectionHomePage(
                                  pickupLatLng: widget.pickupLatLng,
                                  dropOffLatLng: widget.dropOffLatLng,
                                  pickup_address: widget.pickup_address,
                                  dropOff_address: widget.dropOff_address,
                                  containerDropOff: widget.containerDropOff,
                                  markers: widget.markers,
                                  polyline: widget.polyline,
                                  type: widget.type,
                                )));
                  },
                  outlinebtn: false),
              // CustomBtn(
              //     text: 'Save',
              //     onpreased: () {
              //       print(_loadingData.selecteddataforApi);
              //       // _unloadingData.addtoHomeScreen("-N03A0PV8hEb9g592LRf");

              //       // Navigator.push(
              //       //     context,
              //       //     MaterialPageRoute(
              //       //         builder: (_) => VehicleSelectionHomePage(
              //       //               type: widget.type,
              //       //             )));
              //     },
              //     outlinebtn: false)
            ],
          ),
        ),
      ),
    );
  }

  checkWeight() {
    print("Function is running");
    List indexedList = [];
    for (var i = 0; i > dropdownValueWeightLoading.length; i++) {
      print(i);
      if (dropdownValueWeightLoading[i] != "Weight") {
        indexedList.add(i);
        print(indexedList);
      }
      if (dropdownValueWeightLoading[i] == "Weight") {
        print("Weight is not selected");
      }
      //   Fluttertoast.showToast(
      //       msg: "Please Select Weight",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //       timeInSecForIosWeb: 1,
      //       fontSize: 16.0);
    }
  }
}

// UnLoadingSelectedOptions selectedOptitions = UnLoadingSelectedOptions();
