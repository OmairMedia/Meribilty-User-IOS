// import 'package:meribiltyapp/config/constants.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// // TODO: Need Side Drawer
// import 'package:meribiltyapp/screens/ppl/home.dart';
// import 'package:meribiltyapp/screens/scm/home.dart';
// import 'package:dots_indicator/dots_indicator.dart';

// class Homebackup extends StatefulWidget {
//   const Homebackup({Key? key}) : super(key: key);

//   @override
//   _HomebackupState createState() => _HomebackupState();
// }

// class _HomebackupState extends State<Homebackup> {
//   @override
//   Widget build(BuildContext context) {
//     const _totalDots = 3;
//     double _currentPosition = 0.0;

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //       builder: (context) => const Darwe()),
//                           // );
//                         },
//                         child: Align(
//                           alignment: Alignment.topLeft,
//                           child: Image.asset(
//                             'assets/menu.png',
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             "Hi Ahmed,",
//                             textAlign: TextAlign.end,
//                             style: Constants.heading2.copyWith(color: Constants.Primary),
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Align(
//                             alignment: Alignment.bottomRight,
//                             child: Text(
//                               // AppLocalizations.of(context)!.market,
//                               "Market me sub se best rates",
//                               style: Constants.heading4.copyWith(color: Constants.Primary),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     // const SizedBox(
//                     //   width: 280,
//                     // ),
//                     Column(
//                       children: [
//                         Image.asset("assets/Noti.png"),
//                         const SizedBox(
//                           height: 3,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Image.asset(
//                       "assets/mes.png",
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   child: Text(
//                     // AppLocalizations.of(context)!.top,
//                     "Top Services",
//                     style: Constants.heading2.copyWith(color: Constants.Primary),
//                   ),
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   // padding: const EdgeInsets.all(2),
//                   child: Column(
//                     children: [
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 padding: const EdgeInsets.all(12),
//                                 decoration: const BoxDecoration(
//                                     color: Color(0xFF2F4D84),
//                                     borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(20.0),
//                                       bottomLeft: Radius.circular(20.0),
//                                       bottomRight: Radius.circular(20.0),
//                                     )),
//                                 width: 160,
//                                 height: 330,
//                                 child: InkWell(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                              PPLHome()),
//                                     );
//                                   },
//                                   child: Column(
//                                     children: [
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       Container(
//                                         padding: const EdgeInsets.all(10),
//                                         height: 170,
//                                         width: 140,
//                                         decoration: const BoxDecoration(
//                                             color: Colors.white,
//                                             image: DecorationImage(
//                                                 image: AssetImage(
//                                                     'assets/hom.jpg'),
//                                                 fit: BoxFit.cover),
//                                             borderRadius: BorderRadius.only(
//                                               topRight: Radius.circular(20.0),
//                                               bottomLeft: Radius.circular(20.0),
//                                               bottomRight:
//                                                   Radius.circular(20.0),
//                                             )),
//                                         child: const Text(""),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       SizedBox(
//                                         width: double.infinity,
//                                         child: Text(
//                                           // AppLocalizations.of(context)!.port,
//                                           "Project &\nPort Logistics",
//                                           style: Constants.heading3.copyWith(color: Constants.White),
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       SizedBox(
//                                         width: double.infinity,
//                                         child: Text(
//                                           // AppLocalizations.of(context)!.cargo,
//                                           "Cargo movements and Shipments to all over Pakistan &More",
//                                          style: Constants.heading5.copyWith(color: Constants.White),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             //
//                             const SizedBox(
//                               width: 8,
//                             ),
//                             Expanded(
//                               child: Container(
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: const BoxDecoration(
//                                     color: Color(0xFF2F4D84),
//                                     borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(20.0),
//                                       bottomLeft: Radius.circular(20.0),
//                                       bottomRight: Radius.circular(20.0),
//                                     )),
//                                 width: 165,
//                                 height: 330,
//                                 child: InkWell(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const SCMHome()),
//                                     );
//                                   },
//                                   child: Column(
//                                     children: [
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       Container(
//                                         padding: const EdgeInsets.all(10),
//                                         height: 173,
//                                         width: 130,
//                                         decoration: const BoxDecoration(
//                                             color: Colors.white,
//                                             image: DecorationImage(
//                                                 image: AssetImage(
//                                                     'assets/city.jpg'),
//                                                 fit: BoxFit.cover),
//                                             borderRadius: BorderRadius.only(
//                                               topRight: Radius.circular(20.0),
//                                               bottomLeft: Radius.circular(20.0),
//                                               bottomRight:
//                                                   Radius.circular(20.0),
//                                             )),
//                                         child: const Text(""),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       SizedBox(
//                                         width: double.infinity,
//                                         child: Text(
//                                           // AppLocalizations.of(context)!.same,
//                                           "Same City \nMovement",
//                                          style: Constants.heading3.copyWith(color: Constants.White),
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       SizedBox(
//                                         width: double.infinity,
//                                         child: Text(
//                                           // AppLocalizations.of(context)!.delivsmall,
//                                           "Small deliveries Home shifting and commercial vehicles",
//                                          style: Constants.heading5.copyWith(color: Constants.White),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       SizedBox(
//                         width: double.infinity,
//                         child: Text(
//                           // AppLocalizations.of(context)!.coming,
//                           "Coming Soon",
//                           style: Constants.heading3.copyWith(color: Constants.Primary),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.only(left: 10),
//                               height: 140,
//                               width: 140,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border: Border.all(
//                                       color: const Color(0xFF2F4D84), width: 3),
//                                   borderRadius: const BorderRadius.only(
//                                     topRight: Radius.circular(20.0),
//                                     bottomLeft: Radius.circular(20.0),
//                                     bottomRight: Radius.circular(20.0),
//                                   )),
//                               child: Center(
//                                 child: Column(
//                                   children: [
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Image.asset(
//                                       "assets/po.png",
//                                       width: 70,
//                                     ),
//                                     Text(
//                                       // AppLocalizations.of(context)!.ware,
//                                       "Warehouse",
//                                       style: Constants.heading3.copyWith(color: Constants.Primary),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             Container(
//                               padding: const EdgeInsets.only(left: 10),
//                               height: 140,
//                               width: 140,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border: Border.all(
//                                       color: const Color(0xFF2F4D84), width: 3),
//                                   borderRadius: const BorderRadius.only(
//                                     topRight: Radius.circular(20.0),
//                                     bottomLeft: Radius.circular(20.0),
//                                     bottomRight: Radius.circular(20.0),
//                                   )),
//                               child: Center(
//                                 child: Column(
//                                   children: [
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Image.asset(
//                                       "assets/water.png",
//                                       width: 70,
//                                     ),
//                                     Text(
//                                       // AppLocalizations.of(context)!.water,
//                                       "Water Tanker",
//                                       style: Constants.heading3.copyWith(color: Constants.Primary),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             Container(
//                               padding: const EdgeInsets.only(left: 10),
//                               height: 140,
//                               width: 140,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border: Border.all(
//                                       color: const Color(0xFF2F4D84), width: 3),
//                                   borderRadius: const BorderRadius.only(
//                                     topRight: Radius.circular(20.0),
//                                     bottomLeft: Radius.circular(20.0),
//                                     bottomRight: Radius.circular(20.0),
//                                   )),
//                               child: Center(
//                                 child: Column(
//                                   children: [
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Image.asset(
//                                       "assets/car.png",
//                                       width: 70,
//                                     ),
//                                     Text(
//                                       // AppLocalizations.of(context)!.car,
//                                       "Rent a car",
//                                      style: Constants.heading3.copyWith(color: Constants.Primary),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             //

//                             Container(
//                               padding: const EdgeInsets.only(left: 10),
//                               height: 140,
//                               width: 140,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border: Border.all(
//                                       color: const Color(0xFF2F4D84), width: 3),
//                                   borderRadius: const BorderRadius.only(
//                                     topRight: Radius.circular(20.0),
//                                     bottomLeft: Radius.circular(20.0),
//                                     bottomRight: Radius.circular(20.0),
//                                   )),
//                               child: Center(
//                                 child: Column(
//                                   children: [
//                                     const SizedBox(
//                                       height: 20,
//                                     ),
//                                     Image.asset(
//                                       "assets/sea.png",
//                                       width: 50,
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text(
//                                       // AppLocalizations.of(context)!.sea,
//                                       "Sea Freight",
//                                      style: Constants.heading3.copyWith(color: Constants.Primary),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),

//                             Container(
//                               padding: const EdgeInsets.only(left: 10),
//                               height: 140,
//                               width: 140,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border: Border.all(
//                                       color: const Color(0xFF2F4D84), width: 3),
//                                   borderRadius: const BorderRadius.only(
//                                     topRight: Radius.circular(20.0),
//                                     bottomLeft: Radius.circular(20.0),
//                                     bottomRight: Radius.circular(20.0),
//                                   )),
//                               child: Center(
//                                 child: Column(
//                                   children: [
//                                     const SizedBox(
//                                       height: 20,
//                                     ),
//                                     Image.asset(
//                                       "assets/air.png",
//                                       width: 50,
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text(
//                                       // AppLocalizations.of(context)!.air,
//                                       "Air Freight",
//                                       style: Constants.heading3.copyWith(color: Constants.Primary),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       CarouselSlider(
//                         items: [
//                           //1st Image of Slider
//                           Container(
//                             margin: const EdgeInsets.all(6.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8.0),
//                               image: const DecorationImage(
//                                 image: AssetImage('assets/img1.png'),
//                               ),
//                             ),
//                           ),

//                           //2nd Image of Slider
//                           Container(
//                             margin: const EdgeInsets.all(6.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8.0),
//                               image: const DecorationImage(
//                                 image: AssetImage('assets/img1.png'),
//                               ),
//                             ),
//                           ),

//                           Container(
//                             margin: const EdgeInsets.all(6.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8.0),
//                               image: const DecorationImage(
//                                 image: AssetImage('assets/img1.png'),
//                               ),
//                             ),
//                           ),
//                         ],
//                         options: CarouselOptions(
//                           height: 200,
//                           enlargeCenterPage: false,
//                           autoPlay: true,
//                           aspectRatio: 16 / 9,
//                           autoPlayCurve: Curves.fastOutSlowIn,
//                           enableInfiniteScroll: true,
//                           autoPlayAnimationDuration:
//                               const Duration(milliseconds: 1800),
//                           viewportFraction: 1,
//                         ),
//                       ),
//                       DotsIndicator(
//                         dotsCount: _totalDots,
//                         position: _currentPosition,
//                         decorator: const DotsDecorator(
//                           activeColor: Color(0xFF2F4D84),
//                           spacing: EdgeInsets.all(10.0),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       SizedBox(
//                         width: double.infinity,
//                         child: Text(
//                           // AppLocalizations.of(context)!.need,
//                           "Need Vehicle Spare parts?",
//                         style: Constants.heading3.copyWith(color: Constants.Primary),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(10),
//                         height: 200,
//                         width: 140,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(color: Colors.black12, width: 3),
//                             borderRadius: const BorderRadius.only(
//                               topRight: Radius.circular(20.0),
//                               bottomLeft: Radius.circular(20.0),
//                               bottomRight: Radius.circular(20.0),
//                             )),
//                         child: Center(
//                           child: Column(
//                             children: [
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               Image.asset(
//                                 "assets/acc1.png",
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               Text(
//                                 // AppLocalizations.of(context)!.access,
//                                 "Accessories",
//                                style: Constants.heading4.copyWith(color: Constants.Primary),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Container(
//                         padding: const EdgeInsets.all(10),
//                         height: 200,
//                         width: 140,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(color: Colors.black12, width: 3),
//                             borderRadius: const BorderRadius.only(
//                               topRight: Radius.circular(20.0),
//                               bottomLeft: Radius.circular(20.0),
//                               bottomRight: Radius.circular(20.0),
//                             )),
//                         child: Center(
//                           child: Column(
//                             children: [
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               Image.asset(
//                                 "assets/acc2.png",
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               Text(
//                                 // AppLocalizations.of(context)!.tyres,
//                                 "Tyres & Wheels",
//                                style: Constants.heading4.copyWith(color: Constants.Primary),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Container(
//                         padding: const EdgeInsets.all(10),
//                         height: 200,
//                         width: 140,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(color: Colors.black12, width: 3),
//                             borderRadius: const BorderRadius.only(
//                               topRight: Radius.circular(20.0),
//                               bottomLeft: Radius.circular(20.0),
//                               bottomRight: Radius.circular(20.0),
//                             )),
//                         child: Center(
//                           child: Column(
//                             children: [
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               Image.asset(
//                                 "assets/acc3.PNG",
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               Text(
//                                 // AppLocalizations.of(context)!.braker,
//                                 "Braker & Drum\n Assembly",
//                                 textAlign: TextAlign.center,
//                                style: Constants.heading4.copyWith(color: Constants.Primary),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Container(
//                         padding: const EdgeInsets.all(10),
//                         height: 200,
//                         width: 140,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(color: Colors.black12, width: 3),
//                             borderRadius: const BorderRadius.only(
//                               topRight: Radius.circular(20.0),
//                               bottomLeft: Radius.circular(20.0),
//                               bottomRight: Radius.circular(20.0),
//                             )),
//                         child: Center(
//                           child: Column(
//                             children: [
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               Image.asset(
//                                 "assets/engine-oil.png",
//                                 width: 80,
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                                Text(
//                                 "Automotive",
//                                style: Constants.heading4.copyWith(color: Constants.Primary),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Container(
//                         padding: const EdgeInsets.all(10),
//                         height: 200,
//                         width: 140,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(color: Colors.black12, width: 3),
//                             borderRadius: const BorderRadius.only(
//                               topRight: Radius.circular(20.0),
//                               bottomLeft: Radius.circular(20.0),
//                               bottomRight: Radius.circular(20.0),
//                             )),
//                         child: Center(
//                           child: Column(
//                             children: [
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               Image.asset(
//                                 "assets/sus.png",
//                                 width: 80,
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                                Text(
//                                 "Suspension & Steering",
//                                 textAlign: TextAlign.center,
//                                style: Constants.heading4.copyWith(color: Constants.Primary),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Container(
//                         padding: const EdgeInsets.all(10),
//                         height: 200,
//                         width: 140,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(color: Colors.black12, width: 3),
//                             borderRadius: const BorderRadius.only(
//                               topRight: Radius.circular(20.0),
//                               bottomLeft: Radius.circular(20.0),
//                               bottomRight: Radius.circular(20.0),
//                             )),
//                         child: Center(
//                           child: Column(
//                             children: [
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               Image.asset(
//                                 "assets/bodyparts.png",
//                                 width: 80,
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                                Text(
//                                 "Body Parts",
//                                 style: Constants.heading4.copyWith(color: Constants.Primary),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Container(
//                         padding: const EdgeInsets.all(10),
//                         height: 200,
//                         width: 140,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(color: Colors.black12, width: 3),
//                             borderRadius: const BorderRadius.only(
//                               topRight: Radius.circular(20.0),
//                               bottomLeft: Radius.circular(20.0),
//                               bottomRight: Radius.circular(20.0),
//                             )),
//                         child: Center(
//                           child: Column(
//                             children: [
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               Image.asset(
//                                 "assets/engine.png",
//                                 width: 80,
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                                Text(
//                                 "Engine",
//                                style: Constants.heading4.copyWith(color: Constants.Primary),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       InkWell(
//                         onTap: () {
//                           _launchURL();
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.all(10),
//                           height: 200,
//                           width: 140,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               border:
//                                   Border.all(color: Colors.black12, width: 3),
//                               borderRadius: const BorderRadius.only(
//                                 topRight: Radius.circular(20.0),
//                                 bottomLeft: Radius.circular(20.0),
//                                 bottomRight: Radius.circular(20.0),
//                               )),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 const SizedBox(
//                                   height: 20,
//                                 ),
//                                 Image.asset(
//                                   "assets/more.png",
//                                   width: 80,
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                  Text(
//                                   "More ",
//                                  style: Constants.heading4.copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                     padding: const EdgeInsets.all(7),
//                     width: double.infinity,
//                     child: Container(
//                       width: double.infinity,
//                       height: 70,
//                       padding: const EdgeInsets.all(10),
//                       child: ElevatedButton(
//                         child: Center(
//                           child: Row(
//                             children: [
//                               const SizedBox(
//                                 width: 40,
//                               ),
//                               Image.asset('assets/add.png'),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                   // AppLocalizations.of(context)!.neehelp,
//                                   "Need help? click here",
//                                  style: Constants.heading5.copyWith(color: Constants.Primary)),
//                             ],
//                           ),
//                         ),
//                         style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                                 const Color(0xffEAEAFF)),
//                             shape: MaterialStateProperty.all<
//                                 RoundedRectangleBorder>(
//                               const RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(18)),
//                                   side: BorderSide(color: Colors.white)),
//                             )),
//                         onPressed: () {
//                           _launchURL();
//                         },
//                       ),
//                     )),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// _launchURL() async {
//   const url = 'https://www.google.com/';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
