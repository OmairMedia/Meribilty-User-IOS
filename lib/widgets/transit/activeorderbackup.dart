// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:meribiltyapp/config/constants.dart';
// import 'package:meribiltyapp/screens/ppl/single_bilty.dart';
// import 'package:meribiltyapp/widgets/location.dart';
// import 'package:meribiltyapp/widgets/transit/subordercard.dart';

// class TransitActiveOrderCard extends StatefulWidget {
//   final String status;
//   final String biltyNo;
//   const TransitActiveOrderCard({
//     Key? key,
//     required this.status,
//     required this.biltyNo,
//   }) : super(key: key);

//   @override
//   _TransitActiveOrderCardState createState() => _TransitActiveOrderCardState();
// }

// class _TransitActiveOrderCardState extends State<TransitActiveOrderCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Constants.White,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//         side: BorderSide(color: Constants.Secondary, width: 1),
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(15), topRight: Radius.circular(15)),
//               color: Constants.Secondary,
//             ),
//             child: Center(
//               child: Text(
//                 "Active Order",
//                 style: Constants.regular4.copyWith(color: Constants.White),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Order#0007",
//                       style: Constants.regular4,
//                     ),
//                     Text(
//                       "9 Sep 2022 8:59PM",
//                       style: Constants.regular4,
//                     )
//                   ],
//                 ),
//                 ContainerDetailblue(
//                   vehicleType: "20 Feet Container",
//                   quantity: "2",
//                   weight: "5 Ton",
//                   material: "Cement",
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 ContainerDetailblue(
//                   vehicleType: "40 Feet Container",
//                   quantity: "1",
//                   weight: "10 Ton",
//                   material: "Electronics",
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           "Distance ",
//                           style: Constants.regular3,
//                         ),
//                         Text(
//                           "2000 KM",
//                           style: Constants.heading3,
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           "Time ",
//                           style: Constants.regular3,
//                         ),
//                         Text(
//                           "200 Min",
//                           style: Constants.heading3,
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   child: Custom3LocationWigets(),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                           decoration: BoxDecoration(
//                               color: Constants.Primary,
//                               borderRadius: BorderRadius.circular(20)),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 5, horizontal: 30),
//                             child: Text(
//                               "Transit",
//                               style: Constants.regular4
//                                   .copyWith(color: Constants.White),
//                             ),
//                           )),
//                       Container(
//                           decoration: BoxDecoration(
//                             color: Constants.Grey,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 5, horizontal: 30),
//                             child: Text(
//                               "Rs.200,000",
//                               style: Constants.regular4
//                                   .copyWith(color: Constants.Black),
//                             ),
//                           )),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//               height: 60,
//               width: MediaQuery.of(context).size.width,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(15),
//                     bottomRight: Radius.circular(15)),
//               ),
//               child: TextButton(
//                   onPressed: () {
//                     showRayyan(context);
//                   },
//                   child:const  Text("Manage")))
//         ],
//       ),
//     );
//   }
// }

// // Show All Bilties
// void showAllBiltiesModel(context) {
//   showModalBottomSheet(
//       context: context,
//       builder: (BuildContext buildcontext) {
//         return SingleChildScrollView(
//           child: SafeArea(
//             child:  Container(
//             height: MediaQuery.of(context).size.height * .60,
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 child: Column(
//                   children: [
//                     Text(
//                       "Order Bilties",
//                       style:
//                           Constants.heading3.copyWith(color: Constants.Primary),
//                     ),
//                     Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Image.asset(
//                                   "assets/images/vehicle.png",
//                                   height: 50,
//                                 ),
//                                 Text(
//                                   "20 Feet Container",
//                                   style: Constants.regular4
//                                       .copyWith(color: Constants.Grey),
//                                   textAlign: TextAlign.left,
//                                 ),
//                                 Text(
//                                   "Pending",
//                                   style: Constants.regular4
//                                       .copyWith(color: Constants.BrightRed),
//                                   textAlign: TextAlign.left,
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "BT0007a0",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Black),
//                                   textAlign: TextAlign.left,
//                                 ),
//                                 Text(
//                                   "Driver",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Black),
//                                   textAlign: TextAlign.left,
//                                 ),
//                                 Text(
//                                   "Status",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Black),
//                                   textAlign: TextAlign.left,
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   "09 Sept, 2021",
//                                   style: Constants.regular4
//                                       .copyWith(color: Constants.Grey),
//                                   textAlign: TextAlign.left,
//                                 ),
//                                 Text(
//                                   "Pending",
//                                   style: Constants.regular4
//                                       .copyWith(color: Constants.BrightRed),
//                                   textAlign: TextAlign.left,
//                                 ),
//                                 Text(
//                                   "Pending",
//                                   style: Constants.regular4
//                                       .copyWith(color: Constants.Grey),
//                                   textAlign: TextAlign.left,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Image.asset(
//                                   "assets/images/vehicle.png",
//                                   height: 50,
//                                 ),
//                                 Text(
//                                   "20 Feet Container",
//                                   style: Constants.regular4
//                                       .copyWith(color: Constants.Grey),
//                                   textAlign: TextAlign.left,
//                                 ),
//                                 Text(
//                                   "Pending",
//                                   style: Constants.regular4
//                                       .copyWith(color: Constants.BrightRed),
//                                   textAlign: TextAlign.left,
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "BT0007a1",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Black),
//                                   textAlign: TextAlign.left,
//                                 ),
//                                 Text(
//                                   "Driver",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Black),
//                                   textAlign: TextAlign.left,
//                                 ),
//                                 Text(
//                                   "Status",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Black),
//                                   textAlign: TextAlign.left,
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   "09 Sept, 2021",
//                                   style: Constants.regular4
//                                       .copyWith(color: Constants.Grey),
//                                   textAlign: TextAlign.left,
//                                 ),
//                                 Text(
//                                   "Pending",
//                                   style: Constants.regular4
//                                       .copyWith(color: Constants.BrightRed),
//                                   textAlign: TextAlign.left,
//                                 ),
//                                 Text(
//                                   "Pending",
//                                   style: Constants.regular4
//                                       .copyWith(color: Constants.Grey),
//                                   textAlign: TextAlign.left,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                     // TextButton(
//                     //     onPressed: () => {
//                     //           Navigator.push(
//                     //               context,
//                     //               MaterialPageRoute(
//                     //                   builder: (context) => SingleBilty()))
//                     //         },
//                     //     child: Text("Go To Single Bilty"))
//                   ],
//                 ),
//               ),
//             )
//           ),
//           ),
//         );
//       }
//     );
// }

// var name = ["Ahmed","Ahmed","Ahmed","Ahmed","Ahmed","Ahmed","Ahmed","Ahmed","Ahmed","Ahmed",];

// var status = [switchRayyan("pending"),switchRayyan("inprocess"),switchRayyan("driver_reached"),
//               switchRayyan("driver_pickup"),switchRayyan("driver_delivered"),switchRayyan("container_returned"),
//               switchRayyan("driver_reached"),switchRayyan("driver_pickup"),switchRayyan("driver_reached"),
//               switchRayyan("driver_pickup")
// ];
// var pending = ["Ahmed","Ahmed","Ahmed","Ahmed","Ahmed","Ahmed","Ahmed","Ahmed","Ahmed","Ahmed",];


// // Show All Bilties(Rayyan)
// void showRayyan(context) {
//   showModalBottomSheet(
//       shape:const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(20.0)
//         )
//       ),
//       backgroundColor: Colors.white,
//       context: context,
      
//       builder: (BuildContext buildcontext) {
//         return SingleChildScrollView(
//           child: SafeArea(
//             child: Container(
//             height: MediaQuery.of(context).size.height * .60,
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 child: Column(
//                   children: [
//                     Text(
//                       "Order Bilties",
//                       style:
//                           Constants.heading3.copyWith(color: Constants.Primary),
//                     ),
//                     Column(
//                       children: [
//                         // Row(
//                         //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         //   children: [
//                         //     Column(
//                         //       mainAxisAlignment: MainAxisAlignment.start,
//                         //       crossAxisAlignment: CrossAxisAlignment.start,
//                         //       children: [
//                         //         Image.asset(
//                         //           "assets/images/vehicle.png",
//                         //           height: 50,
//                         //         ),
//                         //         Text(
//                         //           "20 Feet Container",
//                         //           style: Constants.regular4
//                         //               .copyWith(color: Constants.Grey),
//                         //           textAlign: TextAlign.left,
//                         //         ),
//                         //         switchRayyan("driver_reached"),
//                         //       ],
//                         //     ),
//                         //     Column(
//                         //       mainAxisAlignment: MainAxisAlignment.start,
//                         //       crossAxisAlignment: CrossAxisAlignment.start,
//                         //       children: [
//                         //         Text(
//                         //           "BT0007a0",
//                         //           style: Constants.heading4
//                         //               .copyWith(color: Constants.Black),
//                         //           textAlign: TextAlign.left,
//                         //         ),
//                         //         Text(
//                         //           "Driver",
//                         //           style: Constants.heading4
//                         //               .copyWith(color: Constants.Black),
//                         //           textAlign: TextAlign.left,
//                         //         ),
//                         //         Text(
//                         //           "Status",
//                         //           style: Constants.heading4
//                         //               .copyWith(color: Constants.Black),
//                         //           textAlign: TextAlign.left,
//                         //         ),
//                         //       ],
//                         //     ),
//                         //     Column(
//                         //       mainAxisAlignment: MainAxisAlignment.start,
//                         //       crossAxisAlignment: CrossAxisAlignment.end,
//                         //       children: [
//                         //         Text(
//                         //           "09 Sept, 2021",
//                         //           style: Constants.regular4
//                         //               .copyWith(color: Constants.Grey),
//                         //           textAlign: TextAlign.left,
//                         //         ),
//                         //         switchRayyan("driver_reached"),
//                         //         Text(
//                         //           "Pending",
//                         //           style: Constants.regular4
//                         //               .copyWith(color: Constants.Grey),
//                         //           textAlign: TextAlign.left,
//                         //         ),
//                         //       ],
//                         //     )
//                         //   ],
//                         // ),
//                         Container(
//                           height: 400,
//                           child: ListView.builder(
//                             padding: EdgeInsets.all(10.0),
//                              //scrollDirection: Axis.horizontal,
//                              scrollDirection: Axis.vertical,
//                              shrinkWrap: true,
//                             itemCount: 6,
//                             itemBuilder: (BuildContext context, int index) {
//                             // final Continent option = options.elementAt(index);
                          
//                             return GestureDetector(
//                             onTap: () {
//                             // onSelected(option);
//                               // Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //         builder: (context) => SingleBilty(biltyNo: ,)));
//                             },
//                             child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Image.asset(
//                                   "assets/images/vehicle.png",
//                                   height: 50,
//                                 ),
//                                 Text(
//                                   "20 Feet Container",
//                                   style: Constants.regular4
//                                       .copyWith(color: Constants.Grey),
//                                   textAlign: TextAlign.left,
//                                 ),
//                                 status[index],
//                               ],
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "BT0007a0",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Black),
//                                   textAlign: TextAlign.left,
//                                 ),
//                                 Text(
//                                   "Driver",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Black),
//                                   textAlign: TextAlign.left,
//                                 ),
//                                 Text(
//                                   "Status",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Black),
//                                   textAlign: TextAlign.left,
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   "09 Sept, 2021",
//                                   style: Constants.regular4
//                                       .copyWith(color: Constants.Grey),
//                                   textAlign: TextAlign.left,
//                                 ),
//                                 status[index],
//                                 Text(
//                                   "Pending",
//                                   style: Constants.regular4
//                                       .copyWith(color: Constants.Grey),
//                                   textAlign: TextAlign.left,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                             );
//                             },
//                           ),
//                         ),

//                       ],
//                     ),
//                     // TextButton(
//                     //     onPressed: () => {
//                     //           Navigator.push(
//                     //               context,
//                     //               MaterialPageRoute(
//                     //                   builder: (context) => SingleBilty()))
//                     //         },
//                     //     child: Text("Go To Single Bilty"))
//                   ],
//                 ),
//               ),
//             )
//           ),
//           ),
//         );
//       }
//     );
// }

//   switchRayyan(position) {
//   // var pend = "pending";
//   // var Inproc = "Inprocess";
//   // var reach = "driver_reached";
//   // var pickup = "driver_pickup";
//   // var delivered = "driver_delivered";
//   // var returned = "container_returned";
//   // var position ;
//   switch(position){
//       case "pending" :
//             return  Text("pending",
//             style: TextStyle(color: Constants.BrightRed),
//             );
//             break;
//       case "inprocess" :
//             return  Text("inprocess",
//             style: TextStyle(color: Constants.Black),
//             ) ;
//             break;
//       case "driver_reached" :
//             return  Text("driver_reached",
//             style: TextStyle(color: Colors.green[500]),
//             ) ;
//       case "driver_pickup" :
//             return  Text("driver_pickup",
//             style: TextStyle(color: Colors.blue[500]),
//             ) ;
//       case "driver_delivered" :
//             return  Text("driver_delivered",
//             style: TextStyle(color: Constants.Secondary),
//             ) ;
//       case "container_returned" :
//             return  Text("container_returned",
//             style: TextStyle(color: Constants.Secondarylight),
//             ) ;
       
//   }

// }