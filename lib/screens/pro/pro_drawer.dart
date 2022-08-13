// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:meribiltyapp/Api%20Services/deliveries/singleBiltyServicesTransit.dart';
// import 'package:meribiltyapp/Api%20Services/invite/My%20Team/myTeamServide.dart';
// import 'package:meribiltyapp/Api%20Services/wallet/wallet_controller_getx.dart';
// import 'package:meribiltyapp/constants/main_constants.dart';
// import 'package:meribiltyapp/screens/authentication/signin.dart';
// import 'package:meribiltyapp/config/constants.dart';
// import 'package:meribiltyapp/screens/drawer_pages/chat.dart';
// import 'package:meribiltyapp/screens/drawer_pages/invitepage.dart';
// import 'package:meribiltyapp/screens/drawer_pages/my_notifications.dart';
// import 'package:meribiltyapp/screens/drawer_pages/my_offers.dart';
// import 'package:meribiltyapp/screens/drawer_pages/my_profile.dart';
// import 'package:meribiltyapp/screens/drawer_pages/my_team.dart';
// import 'package:meribiltyapp/screens/drawer_pages/my_wallet.dart';
// import 'package:meribiltyapp/screens/drawer_pages/rating_user.dart';
// import 'package:meribiltyapp/screens/drawer_pages/settings.dart';
// import 'package:meribiltyapp/screens/home/home.dart';
// import 'package:meribiltyapp/screens/drawer_pages/my_deliveries.dart';
// import 'package:meribiltyapp/screens/ppl/bussiness_pro_form.dart';
// import 'package:meribiltyapp/screens/ppl/single_bilty.dart';
// import 'package:meribiltyapp/screens/ppl/single_bilty_transitfile.dart';
// // import 'package:meribiltyapp/screens/ppl/single_bilty_upcountry.dart';

// import '../drawer_pages/inviteFriends.dart';
// import '../ppl/select_location.dart';

// class ProCustomDrawerHeader extends StatefulWidget {
//   ProCustomDrawerHeader({Key? key}) : super(key: key);

//   @override
//   State<ProCustomDrawerHeader> createState() => _ProCustomDrawerHeaderState();
// }

// class _ProCustomDrawerHeaderState extends State<ProCustomDrawerHeader> {
//   GetWalletController _getWalletController = Get.put(GetWalletController());

//   @override
//   void initState() {
//     super.initState();
//     _getWalletController.fetchWallet();
//     WidgetsFlutterBinding.ensureInitialized();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.red,
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height / 4,
//       child: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             //AvatarImage(imageurl: "assets/images/Avatar.png"),
//              box.read("fullname") == null
//               ? Text("Hi, ${storage.getItem('fullname')}") 
//               : Text("Hi, ${box.read('fullname')}"),
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
//                         "${_getWalletController.wallletData[0].data!.type!.capitalize}",
//                         style: Constants.regular1.copyWith(fontSize: 16),
//                       ),
//                       InkWell(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 5),
//                           child: Text(
//                               "${_getWalletController.wallletData[0].data!.amount} PKR",
//                               style: Constants.heading3
//                                   .copyWith(color: Colors.amber)),
//                         ),
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (BuildContext context) =>
//                                       MyWallet()));
//                         },
//                       ),
//                       // Icon(FontAwesomeIcons.chevronRight, size: 12),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     InkWell(
//                       child: Icon(
//                         FontAwesomeIcons.bell,
//                         color: Constants.White,
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (BuildContext context) =>
//                                     MyNotifications()));
//                       },
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     InkWell(
//                       child: Icon(
//                         FontAwesomeIcons.comment,
//                         color: Constants.White,
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (BuildContext context) => Chat()));
//                       },
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

// class AvatarImage extends StatefulWidget {
//   String imageurl;
//   AvatarImage({Key? key, required this.imageurl}) : super(key: key);

//   @override
//   State<AvatarImage> createState() => _AvatarImageState();
// }

// class _AvatarImageState extends State<AvatarImage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 120,
//       height: 120,
//       padding: const EdgeInsets.all(8),
//       child: Container(
//         padding: const EdgeInsets.all(3),
//         child: Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             image: DecorationImage(
//                 image: AssetImage(widget.imageurl),
//                 fit: BoxFit.contain,
//                 scale: 1.0),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ProCustomDrawerBody extends StatelessWidget {
//   ProCustomDrawerBody({Key? key}) : super(key: key);
//   bool walletDataLoaded = false;
//   final GetWalletController _getWalletController =
//       Get.put(GetWalletController());
//   final MyTeamService _myTeamService = Get.put(MyTeamService());
//   GetWalletController getWalletController() => _getWalletController;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0),
//         child: Column(
//           children: [
//             ListTileforDrawer(
//               icon: FontAwesomeIcons.home,
//               txt: "Home",
//               onTap: () {
//                 Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (_) => Home()),
//                     (route) => false);
//               },
//             ),

//             ListTileforDrawer(
//               icon: FontAwesomeIcons.truck,
//               txt: "My Deliveries",
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const MyDeliveries()));
//               },
//             ),
//             ListTileforDrawer(
//               icon: FontAwesomeIcons.truck,
//               txt: "My Requests",
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const MyOffers()));
//               },
//             ),
//             ListTileforDrawer(
//               icon: FontAwesomeIcons.wallet,
//               txt: "My Wallet",
//               onTap: () {
//                 _getWalletController.fetchWallet();
//                 walletDataLoaded = true;
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const MyWallet()));
//               },
//             ),
//             ListTileforDrawer(
//               icon: Icons.groups_outlined,
//               txt: "My Team",
//               onTap: () {
//                 _myTeamService.fetchMyTeamService();
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const MyTeam()));
//               },
//             ),
//             ListTileforDrawer(
//               icon: FontAwesomeIcons.truck,
//               txt: "Create Request",
//               onTap: () {
//                 _myTeamService.fetchMyTeamService();
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const SelectLocation()));
//               },
//             ),
//             ListTileforDrawer(
//               icon: FontAwesomeIcons.comment,
//               txt: "Chat",
//               onTap: () {
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (context) => Chat()));
//               },
//             ),
//             // ListTileforDrawer(
//             //   icon: FontAwesomeIcons.bell,
//             //   txt: "Notification",
//             //   onTap: () {
//             //     Navigator.push(
//             //         context,
//             //         MaterialPageRoute(
//             //             builder: (context) => const MyNotifications()));
//             //   },
//             // ),
//             ListTileforDrawer(
//               icon: FontAwesomeIcons.gift,
//               txt: "Invite Friends",
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => InviteFriends()));
//               },
//             ),
//             ListTileforDrawer(
//               icon: FontAwesomeIcons.user,
//               txt: "My Profile",
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => MyProfile()));
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
//               onTap: () async {
//                 showDialog(
//                     context: context,
//                     builder: (BuildContext context) => AlertDialog(
//                           title: Text(
//                             'Logout',
//                             style: Constants.heading2,
//                           ),
//                           content: Text(
//                             'Are you sure you want to logout ?',
//                             style: Constants.regular3,
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
//                                   // box.erase();
//                                   box.remove("apiToken");
//                                   box.remove("userType");
//                                   box.remove("remember");
//                                   storage.clear();
//                                   FirebaseAuth.instance.signOut();
//                                   Navigator.pushAndRemoveUntil(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => SignIn()),
//                                       (Route<dynamic> route) => false);
//                                 },
//                                 child: const Text(
//                                   'OK',
//                                   style: TextStyle(color: Colors.green),
//                                 ))
//                           ],
//                         ));
//               },
//             ),
//             // ListTileforDrawer(
//             //   icon: FontAwesomeIcons.upload,
//             //   txt: "Rating",
//             //   onTap: () {
//             //     Navigator.push(context,
//             //         MaterialPageRoute(builder: (context) => ratings_user()));
//             //   },
//             // ),
//             // ListTileforDrawer(
//             //   icon: FontAwesomeIcons.upload,
//             //   txt: "Upgrade To Pro",
//             //   onTap: () {
//             //     Navigator.push(
//             //         context,
//             //         MaterialPageRoute(
//             //             builder: (context) => const ProBussinessForm()));
//             //   },
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ListTileforDrawer extends StatelessWidget {
//   String txt;
//   IconData icon;
//   Function onTap;
//   ListTileforDrawer(
//       {Key? key, required this.icon, required this.txt, required this.onTap})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onTap();
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Row(
//           children: [
//             Icon(icon, color: Constants.Grey),
//             SizedBox(
//               width: 15,
//             ),
//             Text(txt,
//                 style: Constants.regular4.copyWith(color: Constants.Black))
//           ],
//         ),
//       ),
//     );
//   }
// }
