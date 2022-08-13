import 'package:get/get.dart';
import 'package:meribiltyapp/Api%20Services/chat/chat_client.dart';
import 'package:meribiltyapp/Api%20Services/ppl/get_distance_and_time.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/screens/home/drawer_User.dart';

import 'package:meribiltyapp/screens/ppl/select_location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../Api Services/wallet/wallet_controller_getx.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    const _totalDots = 3;
    double _currentPosition = 0.0;
    GetWalletController _getWalletController = Get.put(GetWalletController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: storage.getItem("fullname") == null
              ? Text("Hi")
              : Text("Hi, ${storage.getItem('fullname')}"),
          centerTitle: false,
          backgroundColor: Constants.Primary,
          toolbarHeight: 80,
          elevation: 0,
          iconTheme: IconThemeData(color: Constants.White),
        ),
        drawer: Drawer(
          elevation: 5,
          child: SingleChildScrollView(
            child: Column(
              children: [CustomDrawerHeader(), CustomDrawerBody()],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    // AppLocalizations.of(context)!.top,
                    "Top Services",
                    style:
                        Constants.heading3.copyWith(color: Constants.Primary),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 13,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                          color: Color(0xFF2F4D84),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          )),
                      height: MediaQuery.of(context).size.height * 0.40,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SelectLocation()

                                //This is a demo
                                //SingleBilty(biltyNo: 'BT0013a0')
                                ),
                          );
                        },
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 2,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                height: 170,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image:
                                            AssetImage('assets/images/ppl.jpg'),
                                        fit: BoxFit.cover
                                        ),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0),
                                    )
                                    ),
                                child: const Text(""),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              // AppLocalizations.of(context)!.port,
                              "Project & Port Logistics",
                              textAlign: TextAlign.center,
                              style: Constants.heading3
                                  .copyWith(color: Constants.White),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              // AppLocalizations.of(context)!.cargo,
                              "Cargo movements and Shipments to all over Pakistan",
                              textAlign: TextAlign.center,
                              style: Constants.regular5
                                  .copyWith(color: Constants.White),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        // AppLocalizations.of(context)!.coming,
                        "Coming Soon",
                        style: Constants.heading3
                            .copyWith(color: Constants.Primary),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            height: 140,
                            width: 140,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: const Color(0xFF2F4D84), width: 3),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                )),
                            child: Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Image.asset(
                                    "assets/po.png",
                                    width: 70,
                                  ),
                                  Text(
                                    // AppLocalizations.of(context)!.ware,
                                    "Warehouse",
                                    style: Constants.heading5
                                        .copyWith(color: Constants.Primary),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // ee
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          // Container(
                          //   padding: const EdgeInsets.only(left: 10),
                          //   height: 140,
                          //   width: 140,
                          //   decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       border: Border.all(
                          //           color: const Color(0xFF2F4D84), width: 3),
                          //       borderRadius: const BorderRadius.only(
                          //         topRight: Radius.circular(20.0),
                          //         bottomLeft: Radius.circular(20.0),
                          //         bottomRight: Radius.circular(20.0),
                          //       )),
                          //   child: Center(
                          //     child: Column(
                          //       children: [
                          //         const SizedBox(
                          //           height: 10,
                          //         ),
                          //         Image.asset(
                          //           "assets/water.png",
                          //           width: 70,
                          //         ),
                          //         Text(
                          //           // AppLocalizations.of(context)!.water,
                          //           "Water Tanker",
                          //           style: Constants.heading4
                          //               .copyWith(color: Constants.Primary),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          // Container(
                          //   padding: const EdgeInsets.only(left: 10),
                          //   height: 140,
                          //   width: 140,
                          //   decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       border: Border.all(
                          //           color: const Color(0xFF2F4D84), width: 3),
                          //       borderRadius: const BorderRadius.only(
                          //         topRight: Radius.circular(20.0),
                          //         bottomLeft: Radius.circular(20.0),
                          //         bottomRight: Radius.circular(20.0),
                          //       )),
                          //   child: Center(
                          //     child: Column(
                          //       children: [
                          //         const SizedBox(
                          //           height: 10,
                          //         ),
                          //         Image.asset(
                          //           "assets/car.png",
                          //           width: 70,
                          //         ),
                          //         Text(
                          //           // AppLocalizations.of(context)!.car,
                          //           "Rent a car",
                          //           style: Constants.heading4
                          //               .copyWith(color: Constants.Primary),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          //
                          const SizedBox(
                            width: 10,
                          ),
                          //

                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            height: 140,
                            width: 140,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: const Color(0xFF2F4D84), width: 3),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                )),
                            child: Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Image.asset(
                                    "assets/sea.png",
                                    width: 50,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    // AppLocalizations.of(context)!.sea,
                                    "Sea Freight",
                                    style: Constants.heading5
                                        .copyWith(color: Constants.Primary),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),

                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            height: 140,
                            width: 140,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: const Color(0xFF2F4D84), width: 3),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                )),
                            child: Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Image.asset(
                                    "assets/air.png",
                                    width: 50,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    // AppLocalizations.of(context)!.air,
                                    "Air Freight",
                                    style: Constants.heading5
                                        .copyWith(color: Constants.Primary),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    CarouselSlider(
                      items: [
                        //1st Image of Slider
                        Container(
                          margin: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: const DecorationImage(
                              image: AssetImage("assets/pro.png"),
                            ),
                          ),
                        ),

                        //2nd Image of Slider
                        Container(
                          margin: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: const DecorationImage(
                              image: AssetImage("assets/transit.png"),
                            ),
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: const DecorationImage(
                              image: AssetImage('assets/Upcountry.png'),
                            ),
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                        height: 200,
                        enlargeCenterPage: false,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1800),
                        viewportFraction: 1,
                      ),
                    ),
                    DotsIndicator(
                      dotsCount: _totalDots,
                      position: _currentPosition,
                      decorator: const DotsDecorator(
                        activeColor: Color(0xFF2F4D84),
                        spacing: EdgeInsets.all(10.0),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        // AppLocalizations.of(context)!.need,
                        "Need Vehicle Spare parts?",
                        style: Constants.heading4
                            .copyWith(color: Constants.Primary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          launchURL(
                              "https://gurukart.pk/product-category/car-motorbike-care/");
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 200,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black12, width: 3),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              )),
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  "assets/acc1.png",
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  // AppLocalizations.of(context)!.access,
                                  "Accessories",
                                  style: Constants.heading5
                                      .copyWith(color: Constants.Primary),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          launchURL(
                              "https://gurukart.pk/product-category/tyres-wheels/");
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 200,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black12, width: 3),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              )),
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  "assets/acc2.png",
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  // AppLocalizations.of(context)!.tyres,
                                  "Tyres & Wheels",
                                  textAlign: TextAlign.center,
                                  style: Constants.heading5
                                      .copyWith(color: Constants.Primary),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          launchURL(
                              "https://gurukart.pk/product-category/drum-assembly-brakes/");
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 200,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black12, width: 3),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              )),
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  "assets/acc3.PNG",
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  // AppLocalizations.of(context)!.braker,
                                  "Braker & DrumAssembly",
                                  textAlign: TextAlign.center,
                                  style: Constants.heading5
                                      .copyWith(color: Constants.Primary),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          launchURL(
                              "https://gurukart.pk/product-category/oils-fluids/");
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 200,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black12, width: 3),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              )),
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  "assets/engine-oil.png",
                                  width: 80,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Automotive",
                                  style: Constants.heading5
                                      .copyWith(color: Constants.Primary),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          launchURL(
                              "https://gurukart.pk/product-category/replacement-parts/shock-suspension/");
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 200,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black12, width: 3),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              )),
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  "assets/sus.png",
                                  width: 80,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Suspension & Steering",
                                  textAlign: TextAlign.center,
                                  style: Constants.heading5
                                      .copyWith(color: Constants.Primary),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          launchURL(
                              "https://gurukart.pk/product-category/exterior/");
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 200,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black12, width: 3),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              )),
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  "assets/bodyparts.png",
                                  width: 80,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Body Parts",
                                  style: Constants.heading5
                                      .copyWith(color: Constants.Primary),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          launchURL(
                              "https://gurukart.pk/product-category/engine/");
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 200,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black12, width: 3),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              )),
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  "assets/engine.png",
                                  width: 80,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Engine",
                                  style: Constants.heading5
                                      .copyWith(color: Constants.Primary),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          launchURL("https://gurukart.pk/");
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 200,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black12, width: 3),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              )),
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  "assets/more.png",
                                  width: 80,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "More ",
                                  style: Constants.heading5
                                      .copyWith(color: Constants.Primary),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(7),
                    width: double.infinity,
                    child: Container(
                      width: double.infinity,
                      height: 70,
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        child: Center(
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 40,
                              ),
                              Image.asset('assets/add.png'),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                  // AppLocalizations.of(context)!.neehelp,
                                  "Need help? click here",
                                  style: Constants.heading5
                                      .copyWith(color: Constants.Primary)),
                            ],
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffEAEAFF)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18)),
                                  side: BorderSide(color: Colors.white)),
                            )),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.0),
                                      topRight: Radius.circular(12.0))),
                              builder: (BuildContext context) {
                                return Container(
                                  height: 280,
                                  //color: Constants.Primary,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Contact Us:",
                                          style: Constants.heading2.copyWith(
                                              color: Constants.Primary),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Card(
                                          color: Constants.Primary,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0)),
                                          child: ListTile(
                                            onTap: () {
                                              launchURL(
                                                  "https://api.whatsapp.com/send?phone=923000728557");
                                            },
                                            leading: Icon(
                                              Icons.whatsapp_rounded,
                                              color: Colors.white,
                                            ),
                                            title: Text(
                                              "Whatsapp",
                                              style: Constants.regular2
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Card(
                                          color: Constants.Primary,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0)),
                                          child: ListTile(
                                            onTap: () {
                                              launchURL(emailLaunchUri);
                                            },
                                            leading: Icon(
                                              Icons.mark_email_unread_outlined,
                                              color: Colors.white,
                                            ),
                                            title: Text(
                                              "Email",
                                              style: Constants.regular2
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Card(
                                          color: Constants.Primary,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0)),
                                          child: ListTile(
                                            onTap: () {
                                              makePhoneCall("+923000728557");
                                            },
                                            leading: Icon(
                                              Icons.phone_android_rounded,
                                              color: Colors.white,
                                            ),
                                            title: Text(
                                              "Call",
                                              style: Constants.regular2
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                          //_launchURL();
                        },
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

launchURL(link) async {
  final url = '$link';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

final Uri emailLaunchUri = Uri(
  scheme: 'mailto',
  path: 'info@meribility.com',
  query: encodeQueryParameters(<String, String>{'subject': ''}),
);

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchURL(launchUri);
}
