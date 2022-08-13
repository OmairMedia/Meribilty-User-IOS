import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:meribiltyapp/Api%20Services/chat/chatServiceWithGetx.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/singleBiltyServicesTransit.dart';
import 'package:meribiltyapp/Api%20Services/invite/My%20Team/myTeamServide.dart';
import 'package:meribiltyapp/Api%20Services/registration%20Apis/logout.dart';
import 'package:meribiltyapp/Api%20Services/wallet/wallet_controller_getx.dart';
import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/screens/authentication/signin.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/drawer_pages/chat.dart';
import 'package:meribiltyapp/screens/drawer_pages/invitepage.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_notifications.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_offers.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_profile.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_team.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_wallet.dart';
import 'package:meribiltyapp/screens/drawer_pages/rating_user.dart';
import 'package:meribiltyapp/screens/drawer_pages/settings.dart';
import 'package:meribiltyapp/screens/home/home.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_deliveries.dart';
import 'package:meribiltyapp/screens/home/home_header.dart';
import 'package:meribiltyapp/screens/ppl/bussiness_pro_form.dart';
import 'package:meribiltyapp/screens/ppl/select_location.dart';
import 'package:meribiltyapp/screens/ppl/single_bilty.dart';
import 'package:meribiltyapp/screens/ppl/single_bilty_transitfile.dart';
// import 'package:meribiltyapp/screens/ppl/single_bilty_upcountry.dart';
import 'package:http/http.dart' as http;

import '../drawer_pages/inviteFriends.dart';

class WalletData {
  var walletAmount = '...';
  var type = '...';
}

class CustomDrawerHeader extends StatefulWidget {
  CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  State<CustomDrawerHeader> createState() => _CustomDrawerHeaderState();
}

class _CustomDrawerHeaderState extends State<CustomDrawerHeader> {
  WalletData _wd = WalletData();
  fetchwallet() async {
    var headers = {'Content-Type': 'application/json'};

    Uri apiurl = Uri.parse('https://staging-api.meribilty.com/api/get_wallet');
    var response = await http.Client().post(apiurl,
        headers: headers, body: json.encode({"token": box.read('token')}));
    var responseMap = await json.decode(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print("Successfully fetched wallet");
      setState(() {
        _wd.walletAmount = responseMap['data']['amount'].toString();
        _wd.type = responseMap['data']['type'];
      });
    } else {
      print(response.body);
      print("There is an error");
      throw Exception('Failed to load wallet');
    }
  }

  ChatServiceWithGetx _chatService = Get.put(ChatServiceWithGetx());

  @override
  void initState() {
    fetchwallet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.Primary,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //AvatarImage(imageurl: "assets/images/Avatar.png"),
            Text(
              storage.getItem('fullname') == null
                  ? ''
                  : "${storage.getItem('fullname')}",
              style: Constants.heading3.copyWith(color: Constants.White),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                  decoration: BoxDecoration(
                      color: Constants.White,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Text(
                        "${_wd.type} ",
                        style: Constants.regular1.copyWith(fontSize: 16),
                      ),
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text("${_wd.walletAmount}  PKR",
                              style: Constants.heading3),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MyWallet()));
                        },
                      ),
                      Icon(FontAwesomeIcons.chevronRight, size: 12),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // InkWell(
                  //   child: Icon(
                  //     FontAwesomeIcons.bell,
                  //     color: Constants.White,
                  //   ),
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (BuildContext context) =>
                  //                 MyNotifications()));
                  //   },
                  // ),
                  // SizedBox(
                  //   width: 20,
                  // ),
                  // InkWell(
                  //   child: Icon(
                  //     FontAwesomeIcons.comment,
                  //     color: Constants.White,
                  //   ),
                  //   onTap: () {
                  //      _chatService.fetchChat();
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (BuildContext context) => Chat()));
                  //  },
                  //),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

class AvatarImage extends StatefulWidget {
  String imageurl;
  AvatarImage({Key? key, required this.imageurl}) : super(key: key);

  @override
  State<AvatarImage> createState() => _AvatarImageState();
}

class _AvatarImageState extends State<AvatarImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage(widget.imageurl),
                fit: BoxFit.contain,
                scale: 1.0),
          ),
        ),
      ),
    );
  }
}

class CustomDrawerBody extends StatelessWidget {
  CustomDrawerBody({Key? key}) : super(key: key);
  bool walletDataLoaded = false;
  final GetWalletController _getWalletController =
      Get.put(GetWalletController());
  final MyTeamService _myTeamService = Get.put(MyTeamService());
  ChatServiceWithGetx _chatService = Get.put(ChatServiceWithGetx());
  GetWalletController getWalletController() => _getWalletController;
  bool chatLoaded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            ListTileforDrawer(
              image_url: "assets/drawer_icons/home.png",
              icon: FontAwesomeIcons.home,
              txt: "Home",
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => Home()),
                    (route) => false);
              },
            ),

            ListTileforDrawer(
              image_url: "assets/drawer_icons/Create Request.png",
              icon: FontAwesomeIcons.truck,
              txt: "Create Request",
              onTap: () {
                _myTeamService.fetchMyTeamService();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectLocation()));
              },
            ),

            ListTileforDrawer(
              image_url: "assets/drawer_icons/my delivery.png",
              icon: FontAwesomeIcons.truck,
              txt: "My Deliveries",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyDeliveries()));
              },
            ),

            ListTileforDrawer(
              image_url: "assets/drawer_icons/My Request.png",
              icon: FontAwesomeIcons.truck,
              txt: "My Requests",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyOffers()));
              },
            ),

            ListTileforDrawer(
              image_url: "assets/drawer_icons/My Wallet.png",
              icon: FontAwesomeIcons.wallet,
              txt: "My Wallet",
              onTap: () {
                _getWalletController.fetchWallet();
                walletDataLoaded = true;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyWallet()));
              },
            ),

            ListTileforDrawer(
              image_url: "assets/drawer_icons/My Team.png",
              icon: Icons.groups_outlined,
              txt: "My Team",
              onTap: () {
                _myTeamService.fetchMyTeamService();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyTeam()));
              },
            ),

            

            ListTileforDrawer(
              image_url: "assets/drawer_icons/Chat 2.png",
              icon: FontAwesomeIcons.comment,
              txt: "Chat",
              onTap: () {
                _chatService.fetchChat();
                //  : null;
                chatLoaded = true;
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Chat()));
              },
            ),
             ListTileforDrawerWithIcon(txt: "Notifications",onTap:(){
               Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyNotifications()));
            } ,),
            // ListTileforDrawer(
            //   icon: FontAwesomeIcons.bell,
            //   txt: "Notification",
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const MyNotifications()));
            //   },
            // ),
            ListTileforDrawer(
              image_url: "assets/drawer_icons/Invite Friends.png",
              icon: FontAwesomeIcons.gift,
              txt: "Invite Friends",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InviteFriends()));
              },
            ),
            ListTileforDrawer(
              image_url: "assets/drawer_icons/My Profile.png",
              icon: FontAwesomeIcons.user,
              txt: "My Profile",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyProfile()));
              },
            ),
            ListTileforDrawer(
              image_url: "assets/drawer_icons/Setting 1.png",
              icon: FontAwesomeIcons.cog,
              txt: "Setting",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Settings()));
              },
            ),
            ListTileforDrawer(
              image_url: "assets/drawer_icons/Logout.png",
              icon: FontAwesomeIcons.signOutAlt,
              txt: "Log Out",
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: Text(
                            'Logout',
                            style: Constants.heading2,
                          ),
                          content: Text(
                            'Are you sure you want to logout ?',
                            style: Constants.regular3,
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.red),
                                )),
                            TextButton(
                                onPressed: () {
                                  // box.erase();
                                  logoutApi("users", storage.getItem('phone'));
                                  box.remove("apiToken");
                                  box.remove("userType");
                                  box.remove("remember");
                                  storage.clear();
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignIn()),
                                      (Route<dynamic> route) => false);
                                },
                                child: const Text(
                                  'OK',
                                  style: TextStyle(color: Colors.green),
                                ))
                          ],
                        ));
              },
            ),
            storage.getItem("userType") == "pro" ? Container() :	
            ListTileforDrawer(
              image_url: "assets/drawer_icons/Upgrade to PRO.png",
              icon: FontAwesomeIcons.upload,
              txt: "Upgrade To Pro",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProBussinessForm()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListTileforDrawer extends StatelessWidget {
  String image_url;
  String txt;
  IconData icon;
  Function onTap;
  ListTileforDrawer(
      {Key? key,
      required this.icon,
      required this.txt,
      required this.onTap,
      required this.image_url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Row(
          children: [
            Image.asset("${image_url}"),
            //Icon(icon, color: Constants.Grey,size: 24,),
            SizedBox(
              width: 15,
            ),
            Text(txt,
                style: Constants.regular3.copyWith(color: Constants.Black))
          ],
        ),
      ),
    );
  }
}

class ListTileforDrawerWithIcon extends StatelessWidget {
  String txt;
  // IconData icon;
  Function onTap;
  ListTileforDrawerWithIcon(
      {Key? key, required this.txt, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
   return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Row(
          children: [
            Icon(Icons.notifications_none, size: 26,),
            //Icon(icon, color: Constants.Grey,size: 24,),
            SizedBox(
              width: 15,
            ),
            Text(txt,
                style: Constants.regular3.copyWith(color: Constants.Black))
          ],
        ),
      ),
    );
  }
}
