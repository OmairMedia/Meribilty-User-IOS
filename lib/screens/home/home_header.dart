// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:meribiltyapp/Api%20Services/wallet/wallet_controller_getx.dart';
// import 'package:meribiltyapp/constants/main_constants.dart';
// import 'package:meribiltyapp/screens/authentication/signin.dart';
// import 'package:meribiltyapp/config/constants.dart';
// import 'package:meribiltyapp/screens/drawer_pages/chat.dart';
// import 'package:meribiltyapp/screens/drawer_pages/my_notifications.dart';
// import 'package:meribiltyapp/screens/drawer_pages/my_team.dart';
// import 'package:meribiltyapp/screens/drawer_pages/my_wallet.dart';
// import 'package:meribiltyapp/screens/drawer_pages/settings.dart';
// import 'package:meribiltyapp/screens/home/drawer_User.dart';
// import 'package:meribiltyapp/screens/home/home.dart';
// import 'package:meribiltyapp/screens/drawer_pages/my_deliveries.dart';
// import 'package:meribiltyapp/screens/ppl/single_bilty_upcountry.dart';
// import 'package:http/http.dart' as http;



// class HomeHeader extends StatefulWidget {
//   HomeHeader({Key? key}) : super(key: key);

//   @override
//   State<HomeHeader> createState() => _HomeHeaderState();
// }

// class _HomeHeaderState extends State<HomeHeader> {
//   WalletData _wd = WalletData();
//   fetchwallet() async {
//     var headers = {'Content-Type': 'application/json'};

//     Uri apiurl = Uri.parse('https://api.meribilty.com/api/get_wallet');
//     var response = await http.Client().post(apiurl,
//         headers: headers, body: json.encode({"token": box.read('token')}));
//     var responseMap = await json.decode(response.body);
//     if (response.statusCode == 200) {
//       var jsonString = response.body;
//       print("Successfully fetched wallet");
//       setState(() {
//         _wd.walletAmount = responseMap['data']['amount'];
//         _wd.type = responseMap['data']['type'];
//       });
//     } else {
//       print(response.body);
//       print("There is an error");
//       throw Exception('Failed to load wallet');
//     }
//   }

//   @override
//   void initState() {
//     fetchwallet();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Constants.Primary,
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height / 3,
//       child: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.only(left: 20, right: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // AvatarImage(imageurl: "assets/images/Avatar.png"),
//             Text(
//               box.read('fullname'),
//               style: Constants.heading2.copyWith(color: Constants.White),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
//                   decoration: BoxDecoration(
//                       color: Constants.White,
//                       borderRadius: BorderRadius.circular(15)),
//                   child: Row(
//                     children: [
//                       Text(
//                         "${_wd.type} ",
//                         style: Constants.regular1.copyWith(fontSize: 16),
//                       ),
//                       Text(
//                         "${_wd.walletAmount} ",
//                         style: Constants.heading3,
//                       ),
//                       Icon(FontAwesomeIcons.chevronRight, size: 12),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Icon(
//                       FontAwesomeIcons.bell,
//                       color: Constants.White,
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Icon(
//                       FontAwesomeIcons.comment,
//                       color: Constants.White,
//                     ),
//                   ],
//                 )
//               ],
//             )
//           ],
//         ),
//       )),
//     );
//   }
// }

// // class AvatarImage extends StatefulWidget {
// //   String imageurl;
// //   AvatarImage({Key? key, required this.imageurl}) : super(key: key);

// //   @override
// //   State<AvatarImage> createState() => _AvatarImageState();
// // }

// // class _AvatarImageState extends State<AvatarImage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       width: 120,
// //       height: 120,
// //       padding: const EdgeInsets.all(8),
// //       child: Container(
// //         padding: const EdgeInsets.all(3),
// //         child: Container(
// //           decoration: BoxDecoration(
// //             shape: BoxShape.circle,
// //             image: DecorationImage(
// //                 image: AssetImage(widget.imageurl),
// //                 fit: BoxFit.contain,
// //                 scale: 1.0),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class HomeBody extends StatelessWidget {
// //   HomeBody({Key? key}) : super(key: key);
// //   GetWalletController _getWalletController = Get.put(GetWalletController());
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       child: Padding(
// //         padding: const EdgeInsets.all(15.0),
// //         child: Column(
// //           children: [
// //             ListTileforDrawer(
// //               icon: FontAwesomeIcons.home,
// //               txt: "Home",
// //               onTap: () {
// //                 Navigator.push(context,
// //                     MaterialPageRoute(builder: (context) =>  Home()));
// //               },
// //             ),
// //             ListTileforDrawer(
// //               icon: FontAwesomeIcons.briefcase,
// //               txt: "My Deliveries",
// //               onTap: () {
// //                 Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                         builder: (context) => const MyDeliveries()));
// //               },
// //             ),
// //             ListTileforDrawer(
// //               icon: FontAwesomeIcons.wallet,
// //               txt: "My Wallet",
// //               onTap: () async{
// //                 await _getWalletController.fetchWallet();
// //                 Navigator.push(context,
// //                     MaterialPageRoute(builder: (context) => const MyWallet()));
// //               },
// //             ),
// //             ListTileforDrawer(
// //               icon: FontAwesomeIcons.wallet,
// //               txt: "My Team",
// //               onTap: () {
// //                 Navigator.push(context,
// //                     MaterialPageRoute(builder: (context) => const MyTeam()));
// //               },
// //             ),
// //             ListTileforDrawer(
// //               icon: FontAwesomeIcons.comment,
// //               txt: "Chat",
// //               onTap: () {
// //                 Navigator.push(context,
// //                     MaterialPageRoute(builder: (context) => const SingleBiltyTransit(biltyNo: "BT0013a0")));
// //               },
// //             ),
// //             ListTileforDrawer(
// //               icon: FontAwesomeIcons.bell,
// //               txt: "Notification",
// //               onTap: () {
// //                 Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                         builder: (context) => const MyNotifications()));
// //               },
// //             ),
// //             ListTileforDrawer(
// //               icon: FontAwesomeIcons.cog,
// //               txt: "Setting",
// //               onTap: () {
// //                 Navigator.push(context,
// //                     MaterialPageRoute(builder: (context) => const Settings()));
// //               },
// //             ),
// //             ListTileforDrawer(
// //               icon: FontAwesomeIcons.signOutAlt,
// //               txt: "Log Out",
// //               onTap: () {
// //                 showDialog(
// //                     context: context,
// //                     builder: (BuildContext context) => AlertDialog(
// //                           title: Text(
// //                             'Logout',
// //                             style: Constants.regular3,
// //                           ),
// //                           content: Text(
// //                             'Are you sure you want to logout ?',
// //                             style: Constants.regular2,
// //                           ),
// //                           actions: [
// //                             TextButton(
// //                                 onPressed: () {
// //                                   Navigator.pop(context);
// //                                 },
// //                                 child: const Text(
// //                                   'Cancel',
// //                                   style: TextStyle(color: Colors.red),
// //                                 )),
// //                             TextButton(
// //                                 onPressed: () {
// //                                   Navigator.push(
// //                                       context,
// //                                       MaterialPageRoute(
// //                                           builder: (context) =>
// //                                                SignIn()));
// //                                 },
// //                                 child: const Text(
// //                                   'OK',
// //                                   style: TextStyle(color: Colors.green),
// //                                 ))
// //                           ],
// //                         ));
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// class HomeBody extends StatelessWidget {
//   HomeBody({Key? key}) : super(key: key);
//   GetWalletController _getWalletController = Get.put(GetWalletController());
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             ListTileforDrawer(
//               icon: FontAwesomeIcons.home,
//               txt: "Home",
//               onTap: () {
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (context) => Home()));
//               },
//             ),
//             ListTileforDrawer(
//               icon: FontAwesomeIcons.briefcase,
//               txt: "My Deliveries",
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>const MyDeliveries()));
//               },
//             ),
//             ListTileforDrawer(
//               icon: FontAwesomeIcons.wallet,
//               txt: "My Wallet",
//               onTap: () async {
//                 await _getWalletController.fetchWallet();
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const MyWallet()));
//               },
//             ),
//             ListTileforDrawer(
//               icon: FontAwesomeIcons.wallet,
//               txt: "My Team",
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const MyTeam()));
//               },
//             ),
//             ListTileforDrawer(
//               icon: FontAwesomeIcons.comment,
//               txt: "Chat",
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             const SingleBiltyTransit(biltyNo: "BT0013a0")));
//               },
//             ),
//             ListTileforDrawer(
//               icon: FontAwesomeIcons.bell,
//               txt: "Notification",
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const MyNotifications()));
//               },
//             ),
//             ListTileforDrawer(
//               icon: FontAwesomeIcons.cog,
//               txt: "Setting",
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const Settings()));
//               },
//             ),
//             ListTileforDrawer(
//               icon: FontAwesomeIcons.signOutAlt,
//               txt: "Log Out",
//               onTap: () {
//                 showDialog(
//                     context: context,
//                     builder: (BuildContext context) => AlertDialog(
//                           title: Text(
//                             'Logout',
//                             style: Constants.regular3,
//                           ),
//                           content: Text(
//                             'Are you sure you want to logout ?',
//                             style: Constants.regular2,
//                           ),
//                           actions: [
//                             TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: const Text(
//                                   'Cancel',
//                                   style: TextStyle(color: Colors.red),
//                                 )),
//                             TextButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                                SignIn()));
//                                 },
//                                 child: const Text(
//                                   'OK',
//                                   style: TextStyle(color: Colors.green),
//                                 ))
//                           ],
//                         ));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class ListTileforDrawer extends StatelessWidget {
// //   String txt;
// //   IconData icon;
// //   Function onTap;
// //   ListTileforDrawer(
// //       {Key? key, required this.icon, required this.txt, required this.onTap})
// //       : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () {
// //         onTap();
// //       },
// //       child: Padding(
// //         padding: const EdgeInsets.all(15.0),
// //         child: Row(
// //           children: [
// //             Icon(
// //               icon,
// //               color: Constants.Grey,
// //             ),
// //             SizedBox(
// //               width: 15,
// //             ),
// //             Text(
// //               txt,
// //               style: Constants.heading5,
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
