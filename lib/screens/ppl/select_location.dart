import 'dart:async';

import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:meribiltyapp/Api%20Services/vehicle%20selection/get_vehicle_service_with_getx.dart';

import 'package:meribiltyapp/config/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_deliveries.dart';
import 'package:meribiltyapp/screens/ppl/finding_best_qoute.dart';
import 'package:meribiltyapp/screens/ppl/home.dart';
import 'package:meribiltyapp/screens/ppl/select_vehicles.dart';
import 'package:meribiltyapp/widgets/animated_toggle.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/screens/home/drawer_User.dart';
import 'package:meribiltyapp/widgets/selectionlocation.dart';
import 'package:meribiltyapp/widgets/transit/cargovalue.dart';
import 'package:meribiltyapp/widgets/choosedetailscard.dart';
import 'package:http/http.dart' as http;
import 'dart:math' show cos, sqrt, asin;

class SelectLocation extends StatefulWidget {
  const SelectLocation({Key? key}) : super(key: key);

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  // Constanst and variables
  Completer<GoogleMapController> _GoogleMapController = Completer();
  GetVehicleController _getVehicleController = Get.put(GetVehicleController());

  bool vehivledataLoaded = false;
  // GoogleMapController userMap;
  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: userPosition != null
        ? LatLng(userPosition!.latitude, userPosition!.longitude)
        : LatLng(24.8607343, 67.0011364),
    zoom: 2.5,
  );
  int toggle = 0;
  final _pickupLocationController = TextEditingController();
  final _destinationLocationController = TextEditingController();
  final _pickupLocationControllerTransit = TextEditingController();
  final _destinationLocationControllerTransit = TextEditingController();
  String containerDropLocation = "Empty Cntr Drop off/pickup point";
  GoogleMapController? mapController;
  String pickup_location = "Pickup Location";
  String destination_location = "Destination Location";
  String googleApikey = Platform.isIOS
      ? 'AIzaSyBXxcf3Di2qgyHc-M443-zOehNK--mmZ20'
      : 'AIzaSyAaXSllCLynjnJoJFP6a5T0Rg06SBx3_fY';
  var newlatlang;
  LatLng? pickupLatLng;
  LatLng? dropOffLatLng;
  LatLng? pickupLatLngTransit;
  LatLng? dropOffLatLngTransit;
  // List<Marker> _markerstransit = <Marker>[];
  // final Set<Polyline> _polylinetransit = {};
  // PolylinePoints? polylinePointstransit;
  // List<LatLng> polyLineCoordinatestransit = [];
  late Marker pickupMarkers;
  List<Marker> _markers = <Marker>[];
  final Set<Polyline> _polyline = {};
  PolylinePoints? polylinePoints;
  List<LatLng> polyLineCoordinates = [];

  void setPolyLines() async {
    PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
        "$googleApikey",
        PointLatLng(pickupLatLng!.latitude, pickupLatLng!.longitude),
        PointLatLng(dropOffLatLng!.latitude, dropOffLatLng!.longitude));
    if (result.status == "OK") {
      result.points.forEach((PointLatLng point) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {
        _polyline.add(Polyline(
            polylineId: PolylineId(
              'polyLine',
            ),
            width: 6,
            color: Colors.blue,
            points: polyLineCoordinates));
      });
    }
  }

//  This function show marker if usser selected current location
  setDefaultpickupMarker() {
    Marker pickupMarker = Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(userPosition!.latitude, userPosition!.longitude),
        infoWindow:
            InfoWindow(title: 'Pick up Location', snippet: 'Pick up Location'));
    setState(() {
      pickupMarkers = pickupMarker;
      // _markers.add(pickupMarker);
    });
  }

//  This function is used to get address from current location of user
  getAddress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        userPosition!.latitude, userPosition!.longitude);
    setState(() {
      _pickupLocationController.text =
          "${placemarks[0].name}, ${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].country}";
    });
    print(_pickupLocationController.text);
  }

  onToggleCallback(dynamic) => {toggle = dynamic};
  @override
  void initState() {
    super.initState();
    userPosition != null ? getAddress() : null;
    polylinePoints = PolylinePoints();
    userPosition != null ? setDefaultpickupMarker() : null;
  }

  setLocationPickup(location, LatLng locationCordinate) async {
    setState(() {
      pickup_location = location;
      _pickupLocationControllerTransit.text = location;
    });

    //form google_maps_webservice package

    pickupLatLng = locationCordinate;
    print(pickupLatLng);

    //move map camera to selected place with animation
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: pickupLatLng!, zoom: 4)));
    Marker pickupMarker = Marker(
        markerId: MarkerId('SomeId'),
        position: pickupLatLng!,
        infoWindow:
            InfoWindow(title: 'Pick up Location', snippet: 'Pick up Location'));
    setState(() {
      // if(_markers.co)
      // _markers.addIf(condition, item) = pickupMarker;
      if (_markers.isEmpty) {
        _markers.add(pickupMarker);
      } else {
        _polyline.clear();
        _markers[0] = pickupMarker;
      }
      // _markers.remove(value)
      setPolyLines();
    });
  }

  setLocationDropOff(location, LatLng locationCordinates) async {
    if (_pickupLocationControllerTransit.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please Select Pickup Location First",
        backgroundColor: Colors.white,
        colorText: Colors.red,
      );
    } else {
      setState(() {
        destination_location = location;
        _destinationLocationControllerTransit.text = location;
      });

      dropOffLatLng = locationCordinates;

      //move map camera to selected place with animation
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: dropOffLatLng!, zoom: 4)));
      // _markers.add();
      Marker dropOffmarker = Marker(
          markerId: MarkerId('SomeId 2'),
          position: dropOffLatLng!,
          infoWindow: InfoWindow(
              title: 'Drop of location', snippet: 'Drop of location'));
      setState(() {
        if (_markers.asMap().containsKey(1)) {
          _markers[1] = dropOffmarker;
        } else {
          _polyline.clear();
          _markers.add(dropOffmarker);
        }

        setPolyLines();
      });
    }
  }

  var backgroundColor = const Color(0xFFe7e7e8);
  var buttonColor = const Color(0xFFFFFFFF);
  var textColor = const Color(0xFF000000);
  List values = ['Transit', 'Upcountry'];
  int toggle_value = 0;
  bool initialPosition = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Select Location',
            style: Constants.heading3.copyWith(color: Constants.White),
          ),
          backgroundColor: Constants.Primary,
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
            // Google Map
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                polylines: _polyline,
                markers: Set<Marker>.of(_markers),
                initialCameraPosition: _initialCameraPosition,
                myLocationButtonEnabled: false,
                myLocationEnabled: false,
                onMapCreated: (controller) async {
                  LocationPermission permission =
                      await Geolocator.checkPermission();

                  //method called when map is created
                  setState(() {
                    mapController = controller;
                  });
                },
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    AnimatedToggle(
                      values: ['Transit', 'Nationwide'],
                      onToggleCallback: (Value) {
                        setState(() {
                          polyLineCoordinates.clear();
                          _markers.clear();

                          _polyline.clear();
                          _pickupLocationController.clear();
                          _destinationLocationController.clear();
                          _pickupLocationControllerTransit.clear();
                          _destinationLocationControllerTransit.clear();
                          toggle_value = Value;
                        });
                      },
                      buttonColor: Constants.Primary,
                      textColor: Constants.White,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Constants.White,
                        ),
                        child: toggle_value == 1
                            ? Expanded(
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.253,
                                  child: Column(
                                    children: [
                                      Text('ORIGIN', style: Constants.heading3),
                                      Expanded(
                                        child: TextField(
                                          readOnly: true,
                                          controller: _pickupLocationController,
                                          onTap: () async {
                                            // should onTap: () async {
                                            var place = await PlacesAutocomplete.show(
                                                // logo: ElevatedButton(onPressed: (){
                                                //   print("HEKLLO WORLD");
                                                // }, child: Text("Show previous location"),),

                                                context: context,
                                                apiKey: googleApikey,
                                                mode: Mode.overlay,
                                                types: [],
                                                strictbounds: false,
                                                components: [
                                                  Component(
                                                    Component.country,
                                                    'pk',
                                                  ),
                                                  // Component(
                                                  //   Component.country,
                                                  //   'afg',
                                                  // )
                                                ],
                                                //google_map_webservice package
                                                onError: (err) {
                                                  print(err);
                                                });

                                            if (place != null) {
                                              setState(() {
                                                pickup_location = place
                                                    .description
                                                    .toString();
                                                _pickupLocationController.text =
                                                    place.description
                                                        .toString();
                                              });

                                              //form google_maps_webservice package
                                              final plist = GoogleMapsPlaces(
                                                apiKey: googleApikey,
                                                apiHeaders:
                                                    await GoogleApiHeaders()
                                                        .getHeaders(),
                                                //from google_api_headers package
                                              );
                                              String placeid =
                                                  place.placeId ?? "0";
                                              final detail = await plist
                                                  .getDetailsByPlaceId(placeid);
                                              final geometry =
                                                  detail.result.geometry!;
                                              final lat = geometry.location.lat;
                                              final lang =
                                                  geometry.location.lng;
                                              pickupLatLng = LatLng(lat, lang);
                                              print(pickupLatLng);

                                              //move map camera to selected place with animation
                                              mapController?.animateCamera(
                                                  CameraUpdate
                                                      .newCameraPosition(
                                                          CameraPosition(
                                                              target:
                                                                  pickupLatLng!,
                                                              zoom: 4)));
                                              Marker pickupMarker = Marker(
                                                  markerId: MarkerId('SomeId'),
                                                  position: pickupLatLng!,
                                                  infoWindow: InfoWindow(
                                                      title: 'Pick up Location',
                                                      snippet:
                                                          'Pick up Location'));
                                              setState(() {
                                                // if (_markers.contains(pickupMarker)) {
                                                //   _markers.remove(pickupMarker);
                                                // } else {
                                                //   _markers.add(pickupMarker);
                                                // }
                                                if (_markers.isEmpty) {
                                                  _markers.add(pickupMarker);
                                                } else {
                                                  _markers[0] = pickupMarker;
                                                }
                                              });
                                              setPolyLines();
                                            }
                                          },
                                          decoration: InputDecoration(
                                            icon: Container(
                                              margin: EdgeInsets.only(left: 20),
                                              width: 10,
                                              height: 10,
                                              child: Icon(
                                                FontAwesomeIcons.mapMarkerAlt,
                                                color: Constants.BrightRed,
                                              ),
                                            ),
                                            hintText: "Origin Point",
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                left: 8.0, top: 16.0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 11,
                                      ),
                                      Text('DESTINATION',
                                          style: Constants.heading3),
                                      TextField(
                                        readOnly: true,
                                        controller:
                                            _destinationLocationController,
                                        onTap: () async {
                                          // should onTap: () async {
                                          var place =
                                              await PlacesAutocomplete.show(
                                                  context: context,
                                                  apiKey: googleApikey,
                                                  mode: Mode.overlay,
                                                  types: [],
                                                  strictbounds: false,
                                                  components: [
                                                    Component(Component.country,
                                                        'pk'),
                                                    // Component(
                                                    //   Component.country,
                                                    //   'afg',
                                                    // )
                                                  ],
                                                  //google_map_webservice package
                                                  onError: (err) {
                                                    print(err);
                                                  });

                                          if (place != null) {
                                            setState(() {
                                              destination_location =
                                                  place.description.toString();
                                              _destinationLocationController
                                                      .text =
                                                  place.description.toString();
                                            });

                                            //form google_maps_webservice package
                                            final plist = GoogleMapsPlaces(
                                              apiKey: googleApikey,
                                              apiHeaders:
                                                  await GoogleApiHeaders()
                                                      .getHeaders(),
                                              //from google_api_headers package
                                            );
                                            String placeid =
                                                place.placeId ?? "0";
                                            final detail = await plist
                                                .getDetailsByPlaceId(placeid);
                                            final geometry =
                                                detail.result.geometry!;
                                            final lat = geometry.location.lat;
                                            final lang = geometry.location.lng;
                                            dropOffLatLng = LatLng(lat, lang);
                                            print(newlatlang);

                                            //move map camera to selected place with animation
                                            mapController?.animateCamera(
                                                CameraUpdate.newCameraPosition(
                                                    CameraPosition(
                                                        target: dropOffLatLng!,
                                                        zoom: 4)));
                                            // _markers.add();
                                            Marker dropOffmarker = Marker(
                                                markerId: MarkerId('SomeId 2'),
                                                position: dropOffLatLng!,
                                                infoWindow: InfoWindow(
                                                    title: 'Drop of location',
                                                    snippet:
                                                        'Drop of location'));
                                            setState(() {
                                              if (_markers
                                                  .asMap()
                                                  .containsKey(1)) {
                                                _markers[1] = dropOffmarker;
                                              } else {
                                                _markers.add(dropOffmarker);
                                              }
                                            });
                                            setPolyLines();
                                          }
                                        },
                                        decoration: InputDecoration(
                                          icon: Container(
                                            margin: EdgeInsets.only(
                                              left: 20,
                                            ),
                                            width: 10,
                                            height: 10,
                                            child: Icon(
                                                FontAwesomeIcons.locationArrow,
                                                color: Constants.Primary),
                                          ),
                                          hintText: "Destination Point",
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 8.0, top: 16.0),
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Icon(FontAwesomeIcons.dotCircle),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            // Container(
                                            //     child: DropdownButton<String>(
                                            //   underline: SizedBox(),
                                            //   focusColor: Colors.white,
                                            //   icon: Icon(
                                            //     Icons.arrow_drop_down,
                                            //     color: Colors.white,
                                            //   ),
                                            //   hint: Text(containerDropLocation == null
                                            //       ? "Container Drop Of Location"
                                            //       : containerDropLocation),
                                            //   // alignment: AlignmentDirectional.topEnd,
                                            //   //  value: "Container Drop Of Location",

                                            //   items: <String>[
                                            //     'Karachi',
                                            //     'Lahore',
                                            //     'Others'
                                            //   ].map((String value) {
                                            //     return DropdownMenuItem<String>(
                                            //       value: value,
                                            //       child: Text(value),
                                            //     );
                                            //   }).toList(),
                                            //   onChanged: (val) {
                                            //     setState(() {
                                            //       containerDropLocation = val!;
                                            //     });
                                            //   },
                                            // )),
                                            Text(containerDropLocation),
                                            Spacer(),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Container(
                                                  child: DropDownMenuFb1(
                                                      icon: Icon(Icons
                                                          .arrow_drop_down),
                                                      menuList: [
                                                        PopupMenuItem(
                                                          child:
                                                              Text("Karachi"),
                                                          onTap: () {
                                                            setState(() {
                                                              containerDropLocation =
                                                                  "Karachi";
                                                            });
                                                          },
                                                        ),
                                                        PopupMenuItem(
                                                            onTap: () {
                                                              setState(() {
                                                                containerDropLocation =
                                                                    "Lahore";
                                                              });
                                                            },
                                                            child:
                                                                Text("Lahore")),
                                                        PopupMenuItem(
                                                            child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                          child: TextField(
                                                            onChanged: (val) {
                                                              setState(() {
                                                                containerDropLocation =
                                                                    val;
                                                              });
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              hintText: "Other",
                                                            ),
                                                          ),
                                                        )),
                                                      ]),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.253,
                                  child: Column(
                                    children: [
                                      Text('ORIGIN', style: Constants.heading3),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Icon(
                                            FontAwesomeIcons.mapMarkerAlt,
                                            color: Constants.BrightRed,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            _pickupLocationControllerTransit
                                                    .text.isEmpty
                                                ? "Origin Point"
                                                : _pickupLocationControllerTransit
                                                    .text,
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10, bottom: 4, top: 3),
                                            child: DropDownMenuFb1(
                                                icon:
                                                    Icon(Icons.arrow_drop_down),
                                                menuList: [
                                                  PopupMenuItem(
                                                    child: Text("KICT Port"),
                                                    onTap: () {
                                                      setLocationPickup(
                                                        "KICT Port",
                                                        LatLng(
                                                            24.845855342013625,
                                                            66.9794407968904),
                                                      );
                                                    },
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 2, 15, 2),
                                                  ),
                                                  PopupMenuItem(
                                                    child: Text("PICT Port"),
                                                    onTap: () {
                                                      setLocationPickup(
                                                        "PICT Port",
                                                        LatLng(
                                                            24.82540739005693,
                                                            66.97676726434622),
                                                      );

                                                      print("hello kict");
                                                    },
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 2, 15, 2),
                                                  ),
                                                  PopupMenuItem(
                                                    child: Text("SAPT Port"),
                                                    onTap: () {
                                                      setLocationPickup(
                                                        "SAPT Port",
                                                        LatLng(
                                                            24.80197377990152,
                                                            66.98608475923358),
                                                      );

                                                      print("hello kict");
                                                    },
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 2, 15, 2),
                                                  ),
                                                  PopupMenuItem(
                                                    child: Text("QICT Port"),
                                                    onTap: () {
                                                      setLocationPickup(
                                                        "QICT Port",
                                                        LatLng(
                                                            24.76921887089302,
                                                            67.32822765797647),
                                                      );

                                                      print("hello kict");
                                                    },
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 2, 15, 2),
                                                  ),
                                                ]),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 11,
                                      ),
                                      Text('DESTINATION',
                                          style: Constants.heading3),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Icon(FontAwesomeIcons.locationArrow),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            _destinationLocationControllerTransit
                                                    .text.isEmpty
                                                ? "Destination Point"
                                                : _destinationLocationControllerTransit
                                                    .text,
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10, bottom: 4),
                                            child: DropDownMenuFb1(
                                                icon:
                                                    Icon(Icons.arrow_drop_down),
                                                menuList: [
                                                  PopupMenuItem(
                                                    child: Text("Torkham"),
                                                    onTap: () {
                                                      setLocationDropOff(
                                                          "Torkham",
                                                          LatLng(34.1299,
                                                              71.0839));
                                                    },
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 2, 15, 2),
                                                  ),
                                                  PopupMenuItem(
                                                    child: Text("Jalalabad"),
                                                    onTap: () {
                                                      setLocationDropOff(
                                                          "Jalalabad",
                                                          LatLng(34.440380,
                                                              70.441856));
                                                    },
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 2, 15, 2),
                                                  ),
                                                  PopupMenuItem(
                                                    child: Text("Kabul"),
                                                    onTap: () {
                                                      setLocationDropOff(
                                                          "Kabul",
                                                          LatLng(34.5553,
                                                              69.2075));
                                                    },
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 2, 15, 2),
                                                  ),
                                                  PopupMenuItem(
                                                    child: Text("Spin Boldak"),
                                                    onTap: () {
                                                      setLocationDropOff(
                                                          "Spin Boldak",
                                                          LatLng(30.9978,
                                                              66.4152));
                                                    },
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 2, 15, 2),
                                                  ),
                                                  PopupMenuItem(
                                                    child: Text("Kandahar"),
                                                    onTap: () {
                                                      setLocationDropOff(
                                                          "Kandahar",
                                                          LatLng(31.6289,
                                                              65.7372));
                                                    },
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 2, 15, 2),
                                                  ),
                                                ]),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Icon(FontAwesomeIcons.dotCircle),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            // Container(
                                            //     child: DropdownButton<String>(
                                            //   underline: SizedBox(),
                                            //   focusColor: Colors.white,
                                            //   icon: Icon(
                                            //     Icons.arrow_drop_down,
                                            //     color: Colors.white,
                                            //   ),
                                            //   hint: Text(containerDropLocation == null
                                            //       ? "Container Drop Of Location"
                                            //       : containerDropLocation),
                                            //   // alignment: AlignmentDirectional.topEnd,
                                            //   //  value: "Container Drop Of Location",

                                            //   items: <String>[
                                            //     'Karachi',
                                            //     'Lahore',
                                            //     'Others'
                                            //   ].map((String value) {
                                            //     return DropdownMenuItem<String>(
                                            //       value: value,
                                            //       child: Text(value),
                                            //     );
                                            //   }).toList(),
                                            //   onChanged: (val) {
                                            //     setState(() {
                                            //       containerDropLocation = val!;
                                            //     });
                                            //   },
                                            // )),
                                            Text(containerDropLocation),
                                            Spacer(),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Container(
                                                  child: DropDownMenuFb1(
                                                      icon: Icon(Icons
                                                          .arrow_drop_down),
                                                      menuList: [
                                                        PopupMenuItem(
                                                          child:
                                                              Text("Karachi"),
                                                          onTap: () {
                                                            setState(() {
                                                              containerDropLocation =
                                                                  "Karachi";
                                                            });
                                                          },
                                                        ),
                                                        PopupMenuItem(
                                                            onTap: () {
                                                              setState(() {
                                                                containerDropLocation =
                                                                    "Lahore";
                                                              });
                                                            },
                                                            child:
                                                                Text("Lahore")),
                                                        PopupMenuItem(
                                                            child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                          child: TextField(
                                                            onChanged: (val) {
                                                              setState(() {
                                                                containerDropLocation =
                                                                    val;
                                                              });
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              hintText: "Other",
                                                            ),
                                                          ),
                                                        )),
                                                      ]),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                  ],
                ),
              ),
            ),

            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CustomBtn(
                    text: "Proceed",
                    onpreased: () {
                      if (toggle_value == 1) {
                        if (containerDropLocation == null ||
                            containerDropLocation ==
                                "Container Drop Off Location") {
                          Get.snackbar("Error", "Please Select All Values",
                              colorText: Colors.red,
                              backgroundColor: Colors.white);
                        } else if (pickupLatLng == null ||
                            _pickupLocationController.text.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please Select Pickup Location",
                            backgroundColor: Colors.white,
                            colorText: Colors.red,
                          );
                        } else if (dropOffLatLng == null ||
                            _destinationLocationController.text.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please Select Pickup Location",
                            backgroundColor: Colors.white,
                            colorText: Colors.red,
                          );
                        } else {
                          vehivledataLoaded
                              ? () {}
                              : _getVehicleController.fetchVehicle();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PPLHome(
                                        pickupLatLng: userPosition != null
                                            ? LatLng(userPosition!.latitude,
                                                userPosition!.longitude)
                                            : pickupLatLng!,
                                        dropOffLatLng: dropOffLatLng!,
                                        pickup_address: userPosition != null
                                            ? _pickupLocationController.text
                                            : pickup_location,
                                        dropOff_address: destination_location,
                                        containerDropOff: containerDropLocation,
                                        // containerDropLocation,
                                        markers: _markers,
                                        polyline: _polyline,
                                        type: toggle_value,
                                      )));
                        }
                      } else if (toggle_value == 0) {
                        if (containerDropLocation == null ||
                            containerDropLocation ==
                                "Container Drop Off Location") {
                          Get.snackbar("Error", "Please Select All Values",
                              colorText: Colors.red,
                              backgroundColor: Colors.white);
                        } else if (pickupLatLng == null ||
                            _pickupLocationControllerTransit.text.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please Select Pickup Location",
                            backgroundColor: Colors.white,
                            colorText: Colors.red,
                          );
                        } else if (dropOffLatLng == null ||
                            _destinationLocationControllerTransit
                                .text.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please Select Pickup Location",
                            backgroundColor: Colors.white,
                            colorText: Colors.red,
                          );
                        } else {
                          vehivledataLoaded
                              ? () {}
                              : _getVehicleController.fetchVehicle();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PPLHome(
                                        pickupLatLng: userPosition != null
                                            ? LatLng(userPosition!.latitude,
                                                userPosition!.longitude)
                                            : pickupLatLng!,
                                        dropOffLatLng: dropOffLatLng!,
                                        pickup_address: userPosition != null
                                            ? _pickupLocationController.text
                                            : pickup_location,
                                        dropOff_address: destination_location,
                                        containerDropOff: containerDropLocation,
                                        // containerDropLocation,
                                        markers: _markers,
                                        polyline: _polyline,
                                        type: toggle_value,
                                      )));
                        }
                      }
                      // else {

                      // print(pickup_location);
                      // print(pickupLatLng!.longitude);
                      // print(pickupLatLng!.latitude);
                      // print(destination_location);
                      // print(dropOffLatLng!.latitude);
                      // print(dropOffLatLng!.longitude);
                      // print(containerDropLocation);
                      // }
                    },
                    outlinebtn: false)),
          ],
        ));
  }

  calc(LatLng pickupLatLng, LatLng dropofflatlng) {
    double calculateDistance(lat1, lon1, lat2, lon2) {
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 -
          c((lat2 - lat1) * p) / 2 +
          c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
      return 12742 * asin(sqrt(a));
    }

    List<dynamic> data = [
      {"lat": pickupLatLng.latitude, "lng": pickupLatLng.longitude},
      {"lat": dropofflatlng.latitude, "lng": dropofflatlng.longitude},
    ];
    double totalDistance = 0;
    for (var i = 0; i < data.length - 1; i++) {
      totalDistance += calculateDistance(data[i]["lat"], data[i]["lng"],
          data[i + 1]["lat"], data[i + 1]["lng"]);
    }
    print(totalDistance);
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
