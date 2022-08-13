import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meribiltyapp/Api%20Services/ppl/create_request.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/get%20vehicle%20data/vehicle_data_getx_controller.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/loading/get_loading_controller.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/unloading/get_unloading_option_controller.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/unloading/unloading_options_locally.dart';
import 'package:meribiltyapp/Api%20Services/vehicle%20selection/vehicle_selection_data_service.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/ppl/home.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/transit/cargovalue.dart';
import 'package:meribiltyapp/widgets/vehicle%20selection%20pages/option_selection.dart';
import 'package:meribiltyapp/widgets/vehicle%20selection%20pages/vehicle_and_select_1.dart';
import 'package:meribiltyapp/widgets/vehicle%20selection%20pages/vehicle_selection_temporary_page.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class VehicleSelectionHomePage extends StatefulWidget {
  VehicleSelectionHomePage({
    Key? key,
    required this.pickupLatLng,
    required this.dropOffLatLng,
    required this.pickup_address,
    required this.dropOff_address,
    required this.containerDropOff,
    required this.markers,
    required this.polyline,
    required this.type,
  }) : super(key: key);
  LatLng? pickupLatLng;
  LatLng? dropOffLatLng;
  String? pickup_address;
  String? dropOff_address;
  String? containerDropOff;
  List<Marker>? markers;
  final Set<Polyline>? polyline;
  final int type;

  @override
  State<VehicleSelectionHomePage> createState() =>
      _VehicleSelectionHomePageState();
}

class _VehicleSelectionHomePageState extends State<VehicleSelectionHomePage> {
  final _vehicledata = Get.put(VehicleDataStrp1Controller());
  final _loadingData = Get.put(LoadingDataController());
  final _unloadingData = Get.put(UnloadingDataController());
  String image = 'assets/images/vehicle_images/suzuki.png';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => PPLHome(
                      pickupLatLng: widget.pickupLatLng,
                      dropOffLatLng: widget.dropOffLatLng,
                      pickup_address: widget.pickup_address,
                      dropOff_address: widget.dropOff_address,
                      containerDropOff: widget.containerDropOff,
                      type: widget.type,
                      polyline: widget.polyline,
                      markers: widget.markers,
                    )));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text(
                'Vehicles & Details',
                style: Constants.heading3.copyWith(color: Colors.white),
              ),
              //   Text(
              //   'Selected Vehicle',
              //   style: Constants.heading3.copyWith(color: Colors.white),
              // ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Constants.Primary,
          leading: InkWell(
            child: Icon(FontAwesomeIcons.chevronLeft),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PPLHome(
                            pickupLatLng: widget.pickupLatLng,
                            dropOffLatLng: widget.dropOffLatLng,
                            pickup_address: widget.pickup_address,
                            dropOff_address: widget.dropOff_address,
                            containerDropOff: widget.containerDropOff,
                            type: widget.type,
                            polyline: widget.polyline,
                            markers: widget.markers,
                          )));
              // Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text("Selected Vehicles",
                    style:
                        Constants.heading2.copyWith(color: Constants.Primary)),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    children: [
                      _vehicledata.finaldataLocal.length == 0
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(13),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                VehicleStep1SelectionTemp(
                                                  type: widget.type,
                                                  pickupLatLng:
                                                      widget.pickupLatLng,
                                                  dropOffLatLng:
                                                      widget.dropOffLatLng,
                                                  pickup_address:
                                                      widget.pickup_address,
                                                  dropOff_address:
                                                      widget.dropOff_address,
                                                  containerDropOff:
                                                      widget.containerDropOff,
                                                  polyline: widget.polyline,
                                                  markers: widget.markers,
                                                )));
                                  },
                                  child: Text(
                                    "No Vehicle Selected",
                                    style: Constants.heading4
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: _vehicledata.finaldataLocal.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Container(
                                    height: 60,
                                    width: 60,
                                    child: Image(
                                        image: NetworkImage(
                                      "${_vehicledata.finaldataLocal[index].image}",
                                    )),
                                  ),
                                  //  CircleAvatar(
                                  //   backgroundColor: Colors.white,
                                  //   radius: 30,
                                  //   backgroundImage: NetworkImage(
                                  //       "${_vehicledata.finaldataLocal[index].image}"),
                                  // ),
                                  title: Text(
                                    "${_vehicledata.finaldataLocal[index].name}",
                                    style: Constants.heading4
                                        .copyWith(color: Constants.Black),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                          "${_vehicledata.finaldataLocal[index].weight} Ton"),
                                      //Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18.0),
                                        child: Text(
                                            '${_vehicledata.selectedMaterials[index]}'),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _vehicledata.finaldataLocal
                                              .removeAt(index);
                                          _vehicledata.finaldata
                                              .removeAt(index);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.cancel_outlined,
                                        color: Constants.BrightRed,
                                      )),
                                );
                              }),

                      // Loading and unloading
                      Center(
                        child: Text("Selected Loading Options",
                            style: Constants.heading2
                                .copyWith(color: Constants.Primary)),
                      ),
                      _loadingData.selecteddataforApi.length == 0
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(13),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                SelectLoadingUnloadingOption(
                                                  type: widget.type,
                                                  pickupLatLng:
                                                      widget.pickupLatLng,
                                                  dropOffLatLng:
                                                      widget.dropOffLatLng,
                                                  pickup_address:
                                                      widget.pickup_address,
                                                  dropOff_address:
                                                      widget.dropOff_address,
                                                  containerDropOff:
                                                      widget.containerDropOff,
                                                  polyline: widget.polyline,
                                                  markers: widget.markers,
                                                )));
                                  },
                                  child: Text(
                                    "No Loading Option Selected",
                                    style: Constants.heading4
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: _loadingData.selecteddataforApi.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _loadingData.selecteddataforApi
                                              .removeAt(index);
                                          _loadingData.selecteddataforapi2
                                              .removeAt(index);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.cancel_outlined,
                                        color: Constants.BrightRed,
                                      )),
                                  leading: 
                                   Container(
                           height: 60,
                           width: 60,
                          child: Image(
                            image: NetworkImage("${_loadingData.selecteddataforapi2[index].image}",)
                          ) ,),
                                  // CircleAvatar(
                                  //   radius: 30,
                                  //   backgroundColor: Colors.white,
                                  //   backgroundImage: Image(
                                  //     image: NetworkImage(
                                  //         "${_loadingData.selecteddataforapi2[index].image}",
                                  //         scale: 0.1),
                                  //   ).image,
                                  // ),
                                  title: Text(
                                    "${_loadingData.selecteddataforApi[index].name}",
                                    style: Constants.heading4
                                        .copyWith(color: Constants.Black),
                                  ),
                                  // trailing: IconButton(
                                  //     onPressed: () {
                                  //       _loadingData.getallValuesLoading();
                                  //     },
                                  //     icon: Icon(
                                  //       Icons.delete_forever_outlined,
                                  //       color: Constants.BrightRed,
                                  //     )),
                                  subtitle: Text(
                                    _loadingData.selecteddataforapi2[index]
                                                .name ==
                                            "Labor"
                                        ? ' '
                                        : "${_loadingData.selecteddataforapi2[index].weight} Tons",
                                    // style: Constants.heading4
                                    //     .copyWith(color: Constants.Black),
                                  ),
                                );
                              }),
                      Center(
                        child: Text("Selected Unloading Options",
                            style: Constants.heading2
                                .copyWith(color: Constants.Primary)),
                      ),
                      _unloadingData.selecteddataforapi2.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(13),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                SelectLoadingUnloadingOption(
                                                  type: widget.type,
                                                  pickupLatLng:
                                                      widget.pickupLatLng,
                                                  dropOffLatLng:
                                                      widget.dropOffLatLng,
                                                  pickup_address:
                                                      widget.pickup_address,
                                                  dropOff_address:
                                                      widget.dropOff_address,
                                                  containerDropOff:
                                                      widget.containerDropOff,
                                                  polyline: widget.polyline,
                                                  markers: widget.markers,
                                                )));
                                  },
                                  child: Text(
                                    "No Unloading Option Selected",
                                    style: Constants.heading4
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount:
                                  _unloadingData.selecteddataforApi.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _unloadingData.selecteddataforApi
                                              .removeAt(index);
                                          _unloadingData.selecteddataforapi2
                                              .removeAt(index);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.cancel_outlined,
                                        color: Constants.BrightRed,
                                      )),
                                  leading:
                                   Container(
                           height: 60,
                           width: 60,
                          child: Image(
                            image: NetworkImage( "${_unloadingData.selecteddataforapi2[index].image}",)
                          ) ,),
                                  //  CircleAvatar(
                                  //   backgroundColor: Colors.white,
                                  //   radius: 30,
                                  //   backgroundImage: NetworkImage(
                                  //       "${_unloadingData.selecteddataforapi2[index].image}"),
                                  // ),
                                  title: Text(
                                    "${_unloadingData.selecteddataforapi2[index].name}",
                                    style: Constants.heading4
                                        .copyWith(color: Constants.Black),
                                  ),
                                  // trailing: IconButton(
                                  //     onPressed: () {},
                                  //     icon: Icon(
                                  //       Icons.delete_forever_outlined,
                                  //       color: Constants.BrightRed,
                                  //     )),
                                  subtitle: Text(_unloadingData
                                              .selecteddataforapi2[index]
                                              .name ==
                                          "Labor"
                                      ? ' '
                                      : "${_unloadingData.selecteddataforApi[index].weight} Tons",),
                                );
                              })
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 19),
                    child: CustomBtn2(
                        text: "   Select Vehicle   ",
                        onpreased: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => VehicleStep1SelectionTemp(
                                        type: widget.type,
                                        pickupLatLng: widget.pickupLatLng,
                                        dropOffLatLng: widget.dropOffLatLng,
                                        pickup_address: widget.pickup_address,
                                        dropOff_address: widget.dropOff_address,
                                        containerDropOff:
                                            widget.containerDropOff,
                                        polyline: widget.polyline,
                                        markers: widget.markers,
                                      )));
                        },
                        outlinebtn: false),
                  ),
                  //Spacer(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: CustomBtn2(
                          text: "Select \nLoading/Unloading",
                          onpreased: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SelectLoadingUnloadingOption(
                                          type: widget.type,
                                          pickupLatLng: widget.pickupLatLng,
                                          dropOffLatLng: widget.dropOffLatLng,
                                          pickup_address: widget.pickup_address,
                                          dropOff_address: widget.dropOff_address,
                                          containerDropOff:
                                              widget.containerDropOff,
                                          polyline: widget.polyline,
                                          markers: widget.markers,
                                        )));
                          },
                          outlinebtn: false),
                    ),
                  ),
                ],
              ),
              CustomBtn(
                  text: "Book Now or Schedule",
                  // onpreased: () {
                  //   Navigator.pop(context);
                  //   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>PPLHome(type: widget.type)));
                  //   // print(widget.type);
                  //   // Navigator.pushReplacement(
                  //   //             context,
                  //   //             MaterialPageRoute(
                  //   //                 builder: (_) => PPLHome(
                  //   //                       type: widget.type,
                  //   //                     )));
                  // },
                  onpreased: () async {
                    // Navigator.
                    dateTime = await showOmniDateTimePicker(
                        primaryColor: Constants.Primary,
                        context: context,
                        startFirstDate: DateTime.now(),
                        startInitialDate: DateTime.now().roundUp(delta: Duration(hours: 1)));
                    // print(dateTime);
                    // print([isInsuranceChecked,this.widget.dropOffLatLng!.latitude,this.widget.dropOffLatLng!.longitude,this.widget.dropOff_address,
                    // this.widget.pickupLatLng!.latitude,this.widget.pickupLatLng!.longitude,this.widget.pickup_address,this.widget.dropOff_address,

                    // ]);
                    dateTime != null
                        ? CreateRequest().createRequest(
                            time: dateTime,
                            type: widget.type == 0 ? "transit" : "upcountry",
                            cargo_insurance: isInsuranceChecked,
                            desLat: this.widget.dropOffLatLng!.latitude,
                            desLng: this.widget.dropOffLatLng!.longitude,
                            desText: this.widget.dropOff_address,
                            disText: "1 mi",
                            orgLat: this.widget.pickupLatLng!.latitude,
                            orgLng: this.widget.pickupLatLng!.longitude,
                            orgText: this.widget.pickup_address,
                            originAddress: this.widget.pickup_address,
                            destinationAddress: this.widget.dropOff_address,
                            containerReturn: this.widget.containerDropOff,
                            context: context)
                        : () {};
                  },
                  outlinebtn: false),
            ],
          ),
        ),
      ),
    );
  }

  DateTime? dateTime;
  //  UnLoadingSelectedOptions selectedOptitions = UnLoadingSelectedOptions();
}

// 
extension on DateTime{

  DateTime roundDown({Duration delta = const Duration(seconds: 15)}){
    return DateTime.fromMillisecondsSinceEpoch(
        this.millisecondsSinceEpoch -
        this.millisecondsSinceEpoch % delta.inMilliseconds
    );
  }


  DateTime roundUp({Duration delta = const Duration(seconds: 15)}) {
    return DateTime.fromMillisecondsSinceEpoch(
        this.millisecondsSinceEpoch +
        delta.inMilliseconds -
        this.millisecondsSinceEpoch % delta.inMilliseconds
    );
  }
}