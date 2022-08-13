import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meribiltyapp/Api%20Services/Tracking/location_service.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/singleBiltyServicesUpcountry.dart';
import 'package:meribiltyapp/Api%20Services/pdf_for_invoice.dart';
import 'package:meribiltyapp/Api%20Services/pdf_formar_for_bilty.dart';
import 'package:meribiltyapp/Api%20Services/upload/upload_transit_documents.dart';
import 'package:meribiltyapp/Api%20Services/upload/upload_upcountry_documents.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/drawer_pages/chat.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_deliveries.dart';
import 'package:meribiltyapp/screens/home/home.dart';
import 'package:meribiltyapp/screens/ppl/select_payment_method.dart';
import 'package:meribiltyapp/widgets/biltystatusstepper.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/checktile.dart';
import 'package:meribiltyapp/widgets/file_picker.dart';
import 'package:meribiltyapp/widgets/location.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:http/http.dart' as http;

import '../../Api Services/chat/chatServiceWithGetx.dart';

// Sorry for the name, this is for transit
class SingleBiltyUpcountry extends StatefulWidget {
  final String biltyNo;
  final orderNumber;
  final originLat;
  final originLng;
  final destinationLat;
  final destinationLng;
  const SingleBiltyUpcountry({
    Key? key,
    required this.biltyNo,
    required this.orderNumber,
    required this.originLat,
    required this.originLng,
    required this.destinationLat,
    required this.destinationLng,
  }) : super(key: key);

  @override
  _SingleBiltyUpcountryState createState() => _SingleBiltyUpcountryState();
}

class _SingleBiltyUpcountryState extends State<SingleBiltyUpcountry> {
  Completer<GoogleMapController> _GoogleMapController = Completer();

  // GoogleMapController userMap;
  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(24.8607, 67.0011),
    zoom: 4,
  );

  // Copy From Here
  String paragraphText =
      'Adobe Systems Incorporated\'s Portable Document Format \n (PDF) is the de facto'
      'standard for the accurate, reliable, and platform-independent representation of a paged'
      'document. It\'s the only universally accepted file format that allows pixel-perfect layouts.'
      'In addition, PDF supports user interaction and collaborative workflows that are not'
      'possible with printed documents.';
  var billOfLanding;
  var invoice;
  var gd;
  var demandLetter;
  var packagingList;
  FilePickerResult? billOfLandingFile;
  FilePickerResult? invoiceFile;
  FilePickerResult? gdFile;
  FilePickerResult? demandLetterFile;
  FilePickerResult? packagingListFile;
  var locationUrl;
  ChatServiceWithGetx _chatService = Get.put(ChatServiceWithGetx());

  bool _aredoc_submitted = true;
  var documentsNames = [
    "Bill of Ladind(BL)",
    "Invoice",
    "GD",
    "Demand Letter",
    "Packing List",
  ];

  var reason = [
    "Price is too High",
    "Took a Long Time for Rates",
    "Payment Problem",
  ];
  var biltyData;
  var invoiceData;
  Timer? timer;
  LatLng? driverLocation;
  //bool value = false;
  bool _checked = false;
  getDriverLocation() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://staging-api.meribilty.com/api/get_current_Location'));
    request.body = json.encode(
        {"orderNo": "${widget.orderNumber}", "biltyNo": "${widget.biltyNo}"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    Map responseMap = json.decode(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      if (responseMap['status'] == true) {
        setState(() {
          driverLocation = LatLng(
              responseMap['result']["lat"], responseMap['result']["lng"]);
          circles = Set.from(
            [
              Circle(
                circleId: CircleId('currentCircle'),
                center: LatLng(
                    responseMap['result']["lat"], responseMap['result']["lng"]),
                radius: 200,
                fillColor: Colors.blue.shade300.withOpacity(0.5),
                strokeColor: Colors.blue.shade100.withOpacity(0.1),
              ),
            ],
          );
          locationUrl =
              "https://www.google.com/maps/search/?api=1&query=${responseMap['result']["lat"]},${responseMap['result']["lng"]}";
        });
        final GoogleMapController controller =
            await _GoogleMapController.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(
              responseMap['result']["lat"], responseMap['result']["lng"]),
          zoom: 14.4746,
        )));
        print(responseMap);
        print(driverLocation);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    ShowPolyLines();
    getDriverLocation();
    timer = Timer.periodic(Duration(hours: 1), (timer) {
      getDriverLocation();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Set<Circle> circles = Set.from(
    [
      Circle(
        circleId: CircleId('currentCircle'),
        center: LatLng(24.8607, 67.0011),
        radius: 10,
        fillColor: Colors.blue.shade300.withOpacity(0.5),
        strokeColor: Colors.blue.shade100.withOpacity(0.1),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // toolbarHeight: 80,
          elevation: 0,
          leading: InkWell(
            child: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Constants.Primary,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          // iconTheme: IconThemeData(color: Constants.Primary),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => super.widget));
          },
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .50,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      markers: Set<Marker>.of(markers),
                      polylines: _polylines,
                      circles: circles,
                      initialCameraPosition: _initialCameraPosition,
                      myLocationButtonEnabled: false,
                      myLocationEnabled: false,
                      zoomControlsEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        _GoogleMapController.complete(controller);
                      },
                    ),
                  ),

                  // Single Bilty Card
                  FutureBuilder(
                      future: getSingleBiltyTransitApi(widget.biltyNo),
                      builder: ((context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.none ||
                            !snapshot.hasData) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: Constants.Primary,
                          ));
                        }
                        // if (snapshot.data.length == 0) {
                        //   return Center(child: Center(child: CircularProgressIndicator()));
                        // }
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            !snapshot.hasData) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: Constants.Primary,
                          ));
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        }
                        if (snapshot.hasData) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(bottom: 10),
                            // height: MediaQuery.of(context).size.height * .60,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 20),
                            decoration: BoxDecoration(
                              // color: Colors.yellow,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(40),
                                topLeft: Radius.circular(40),
                              ),
                              color: Constants.White,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            snapshot.data['driver_name'] == null
                                                ? 'Driver Pending '
                                                : "${snapshot.data['driver_name']}",
                                            style: Constants.heading4.copyWith(
                                                color: Constants.Black)),
                                        Text(
                                            snapshot.data['vehicle_number'] ==
                                                    null
                                                ? "Vehicle Pending"
                                                : "${snapshot.data['vehicle_number']}",
                                            style: Constants.regular4.copyWith(
                                                color: Constants.Grey)),
                                        Text(
                                            snapshot.data['name'] == null
                                                ? 'Vehicle Type Pending '
                                                : "${snapshot.data['name']}",
                                            style: Constants.regular4.copyWith(
                                                color: Constants.Grey)),
                                        Text(
                                            snapshot.data['weight'] == null
                                                ? 'Weight Pending '
                                                : "${snapshot.data['weight']} Tons",
                                            style: Constants.regular4.copyWith(
                                                color: Constants.Grey)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3),
                                          child: Text(
                                            "Order # ${widget.orderNumber}",
                                            style: Constants.regular4,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3),
                                          child: Text(
                                            "builty # ${widget.biltyNo}",
                                            style: Constants.regular4,
                                          ),
                                        ),
                                        if (locationUrl != null)
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              Share.share('${locationUrl}');
                                            },
                                            icon: Icon(
                                              FontAwesomeIcons.locationArrow,
                                              size: 20,
                                            ),
                                            label: Text("   Share   "),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Constants.Primary),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                ))),
                                          ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        super.widget));
                                          },
                                          child: Text("   Refresh   "),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Constants.Primary),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ))),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Constants.Primary,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 15),
                                              child: Text(
                                                snapshot.data['final_amount'] ==
                                                        null
                                                    ? 'Pending'
                                                    : "Rs ${snapshot.data['final_amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                                                style: Constants.regular4
                                                    .copyWith(
                                                        color: Constants.White),
                                              ),
                                            )),
                                        // const SizedBox(
                                        //   height: 10,
                                        // ),
                                        // Text("Cash On Delivery",
                                        //     style: Constants.regular4
                                        //         .copyWith(color: Constants.Grey)),
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  _chatService.fetchChat();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Chat()));
                                                },
                                                icon: Icon(
                                                  Icons.chat,
                                                  size: 24,
                                                  color: Constants.Primary,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  _callNumber(snapshot
                                                      .data['driver_phone']);
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.phone,
                                                  size: 24,
                                                  color: Constants.Primary,
                                                )),
                                          ],
                                        ),
                                        //DownLoad Button

                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 3.0),
                                              child: ElevatedButton.icon(
                                                  onPressed: () async {
                                                    print(widget.orderNumber);
                                                    print(snapshot
                                                        .data['orderNo']);
                                                    await getBiltyInvoice(
                                                            "${widget.biltyNo}",
                                                            "${snapshot.data['orderNo']}")
                                                        .then((value) {
                                                      setState(() {
                                                        biltyData = value;
                                                      });
                                                      print(
                                                          "this is bilty invoice //////$biltyData");
                                                      downloadInvoiceBilty(
                                                        customerId:
                                                            "${biltyData['user']['Customer ID']}",
                                                        origin:
                                                            "${biltyData['user']['From (Origin)']}",
                                                        destination:
                                                            "${biltyData['user']['To: (Destination)']}",
                                                        sender:
                                                            "${biltyData['user']['Sender Name']}",
                                                        senderAddress:
                                                            "${biltyData['user']['Sender Address']}",
                                                        receiver:
                                                            "${biltyData['user']['Receiver Address']}",
                                                        biltyNo:
                                                            "${widget.biltyNo}",
                                                        bookingNumber:
                                                            "${snapshot.data['orderNo']}",
                                                        date:
                                                            "${biltyData['user']['Date']}",
                                                        material:
                                                            "${biltyData['user']['Materials']}",
                                                        weight:
                                                            "${biltyData['user']['Weights']} Ton",
                                                        amount:
                                                            "${biltyData['user']['total']} PKR",
                                                        vehicleType:
                                                            "${biltyData['user']['Vehicle Types']}",
                                                        recieverName:
                                                            "${biltyData['user']['Receiver Name']}",
                                                        recieverAddress:
                                                            "${biltyData['user']['Receiver Address']}",
                                                      );
                                                      // print(biltyData['data']['name']);
                                                      // print(biltyData.runtimeType);
                                                    });
                                                  },
                                                  icon: Icon(Icons.download),
                                                  label: Text("Bilty"),
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Constants
                                                                  .Primary),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18.0),
                                                      )))),
                                            ),
                                            ElevatedButton.icon(
                                                onPressed: () async {
                                                  List weightList = [];

                                                  // (widget.data ??
                                                  //         const {})['bilty']
                                                  //     .forEach((val) {
                                                  //   if (val['weight'] != null) {
                                                  //     weightList
                                                  //         .add(val['weight']);
                                                  //   }
                                                  // });
                                                  await getInvoiceData(
                                                          widget.orderNumber)
                                                      .then((value) {
                                                    setState(() {
                                                      invoiceData = value;
                                                    });
                                                  });
                                                  print(invoiceData);
                                                  invoiceData['data']['bilty']
                                                      .forEach((val) {
                                                    if (val['weight'] != null) {
                                                      weightList
                                                          .add(val['weight']);
                                                    }
                                                  });
                                                  downloadOrderInvoice(
                                                    fuelAndOther:
                                                        "${invoiceData['data']['user']['fuelAndOtherCharges']}",
                                                    customerId:
                                                        "${invoiceData['data']['user']['Customer ID']}",
                                                    origin:
                                                        "${invoiceData['data']['user']['From (Origin)']}",
                                                    vehicleRegistration:
                                                        "${invoiceData['data']['user']['Vehicle Registrations']}",
                                                    vehicleType:
                                                        "${invoiceData['data']['user']['Vehicle Types']}",
                                                    insurance:
                                                        "${invoiceData['data']['user']['Cargo Insurance']}",
                                                    invoiceAmount:
                                                        "${invoiceData['data']['user']['fuelAndOtherCharges']}",
                                                    salesTax:
                                                        "${invoiceData['data']['user']['salesTax']}",
                                                    serviceCharges:
                                                        "${invoiceData['data']['user']['serviceCharges']}",
                                                    totalInWords:
                                                        "${invoiceData['data']['user']['totalInWords']}",
                                                    destination:
                                                        "${invoiceData['data']['user']['To: (Destination)']}",
                                                    sender:
                                                        "${invoiceData['data']['user']['Sender Name']}",
                                                    senderAddress:
                                                        "${invoiceData['data']['user']['Sender Address']}",
                                                    receiver:
                                                        "${invoiceData['data']['user']['Receiver Name']}",
                                                    invoiceNo:
                                                        "${invoiceData['data']['user']['Invoice Number']}",
                                                    bookingNumber:
                                                        "${invoiceData['data']['user']['Booking Number']}",
                                                    date:
                                                        "${invoiceData['data']['user']['Date']}",
                                                    material:
                                                        "${invoiceData['data']['user']['Materials']}",
                                                    weight:
                                                        "${invoiceData['data']['user']['Weights']}",
                                                    amount:
                                                        "${invoiceData['data']['user']['total']}",
                                                    recieverAddress:
                                                        "${invoiceData['data']['user']['Receiver Address']}",
                                                  );
                                                },
                                                icon: Icon(Icons.download),
                                                label: Text(" Invoice"),
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Constants
                                                                .Primary),
                                                    shape: MaterialStateProperty
                                                        .all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                    )))),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                // BiltyStatusCheckPoints(),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        "Tracking & Check Points",
                                        style: Constants.heading2
                                            .copyWith(color: Constants.Black),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        // Order Time Tile
                                        // ListTile(
                                        //   leading:
                                        //       snapshot.data['createdAt'] == null
                                        //           ? CheckTileEmpty()
                                        //           : CheckTileDone(),
                                        //   title: Text("Order Time",
                                        //       style: TextStyle(
                                        //           color: Constants.Primary,
                                        //           fontSize: 20)),
                                        //   subtitle: Text(snapshot
                                        //               .data['createdAt'] ==
                                        //           null
                                        //       ? 'pending'
                                        //       : "${snapshot.data['createdAt']}"),
                                        // ),
                                        //  Offer Recieving Time Tile

                                        // Offer Acceptance Time
                                        ListTile(
                                          leading: snapshot.data[
                                                      'driver_alotted_on'] ==
                                                  null
                                              ? CheckTileEmpty()
                                              : CheckTileDone(),
                                          title: Text("Driver Alloting Time",
                                              style: TextStyle(
                                                  color: Constants.Primary,
                                                  fontSize: 18)),
                                          subtitle: Text(snapshot.data[
                                                      'driver_alotted_on'] ==
                                                  null
                                              ? 'pending'
                                              : "${snapshot.data['driver_alotted_on']}"),
                                        ),
                                        // Deleuery Arrival Time Tile
                                        ListTile(
                                          leading: snapshot.data[
                                                      'driver_reached_on'] ==
                                                  null
                                              ? CheckTileEmpty()
                                              : CheckTileDone(),
                                          title: Text("Driver Reached On",
                                              style: TextStyle(
                                                  color: Constants.Primary,
                                                  fontSize: 18)),
                                          subtitle: Text(snapshot.data[
                                                      'driver_reached_on'] ==
                                                  null
                                              ? 'pending'
                                              : "${snapshot.data['driver_reached_on']}"),
                                        ),
                                        // Delivery Pickup Time Tile
                                        ListTile(
                                          leading: snapshot.data[
                                                      'driver_pickup_on'] ==
                                                  null
                                              ? CheckTileEmpty()
                                              : CheckTileDone(),
                                          title: Text("Delivery Pickup Time",
                                              style: TextStyle(
                                                  color: Constants.Primary,
                                                  fontSize: 18)),
                                          subtitle: Text(snapshot.data[
                                                      'driver_pickup_on'] ==
                                                  null
                                              ? 'pending'
                                              : "${snapshot.data['driver_pickup_on']}"),
                                        ),
                                        // Delivery Unloadingl Time Tile
                                        ListTile(
                                          leading: snapshot.data[
                                                      'driver_delivered_on'] ==
                                                  null
                                              ? CheckTileEmpty()
                                              : CheckTileDone(),
                                          title: Text("delivered Time",
                                              style: TextStyle(
                                                  color: Constants.Primary,
                                                  fontSize: 18)),
                                          subtitle: Text(snapshot.data[
                                                      'driver_delivered_on'] ==
                                                  null
                                              ? 'pending'
                                              : "${snapshot.data['driver_delivered_on']}"),
                                        ),

                                        //Delivery Unloading TIme Tile
                                        ListTile(
                                          leading: snapshot.data[
                                                      'unloading_complete_on'] ==
                                                  null
                                              ? CheckTileEmpty()
                                              : CheckTileDone(),
                                          title: Text("Delivery Unloading Time",
                                              style: TextStyle(
                                                  color: Constants.Primary,
                                                  fontSize: 18)),
                                          subtitle: Text(snapshot.data[
                                                      'unloading_complete_on'] ==
                                                  null
                                              ? 'pending'
                                              : "${snapshot.data['unloading_complete_on']}"),
                                        ),

                                        //  Container Return Time Tile
                                        ListTile(
                                          leading: snapshot.data[
                                                      'container_returned_on'] ==
                                                  null
                                              ? CheckTileEmpty()
                                              : CheckTileDone(),
                                          title: Text("Container Return Time",
                                              style: TextStyle(
                                                  color: Constants.Primary,
                                                  fontSize: 18)),
                                          subtitle: Text(snapshot.data[
                                                      'container_returned_on'] ==
                                                  null
                                              ? 'pending'
                                              : "${snapshot.data['container_returned_on']}"),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            color: Constants.Primary,
                                          ),
                                          child: TextButton.icon(
                                              onPressed:
                                                  // snapshot.data['documents'] ==
                                                  //         null
                                                  // ?
                                                  () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) {
                                                      return StatefulBuilder(
                                                          builder: (BuildContext
                                                                  context,
                                                              StateSetter
                                                                  setState /*You can rename this!*/) {
                                                        return SingleChildScrollView(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    top: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.02),
                                                                child: Center(
                                                                    child: Text(
                                                                  "Upload Documents",
                                                                  style: Constants
                                                                      .heading3,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                )),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            20),
                                                                child:
                                                                    FilePickerWidget(
                                                                        Txt:
                                                                            "Bill Of Lading",
                                                                        OnChange:
                                                                            () {},
                                                                        ontap:
                                                                            () async {
                                                                          cameraGalleryModalBottomSheet(
                                                                              context,
                                                                              // Function For Picking Camera Image
                                                                              () async {
                                                                            ImagePicker.platform.getImage(source: ImageSource.camera).then((value) {
                                                                              setState(() {
                                                                                billOfLanding = value!.path;
                                                                              });
                                                                            });
                                                                          },
                                                                              // Function For PIcking Files From Gallery
                                                                              () async {
                                                                            billOfLandingFile =
                                                                                await FilePicker.platform.pickFiles(
                                                                              type: FileType.custom,
                                                                              allowedExtensions: [
                                                                                'jpg',
                                                                                'pdf',
                                                                                'jpeg',
                                                                                'png'
                                                                              ],
                                                                            );
                                                                            setState(() {
                                                                              billOfLanding = billOfLandingFile!.files.first.path;
                                                                            });
                                                                            print(billOfLanding);
                                                                          });
                                                                          //   billOfLandingFile = await FilePicker
                                                                          //       .platform
                                                                          //       .pickFiles(
                                                                          //     type:
                                                                          //         FileType.custom,
                                                                          //     allowedExtensions: [
                                                                          //       'jpg',
                                                                          //       'pdf',
                                                                          //       'jpeg',
                                                                          //       'png'
                                                                          //     ],
                                                                          //   );
                                                                          //   setState(
                                                                          //       () {
                                                                          //     billOfLanding = billOfLandingFile!
                                                                          //         .files
                                                                          //         .first
                                                                          //         .path;
                                                                          //   });
                                                                        },
                                                                        ispicked: billOfLanding ==
                                                                                null
                                                                            ? false
                                                                            : true),
                                                              ),
                                                              FilePickerWidget(
                                                                  Txt:
                                                                      "Invoice",
                                                                  OnChange:
                                                                      () {},
                                                                  ontap:
                                                                      () async {
                                                                    cameraGalleryModalBottomSheet(
                                                                        context,
                                                                        // Function For Picking Camera Image
                                                                        () async {
                                                                      ImagePicker
                                                                          .platform
                                                                          .getImage(
                                                                              source: ImageSource.camera)
                                                                          .then((value) {
                                                                        setState(
                                                                            () {
                                                                          invoice =
                                                                              value!.path;
                                                                        });
                                                                      });
                                                                    },
                                                                        // Function For PIcking Files From Gallery
                                                                        () async {
                                                                      invoiceFile = await FilePicker
                                                                          .platform
                                                                          .pickFiles(
                                                                        type: FileType
                                                                            .custom,
                                                                        allowedExtensions: [
                                                                          'jpg',
                                                                          'pdf',
                                                                          'jpeg',
                                                                          'png'
                                                                        ],
                                                                      );
                                                                      setState(
                                                                          () {
                                                                        invoice = invoiceFile!
                                                                            .files
                                                                            .first
                                                                            .path;
                                                                      });
                                                                      print(
                                                                          invoice);
                                                                    });
                                                                  },
                                                                  ispicked:
                                                                      invoice ==
                                                                              null
                                                                          ? false
                                                                          : true),
                                                              FilePickerWidget(
                                                                  Txt: "GD",
                                                                  OnChange:
                                                                      () {},
                                                                  ontap:
                                                                      () async {
                                                                    cameraGalleryModalBottomSheet(
                                                                        context,
                                                                        // Function For Picking Camera Image
                                                                        () async {
                                                                      ImagePicker
                                                                          .platform
                                                                          .getImage(
                                                                              source: ImageSource.camera)
                                                                          .then((value) {
                                                                        setState(
                                                                            () {
                                                                          gd = value!
                                                                              .path;
                                                                        });
                                                                      });
                                                                    },
                                                                        // Function For PIcking Files From Gallery
                                                                        () async {
                                                                      gdFile = await FilePicker
                                                                          .platform
                                                                          .pickFiles(
                                                                        type: FileType
                                                                            .custom,
                                                                        allowedExtensions: [
                                                                          'jpg',
                                                                          'pdf',
                                                                          'jpeg',
                                                                          'png'
                                                                        ],
                                                                      );
                                                                      setState(
                                                                          () {
                                                                        gd = gdFile!
                                                                            .files
                                                                            .first
                                                                            .path;
                                                                      });
                                                                      print(gd);
                                                                    });
                                                                  },
                                                                  ispicked: gd ==
                                                                          null
                                                                      ? false
                                                                      : true),
                                                              FilePickerWidget(
                                                                  Txt:
                                                                      "Demand Letter",
                                                                  OnChange:
                                                                      () {},
                                                                  ontap:
                                                                      () async {
                                                                    cameraGalleryModalBottomSheet(
                                                                        context,
                                                                        // Function For Picking Camera Image
                                                                        () async {
                                                                      ImagePicker
                                                                          .platform
                                                                          .getImage(
                                                                              source: ImageSource.camera)
                                                                          .then((value) {
                                                                        setState(
                                                                            () {
                                                                          demandLetter =
                                                                              value!.path;
                                                                        });
                                                                      });
                                                                    },
                                                                        // Function For PIcking Files From Gallery
                                                                        () async {
                                                                      demandLetterFile = await FilePicker
                                                                          .platform
                                                                          .pickFiles(
                                                                        type: FileType
                                                                            .custom,
                                                                        allowedExtensions: [
                                                                          'jpg',
                                                                          'pdf',
                                                                          'jpeg',
                                                                          'png'
                                                                        ],
                                                                      );
                                                                      setState(
                                                                          () {
                                                                        demandLetter = demandLetterFile!
                                                                            .files
                                                                            .first
                                                                            .path;
                                                                      });
                                                                      print(
                                                                          invoice);
                                                                    });
                                                                  },
                                                                  ispicked:
                                                                      demandLetter ==
                                                                              null
                                                                          ? false
                                                                          : true),
                                                              FilePickerWidget(
                                                                  Txt:
                                                                      "Packing List",
                                                                  OnChange:
                                                                      () {},
                                                                  ontap:
                                                                      () async {
                                                                    cameraGalleryModalBottomSheet(
                                                                        context,
                                                                        // Function For Picking Camera Image
                                                                        () async {
                                                                      ImagePicker
                                                                          .platform
                                                                          .getImage(
                                                                              source: ImageSource.camera)
                                                                          .then((value) {
                                                                        setState(
                                                                            () {
                                                                          packagingList =
                                                                              value!.path;
                                                                        });
                                                                      });
                                                                    },
                                                                        // Function For PIcking Files From Gallery
                                                                        () async {
                                                                      packagingListFile = await FilePicker
                                                                          .platform
                                                                          .pickFiles(
                                                                        type: FileType
                                                                            .custom,
                                                                        allowedExtensions: [
                                                                          'jpg',
                                                                          'pdf',
                                                                          'jpeg',
                                                                          'png'
                                                                        ],
                                                                      );
                                                                      setState(
                                                                          () {
                                                                        packagingList = packagingListFile!
                                                                            .files
                                                                            .first
                                                                            .path;
                                                                      });
                                                                      print(
                                                                          packagingList);
                                                                    });
                                                                  },
                                                                  ispicked:
                                                                      packagingList ==
                                                                              null
                                                                          ? false
                                                                          : true),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            15),
                                                                child:
                                                                    CustomBtn(
                                                                        text:
                                                                            "Proceed",
                                                                        onpreased:
                                                                            () {
                                                                          if (billOfLanding == null &&
                                                                              invoice == null &&
                                                                              gd == null &&
                                                                              demandLetter == null &&
                                                                              packagingList == null) {
                                                                            Fluttertoast.showToast(msg: "Please upload atleast one document");
                                                                          } else {
                                                                            print(widget.orderNumber);
                                                                            uploadTransitDocuments(
                                                                                billOfLanding == null ? null : billOfLanding,
                                                                                invoice == null ? null : invoice,
                                                                                gd == null ? null : gd,
                                                                                demandLetter == null ? null : demandLetter,
                                                                                packagingList == null ? null : packagingList,
                                                                                widget.orderNumber,
                                                                                context,
                                                                                snapshot.data['vendor_phone'],
                                                                                snapshot.data['vendor_name'],
                                                                                true);
                                                                          }
                                                                        },
                                                                        outlinebtn:
                                                                            false),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                    });
                                              },
                                              icon: Icon(
                                                snapshot.data['documents'] ==
                                                        null
                                                    ? Icons.pending_actions
                                                    : Icons.check_box_rounded,
                                                color: Constants.White,
                                                size: 28,
                                              ),
                                              label: Text(
                                                snapshot.data['documents'] ==
                                                        null
                                                    ? 'DOCUMENTS PENDING'
                                                    : '${snapshot.data['documents'].length > 5 ? "" : snapshot.data['documents'].length} DOCUMENTS SENT',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Constants.White,
                                                ),
                                              )),
                                        ),
                                        // ElevatedButton(
                                        //     onPressed: () {
                                        //       print(snapshot.data['documents'][0]
                                        //           ['name']);
                                        //       print(snapshot.data['documents'][0]
                                        //               ['name']
                                        //           .toString()
                                        //           .substring(
                                        //               snapshot.data['documents']
                                        //                       [0]['name']
                                        //                   .toString()
                                        //                   .indexOf('_')+1,
                                        //               snapshot.data['documents']
                                        //                       [0]['name']
                                        //                   .toString()
                                        //                   .indexOf('.')).replaceAll("_", " "));
                                        //     },
                                        //     child: Text("test"))
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }))
                ],
              ),
            ),
          ),
        ));
  }

  _callNumber(pnumber) async {
    final number = '$pnumber'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  // PoliLIne Function From Here
  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<Marker> markers = <Marker>[];
  int polylineCounter = 1;
  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(Marker(markerId: const MarkerId('Origin'), position: point));
    });
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = "polyline_$polylineCounter";
    polylineCounter++;
    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 4,
        color: Colors.blue,
        points: points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList(),
      ),
    );
  }

  ShowPolyLines() async {
    var directions = await LocationService().getDirectionsFromLatLng(
        widget.originLat,
        widget.originLng,
        widget.destinationLat,
        widget.destinationLng);

    _goToThePlace(
        directions['start_location']['lat'],
        directions['start_location']['lng'],
        directions['end_location']['lat'],
        directions['end_location']['lng']);
    _setPolyline(directions['polyline_decode']);
  }

  Future _goToThePlace(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
    //Map<String,dynamic> place
  ) async {
    // final GoogleMapController controller = await _controller.an;
    final GoogleMapController controller = await _GoogleMapController.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(
    //     CameraPosition(target: LatLng(lat1, lng1), zoom: 12)));

    Marker pickupMarker = Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(lat1, lng1),
        infoWindow:
            InfoWindow(title: 'Pick up Location', snippet: 'Pick up Location'));
    setState(() {
      markers.add(pickupMarker);
    });
    Marker dropof = Marker(
        markerId: MarkerId('drop of'),
        position: LatLng(lat2, lng2),
        infoWindow:
            InfoWindow(title: 'Drop Of Location', snippet: 'Drop Of Location'));
    setState(() {
      markers.add(dropof);
    });
    _setMarker(LatLng(lat1, lng1));
    _setMarker(LatLng(lat2, lng2));
  }

  // Till Here
}

void cameraGalleryModalBottomSheet(
    context, Function pickfromcamera, Function pickfromgallery) {
  final _formKey = GlobalKey<FormState>();
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0)),
      ),
      backgroundColor: Color(0xfffbf7f4),
      context: context,
      builder: (BuildContext bc) {
        return Form(
            key: _formKey,
            child: Container(
                height: 350.0,
                // color: Colors.transparent,
                child: Container(
                  height: 350,
                  padding: EdgeInsets.all(30),
                  // decoration: BoxDecoration(
                  //   color: Colors.black12,
                  //   borderRadius: new BorderRadius.only(
                  //       topLeft: const Radius.circular(10.0),
                  //       topRight: const Radius.circular(10.0)),
                  //
                  // ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 3,
                          width: 100,
                          color: Color(0xffe3e3e2),
                          child: Align(
                            alignment: Alignment.topLeft,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Text(
                          "Select Image",
                          style: TextStyle(
                              color: Constants.Primary,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                                "Pleace choose one of the following option to upload your profile picture",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Constants.Primary),
                              color: Color(0xfffbf7f4),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                topRight: Radius.circular(50.0),
                                bottomLeft: Radius.circular(50.0),
                                bottomRight: Radius.circular(50.0),
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  pickfromcamera();
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 85),
                                  child: Row(
                                    children: [
                                      Icon(Icons.camera_alt_outlined,
                                          color: Constants.Primary, size: 25.0),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Use Camera",
                                        style: TextStyle(
                                            color: Constants.Primary,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 40),
                          child: Row(
                            children: [
                              Container(
                                height: 2,
                                width: 100,
                                color: Color(0xffe3e3e2),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "OR",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 2,
                                width: 100,
                                color: Color(0xffe3e3e2),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                topRight: Radius.circular(50.0),
                                bottomLeft: Radius.circular(50.0),
                                bottomRight: Radius.circular(50.0),
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  pickfromgallery();
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 50),
                                  child: Row(
                                    children: [
                                      Icon(Icons.add_photo_alternate_outlined,
                                          color: Constants.Primary, size: 25.0),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Upload From Gallery",
                                        style: TextStyle(
                                            color: Constants.Primary,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )));
      });
}
