import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/location.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SingleBilty extends StatefulWidget {
  final String biltyNo;
  const SingleBilty({
    Key? key,
    required this.biltyNo,
  }) : super(key: key);

  @override
  _SingleBiltyState createState() => _SingleBiltyState();
}

class _SingleBiltyState extends State<SingleBilty> {
  Completer<GoogleMapController> _GoogleMapController = Completer();

  // GoogleMapController userMap;
  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  bool _aredoc_submitted = true;
  var documentsNames = [
    "Bill of Ladind(BL)",
    "Invoice",
    "GD",
    "Demand Letter",
    "Packing List",
  ];
  var billOfLanding;
  var Invoice;
  var gd;
  final picker = ImagePicker();
  var pickedFile;
  Future getImage( image) async {
    pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      image = File(pickedFile!.path);
      // image = imagep;
    });
    print(image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 80,
          elevation: 0,
          iconTheme: IconThemeData(color: Constants.Primary),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .40,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    initialCameraPosition: _initialCameraPosition,
                    myLocationButtonEnabled: false,
                    myLocationEnabled: false,
                    zoomControlsEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      _GoogleMapController.complete(controller);
                    },
                  ),
                ),
                // Single Bilty Card
                // FutureBuilder(
                //     future: getSingleBilty(widget.biltyNo),
                //     builder: ((context, AsyncSnapshot snapshot) {
                //       if (snapshot.connectionState == ConnectionState.none &&
                //           snapshot.hasData == null) {
                //         return Center(child: CircularProgressIndicator());
                //       }
                //       // if (snapshot.data.length == 0) {
                //       //   return Center(child: Center(child: CircularProgressIndicator()));
                //       // }
                //       if (snapshot.connectionState == ConnectionState.waiting &&
                //           snapshot.hasData == null) {
                //         return Center(child: CircularProgressIndicator());
                //       }
                //       if (snapshot.hasError) {
                //         return Center(child: Text(snapshot.error.toString()));
                //       }
                //       if (snapshot.hasData) {
                // return
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(bottom: 10),
                  // height: MediaQuery.of(context).size.height * .60,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                  // snapshot.data['data']['driver_name'] ==
                                  //         null
                                  //     ? ' '
                                  //     :
                                  "{snapshot.data['data']['driver_name']}",
                                  style: Constants.heading3
                                      .copyWith(color: Constants.Black)),
                              // Text(
                              //     "${snapshot.data['data']['qoute']['bilties'][0]['type']}",
                              //     style: Constants.regular4
                              //         .copyWith(color: Constants.Grey)),
                              // Text(
                              //     "${snapshot.data['data']['bilty'][0]['vehicle']}",
                              //     style: Constants.regular4
                              //         .copyWith(color: Constants.Grey)),
                              // Text(
                              //     "x${snapshot.data['data']['bilty'][0]['option_quantity']}  ${snapshot.data['data']['bilty'][0]['option']}",
                              //     style: Constants.regular4
                              //         .copyWith(color: Constants.Grey)),
                              // Text(
                              //     "x${snapshot.data['data']['bilty'][0]['quantity']} ${snapshot.data['data']['qoute']['bilties'][0]['type']} ${snapshot.data['data']['bilty'][0]['weight']}",
                              //     style: Constants.regular4
                              //         .copyWith(color: Constants.Grey)),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    color: Constants.Primary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 30),
                                    child: Text(
                                      // snapshot.data['data']['final_amount'] == null ? '' :
                                      "{snapshot.data['data']['final_amount']},",
                                      style: Constants.regular4
                                          .copyWith(color: Constants.White),
                                    ),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("Cash On Delivery",
                                  style: Constants.regular4
                                      .copyWith(color: Constants.Grey)),
                              const SizedBox(
                                height: 10,
                              ),
                              ButtonBar(
                                children: [
                                  IconButton(
                                      onPressed: () => {},
                                      icon: Icon(
                                        Icons.chat,
                                        size: 24,
                                        color: Constants.Primary,
                                      )),
                                  IconButton(
                                      onPressed: () => {},
                                      icon: Icon(
                                        FontAwesomeIcons.phone,
                                        size: 24,
                                        color: Constants.Primary,
                                      )),
                                ],
                              ),
                              // TextButton.icon(
                              //     onPressed: () => {
                              //           Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                   builder: (context) =>
                              //                       myOrders()))
                              //         },
                              //     icon: Icon(Icons.cancel_rounded,
                              //         color: Constants.BrightRed),
                              //     label: InkWell(
                              //       child: Text("Cancel",
                              //           style: Constants.regular3
                              //               .copyWith(
                              //                   color:
                              //                       Constants.BrightRed)),
                              //       onTap: () {
                              //         showDialog(
                              //             context: context,
                              //             builder:
                              //                 (BuildContext context) =>
                              //                     AlertDialog(
                              //                       shape: RoundedRectangleBorder(
                              //                           borderRadius:
                              //                               BorderRadius
                              //                                   .circular(
                              //                                       12.0)),
                              //                       title: Column(
                              //                         children: [
                              //                           Text(
                              //                             'Cancellation Reason',
                              //                             style: Constants
                              //                                 .regular5
                              //                                 .copyWith(
                              //                                     color: Constants
                              //                                         .Primary),
                              //                           ),
                              //                           Text(
                              //                             'How was your Experience ?',
                              //                             style: Constants
                              //                                 .heading1
                              //                                 .copyWith(
                              //                                     color: Constants
                              //                                         .Primary),
                              //                           ),
                              //                           //const SizedBox(height: 5,),
                              //                         ],
                              //                       ),
                              //                       content: SizedBox(
                              //                         height: 350,
                              //                         width:
                              //                             double.infinity,
                              //                         child: Column(
                              //                           children: [
                              //                             Center(
                              //                                 child: Text(
                              //                               'Your feedback will help us \n improve your next move ?',
                              //                               style: Constants
                              //                                   .regular4
                              //                                   .copyWith(
                              //                                       color:
                              //                                           Constants.Primary),
                              //                             )),
                              //                             Expanded(
                              //                               child: ListView
                              //                                   .builder(
                              //                                       shrinkWrap:
                              //                                           true,
                              //                                       itemCount:
                              //                                           4,
                              //                                       itemBuilder:
                              //                                           (BuildContext context, int index) {
                              //                                         return ListTile(
                              //                                           title: Text('Price is to high'),
                              //                                         );
                              //                                       }),
                              //                             )
                              //                           ],
                              //                         ),
                              //                       ),
                              //                     ));
                              //       },
                              //     ))
                            ],
                          )
                        ],
                      ),
                      // BiltyStatusCheckPoints(),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              "Tracking & Check Points",
                              style: Constants.heading3
                                  .copyWith(color: Constants.Black),
                            ),
                          ),
                          Column(
                            children: [
                              // Order Time Tile
                              ListTile(
                                // leading: CircleAvatar(backgroundColor: Constants.Primary,
                                //                 child:Icon(Icons.check,color: Constants.White,) ,
                                //             ),
                                title: const Text("Order Time",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25)),
                                subtitle: Text(
                                    // snapshot.data['data']
                                    //           ['createdAt'] ==
                                    //       null
                                    //   ? ' '
                                    //   :
                                    "{snapshot.data['data']['createdAt']}"),
                              ),
                              //  Offer Recieving Time Tile

                              // Offer Acceptance Time
                              ListTile(
                                title: const Text("Driver Alloting Time",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25)),
                                subtitle: Text(
                                    // snapshot.data['data']
                                    //           ['driver_alloted_on'] ==
                                    //       null
                                    //   ? ' '
                                    //   :
                                    "{snapshot.data['data']['driver_alloted_on']}"),
                              ),
                              // Deleuery Arrival Time Tile
                              ListTile(
                                title: const Text("Driver Reached On",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25)),
                                subtitle: Text(
                                    // snapshot.data['data']
                                    //           ['driver_reached_on'] ==
                                    //       null
                                    //   ? ' '
                                    //   :
                                    "{snapshot.data['data']['driver_reached_on']}"),
                              ),
                              // Deleuery Pickup Time Tile
                              ListTile(
                                title: const Text("Delivery Pickup Time",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25)),
                                subtitle: Text(
                                    // snapshot.data['data']
                                    //           ['driver_pickup_on'] ==
                                    //       null
                                    //   ? ' '
                                    //   :
                                    "{snapshot.data['data']['driver_pickup_on']}"),
                              ),
                              // Deleuery Unloadingl Time Tile
                              ListTile(
                                title: const Text("Delievered Time",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25)),
                                subtitle: Text(
                                    // snapshot.data['data']
                                    //           ['driver_delivered_on'] ==
                                    //       null
                                    //   ? ' '
                                    //   :
                                    "{snapshot.data['data']['driver_delivered_on']}"),
                              ),
                              //  Container Return Time Tile
                              ListTile(
                                title: const Text("Container Return Time",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25)),
                                subtitle: Text(
                                    // snapshot.data['data']
                                    //           ['container_returned_on'] ==
                                    //       null
                                    //   ? ' '
                                    //   :
                                    "{snapshot.data['data']['container_returned_on']}"),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              TextButton.icon(
                                  onPressed: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: Center(
                                                child: Text(
                                              '           Transit Cargo \n Important Documents',
                                              style: Constants.heading2
                                                  .copyWith(
                                                      color: Constants.Primary),
                                            )),
                                            content: SizedBox(
                                              height: 440,
                                              width: double.maxFinite,
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(
                                                      "Bill of Landing",
                                                      style: TextStyle(
                                                          color:
                                                              Constants.Black),
                                                      textScaleFactor: 1.2,
                                                    ),
                                                    trailing: IconButton(
                                                      icon: Icon(Icons
                                                          .chevron_right_outlined),
                                                      onPressed: () {
                                                        // ImagePicker()
                                                        //     .pickImage(
                                                        //         source:
                                                        //             ImageSource
                                                        //                 .gallery)
                                                        //     .then((value) {
                                                        //   setState(() {
                                                        //     billOfLanding =
                                                        //         value;
                                                        //   });
                                                        // });
                                                        getImage(billOfLanding);
                                                      },
                                                    ),
                                                  ),
                                                  // Invoice
                                                  ListTile(
                                                    title: Text(
                                                      "Invoice",
                                                      style: TextStyle(
                                                          color:
                                                              Constants.Black),
                                                      textScaleFactor: 1.2,
                                                    ),
                                                    trailing: IconButton(
                                                      icon: Icon(Icons
                                                          .chevron_right_outlined),
                                                      onPressed: () {
                                                        getImage(Invoice);
                                                      },
                                                    ),
                                                  ),
                                                  // GD
                                                  ListTile(
                                                    title: Text(
                                                      "Bill of Landing",
                                                      style: TextStyle(
                                                          color:
                                                              Constants.Black),
                                                      textScaleFactor: 1.2,
                                                    ),
                                                    trailing: IconButton(
                                                      icon: Icon(Icons
                                                          .chevron_right_outlined),
                                                      onPressed: () {
                                                        getImage(gd);
                                                      },
                                                    ),
                                                  ),
                                                  new FlatButton(
                                                    color: Constants.Primary,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                    onPressed: () {
                                                      setState(() {
                                                        _aredoc_submitted =
                                                            false;
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: Text(
                                                      'Submit Documents',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Constants.White),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: Text('Submit Later',
                                                        style: Constants
                                                            .regular4
                                                            .copyWith(
                                                                color: Constants
                                                                    .Black)),
                                                  ),
                                                  // Image(
                                                  //     image: FileImage(
                                                  //         billOfLanding))
                                                ],
                                              ),
                                            ),
                                          )),
                                  icon: Icon(
                                    Icons.check_circle_outlined,
                                    color: Constants.Primary,
                                    size: 25,
                                  ),
                                  label: Text(
                                    _aredoc_submitted
                                        ? 'DOCUMENTS PENDING'
                                        : 'DOCUMENTS SUBMITTED',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Constants.Primary,
                                    ),
                                  )),
                            ],
                          ),
                          Card(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "{snapshot.data['data']['username']}",
                                      style: Constants.heading4
                                          .copyWith(color: Constants.Primary),
                                    ),
                                    const Icon(
                                      FontAwesomeIcons.star,
                                      size: 18,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      "4.9",
                                      style: Constants.regular2
                                          .copyWith(color: Constants.Grey),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    IconButton(
                                      onPressed: () => {},
                                      icon: Icon(
                                        FontAwesomeIcons.inbox,
                                        size: 24,
                                        color: Constants.Primary,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => {},
                                      icon: Icon(
                                        FontAwesomeIcons.phone,
                                        size: 24,
                                        color: Constants.Primary,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Custom3LocationWigets(
                                    // pickupLocation:
                                    //     '${snapshot.data['data']['orgText']}',
                                    // dropOffLocation:
                                    //     '${snapshot.data['data']['desText']}',
                                    // emptyContainerlocation:
                                    //     '${snapshot.data['data']['containerReturnAddress']}',
                                    ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Distance: ",
                                          style: Constants.regular4.copyWith(
                                              color: Constants.Primary),
                                        ),
                                        Text(
                                          '{snapshot.data[data][disText]}',
                                          style: Constants.heading4
                                              .copyWith(color: Constants.Black),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Time: ",
                                          style: Constants.regular4.copyWith(
                                              color: Constants.Primary),
                                        ),
                                        Text(
                                          "{snapshot.data['data']['durText']}",
                                          style: Constants.heading4
                                              .copyWith(color: Constants.Black),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                RatingBar.builder(
                                  initialRating: 3.5,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber[500],
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                //   } else {
                //     return Center(child: CircularProgressIndicator());
                //   }
                // }
                // )
                // )
              ],
            ),
          ),
        ));
  }
}
