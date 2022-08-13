import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meribiltyapp/Api%20Services/selection%20services/get%20vehicle%20data/vehicle_data_getx_controller.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_deliveries.dart';
import 'package:meribiltyapp/screens/ppl/finding_best_qoute.dart';
import 'package:meribiltyapp/screens/ppl/select_vehicles.dart';
import 'package:meribiltyapp/widgets/animated_toggle.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/screens/home/drawer_User.dart';
import 'package:meribiltyapp/widgets/transit/cargovalue.dart';
import 'package:meribiltyapp/widgets/choosedetailscard.dart';

class PPLHome extends StatefulWidget {
  PPLHome(
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
  final type;

  @override
  State<PPLHome> createState() => _PPLHomeState();
}

class _PPLHomeState extends State<PPLHome> {
  LatLng? pickupLatLng;
  LatLng? dropOffLatLng;
  String? pickup_address;
  String? dropOff_address;
  String? containerDropOff;
  Completer<GoogleMapController> _GoogleMapController = Completer();
   VehicleDataStrp1Controller _vehicleDataStrp1Controller =
      Get.put(VehicleDataStrp1Controller());
  // @override
  // void initState() {
  //   // setState(() {
  //   //   pickupLatLng = this.widget.pickupLatLng;
  //   //   dropOffLatLng = this.widget.dropOffLatLng;
  //   //   pickup_address = this.widget.pickup_address;
  //   //   dropOff_address = this.widget.dropOff_address;
  //   //   containerDropOff = this.widget.containerDropOff;

  //   // });
  //   // _GoogleMapController.
  //   super.initState();
  // }

  // GoogleMapController userMap;
  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(30.3753, 69.3451),
    zoom: 2.5,
  );

  // @override
  // void initState(){
  //    _GoogleMapController?.
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize : Size.fromHeight(60.0),
          child: AppBar(
            title: Image(
              image: AssetImage("assets/whitelogo1.png"),
              height: 40,
             // fit: BoxFit.fill,
            ),
            centerTitle: true,
            backgroundColor: Constants.Primary,
            elevation: 0,
            iconTheme: IconThemeData(color: Constants.White),
          ),
        ),
        drawer: Drawer(
          elevation: 5,
          child: SingleChildScrollView(
            child: Column(
              children: [CustomDrawerHeader(), CustomDrawerBody()],
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                initialCameraPosition: _initialCameraPosition,
                myLocationButtonEnabled: false,
                myLocationEnabled: false,
                zoomControlsEnabled: false,
                polylines: this.widget.polyline!,
                markers: Set<Marker>.of(this.widget.markers!),
                onMapCreated: (GoogleMapController controller) {
                  _GoogleMapController.complete(controller);
                },
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ChooseDetailsCard(
                  
                  pickupLatLng: this.widget.pickupLatLng!,
                  dropOffLatLng: this.widget.dropOffLatLng!,
                  pickup_address: this.widget.pickup_address!,
                  dropOff_address: this.widget.dropOff_address!,
                  containerDropOff: this.widget.containerDropOff!,
                  markers: widget.markers,
                  polyline: widget.polyline,
                  type: widget.type,
                  

                )),
          ],
        ));
  }
}

void selectDateAndTimeModel(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext buildcontext) {
        return AnimatedContainer(
            duration: Duration(seconds: 1),
            height: MediaQuery.of(context).size.height * .60,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [],
              ),
            ));
      });
}
