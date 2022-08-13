// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:meribiltyapp/config/constants.dart';
// import 'package:meribiltyapp/screens/ppl/select_payment_method.dart';
// import 'package:meribiltyapp/widgets/btns_all.dart';
// import 'package:meribiltyapp/widgets/custuminput.dart';
// import 'package:meribiltyapp/widgets/location.dart';
// import 'package:meribiltyapp/widgets/transit/subordercard.dart';

// class TransitOfferReceivedCard extends StatefulWidget {
//   final String status;
//   const TransitOfferReceivedCard({Key? key, required this.status})
//       : super(key: key);

//   @override
//   _TransitOfferReceivedCardState createState() =>
//       _TransitOfferReceivedCardState();
// }

// class _TransitOfferReceivedCardState extends State<TransitOfferReceivedCard> {
//   TextEditingController amount = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Constants.White,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//         side: BorderSide(color: Constants.QouteReceived, width: 1),
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(15), topRight: Radius.circular(15)),
//               color: Constants.QouteReceived,
//             ),
//             child: Center(
//               child: Text(
//                 "Offer Received",
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
//                       "Order#0002",
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
//                 ), SizedBox(height:8),
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
//               child: ButtonBar(
//                 children: [
//                   TextButton(
//                       style: TextButton.styleFrom(
//                         primary: Constants.Success,
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => SelectPaymentMethod(orderNo: "Test",)));
//                       },
//                       child: Text("Accept")),
//                   TextButton(
//                       style: TextButton.styleFrom(
//                         primary: Constants.CounterOfferReceived,
//                       ),
//                       onPressed: () {
//                         sendCounterOfferModel(context);
//                       },
//                       child: Text("Counter")),
//                   TextButton(
//                       style: TextButton.styleFrom(
//                         primary: Constants.BrightRed,
//                       ),
//                       onPressed: () {
//                         rejectOffer(context);
//                       },
//                       child: Text("Reject")),
//                 ],
//               ))
//         ],
//       ),
//     );
//   }
// }

// void sendCounterOfferModel(context) {
//   TextEditingController amount = TextEditingController();
//   showModalBottomSheet(
//       context: context,
//       builder: (BuildContext buildcontext) {
//         return SingleChildScrollView(
//           child: SafeArea(
//             child: Container(
                
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text(
//                         "If your counter is accepted, the transaction will be considered confirmed If you reject a 5% penalty will be applied of the value. Enter the counter offer below, which you want to send to the vendor",
//                         style:
//                             Constants.regular4.copyWith(color: Constants.Grey),
//                         textAlign: TextAlign.center,
//                       ),
//                       custominput(
//                           hinttxt: "Amount",
//                           ispassword: false,
//                           control: amount,
//                           inputType: TextInputType.text),
//                       CustomBtn(
//                           text: "Send Counter Offer",
//                           onpreased: () {},
//                           outlinebtn: false)
//                     ],
//                   ),
//                 )),
//           ),
//         );
//       });
// }

// void rejectOffer(context) {
//   TextEditingController amount = TextEditingController();
//   showModalBottomSheet(
//       context: context,
//       builder: (BuildContext buildcontext) {
//         return SingleChildScrollView(
//           child: SafeArea(
//             child: Container(
            
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Icon(FontAwesomeIcons.solidCheckCircle,
//                       size: 64, color: Constants.BrightRed),
//                   Text(
//                     "Offer Rejected !",
//                     style:
//                         Constants.heading2.copyWith(color: Constants.Primary),
//                     textAlign: TextAlign.center,
//                   ),
//                   Text(
//                     "You have rejected the offer. Your order details are saved in your profile.",
//                     style: Constants.regular4.copyWith(color: Constants.Grey),
//                     textAlign: TextAlign.center,
//                   ),
//                   CustomBtn(text: "Done", onpreased: () {
//                     Navigator.of(context).pop();
//                   }, outlinebtn: false)
//                 ],
//               ),
//             )
//           ),
//           ),
//         );
//       });
// }
