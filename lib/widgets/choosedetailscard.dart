import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meribiltyapp/Api%20Services/ppl/create_request.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/get%20vehicle%20data/vehicle_data_getx_controller.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/materials/get_material_controller.dart';
import 'package:meribiltyapp/Api%20Services/vehicle%20selection/get_vehicle_service_with_getx.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/ppl/finding_best_qoute.dart';
import 'package:meribiltyapp/screens/ppl/select_location.dart';
import 'package:meribiltyapp/screens/ppl/select_vehicles.dart';
import 'package:meribiltyapp/widgets/animated_toggle.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/selectedbtn.dart';
import 'package:meribiltyapp/widgets/transit/cargovalue.dart';
import 'package:meribiltyapp/widgets/vehicle%20selection%20pages/VehicleSelectionHome.dart';
import 'package:meribiltyapp/widgets/vehicle%20selection%20pages/vehicle_and_select_1.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class ChooseDetailsCard extends StatefulWidget {
  ChooseDetailsCard(
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
  LatLng pickupLatLng;
  LatLng dropOffLatLng;
  String pickup_address;
  String dropOff_address;
  String containerDropOff;
  List<Marker>? markers;
  final Set<Polyline>? polyline;
  final int type;

  @override
  _ChooseDetailsCardState createState() => _ChooseDetailsCardState();
}

class _ChooseDetailsCardState extends State<ChooseDetailsCard> {
  VehicleDataStrp1Controller _vehicleDataStrp1Controller =
      Get.put(VehicleDataStrp1Controller());
  GetMaterialsController _materialData = Get.put(GetMaterialsController());
  bool vehivledataLoaded = false;
  // GetVehicleController _getVehicleController = Get.put(GetVehicleController());
  DateTime? dateTime;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.96,
        decoration: BoxDecoration(
          color: Constants.White,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.type == 0 ? "Transit" : "Nationwide",
                style: Constants.heading3.copyWith(color: Constants.Primary),
                textAlign: TextAlign.center,
              ),
              SelectedBtn(
                  isdata: true,
                  text: "Location Selected",
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SelectLocation()));
                  },
                  outlinebtn: false),
              SelectedBtn(
                  // isdata: false,
                  isdata: _vehicleDataStrp1Controller.finaldata.length == 0
                      ? false
                      : true,
                  text: "Select Vehicle & Details",
                  onPressed: () {
                    // print(_getVehicleController.vehicleList);
                    // vehivledataLoaded
                    //     ? () {}
                    //     : _getVehicleController.fetchVehicle();
                    // vehivledataLoaded = true;
                    _vehicleDataStrp1Controller.fetchVehicleStep1();
                    _materialData.fetchMaterial();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VehicleSelectionHomePage(
                                  type: widget.type,
                                  pickupLatLng: widget.pickupLatLng,
                                  dropOffLatLng: widget.dropOffLatLng,
                                  pickup_address: widget.pickup_address,
                                  dropOff_address: widget.dropOff_address,
                                  containerDropOff: widget.containerDropOff,
                                  markers: widget.markers,
                                  polyline: widget.polyline,
                                )));
                  },
                  outlinebtn: false),
              CargoValueSection(),
              CustomBtn(
                  text: "Book Now or Schedule",
                  onpreased: () async {
                    dateTime = await showOmniDateTimePicker(
                        is24HourMode: false,
                        isShowSeconds: false,
                        primaryColor: Constants.Primary,
                        context: context,
                        startFirstDate: DateTime.now(),
                        startInitialDate:
                            DateTime.now().roundUp(delta: Duration(hours: 1)));
                    // print("${dateTime!.day} ${dateTime!.month} ${dateTime!.year} ${DateFormat('hh:mm a').format(dateTime!)}".runtimeType);
                    // print(DateFor)
                    dateTime != null
                        ? CreateRequest().createRequest(
                            time: dateTime,
                            type: widget.type == 0 ? "transit" : "upcountry",
                            cargo_insurance: isInsuranceChecked,
                            desLat: this.widget.dropOffLatLng.latitude,
                            desLng: this.widget.dropOffLatLng.longitude,
                            desText: this.widget.dropOff_address,
                            disText: "1 mi",
                            orgLat: this.widget.pickupLatLng.latitude,
                            orgLng: this.widget.pickupLatLng.longitude,
                            orgText: this.widget.pickup_address,
                            originAddress: this.widget.pickup_address,
                            destinationAddress: this.widget.dropOff_address,
                            containerReturn: this.widget.containerDropOff,
                            context: context)
                        : () {};
                  },
                  outlinebtn: false)
            ],
          ),
        ),
      ),
    );

    // return Card(
    //   color: Constants.BrightRed,
    //   elevation: 10,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       CustomBtn(
    //           text: "Select Vehicle", onpreased: () {}, outlinebtn: false),
    //       CustomBtn(
    //           text: "Select Vehicle", onpreased: () {}, outlinebtn: false)
    //     ],
    //   ),
    // );
  }
}

extension on DateTime {
  DateTime roundDown({Duration delta = const Duration(seconds: 15)}) {
    return DateTime.fromMillisecondsSinceEpoch(this.millisecondsSinceEpoch -
        this.millisecondsSinceEpoch % delta.inMilliseconds);
  }

  DateTime roundUp({Duration delta = const Duration(seconds: 15)}) {
    return DateTime.fromMillisecondsSinceEpoch(this.millisecondsSinceEpoch +
        delta.inMilliseconds -
        this.millisecondsSinceEpoch % delta.inMilliseconds);
  }
}
