// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:meribiltyapp/Api%20Services/wallet/get_wallet_info.dart';
//import 'package:meribiltyapp/Api%20Services/wallet/get_wallet_info.dart';
import 'package:meribiltyapp/Api%20Services/wallet/wallet_controller_getx.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:meribiltyapp/widgets/location.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  GetWalletController _getWalletController = Get.put(GetWalletController());
  Map walletDataMap = {};
  @override
  void initState() {
    super.initState();
    setState(() {
      walletDataMap = json.decode(_getWalletController.wallletData[0]);
    });
    // _getWalletController.fetchWallet();
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          title: Text(
            "My Wallet",
            style: Constants.regular4.copyWith(color: Constants.White),
          ),
          backgroundColor: Constants.Primary,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(FontAwesomeIcons.chevronLeft),
          ),
        ),
        body: FutureBuilder(
          future: fetchwalletData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 5.0,
                            sigmaY: 5.0,
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.height * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Constants.Primary.withOpacity(0.95),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "PKR wallet",
                                          style: Constants.heading4
                                              .copyWith(color: Constants.White),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Rs  ${snapshot.data!['data']['amount']}",
                                          style: Constants.heading4
                                              .copyWith(color: Constants.White),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Default Payment Method",
                                          style: Constants.regular5
                                              .copyWith(color: Constants.Grey),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${snapshot.data!['data']['type']}",
                                          style: Constants.heading4
                                              .copyWith(color: Constants.White),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //     margin: EdgeInsets.symmetric(
                      //         horizontal: 10, vertical: 10),
                      //     alignment: Alignment.center,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       color: Constants.White,
                      //     ),
                      //     width: MediaQuery.of(context).size.width,
                      //     // height: 300,
                      //     child: ListTile(
                      //       // leading: Icon(
                      //       //   FontAwesomeIcons.dollarSign,
                      //       //   size: 30,
                      //       //   color: Constants.Primary,
                      //       // ),
                      //       title: Text("${snapshot.data!['data']['type']}",
                      //           style: Constants.heading3
                      //               .copyWith(color: Constants.Black)),
                      //       subtitle: Text("Default Payment Method",
                      //           style: Constants.regular5
                      //               .copyWith(color: Constants.Grey)),
                      //     )),
                      // Container(
                      //     padding: EdgeInsets.symmetric(vertical: 20),
                      //     margin: EdgeInsets.symmetric(
                      //         horizontal: 10, vertical: 10),
                      //     alignment: Alignment.center,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       color: Constants.White,
                      //     ),
                      //     width: MediaQuery.of(context).size.width,
                      //     // height: 300,
                      //     child: ListTile(
                      //       title: Text("Balance",
                      //           style: Constants.regular3
                      //               .copyWith(color: Constants.Black)),
                      //       subtitle: Text(
                      //           "${snapshot.data!['data']['amount']} PKR",
                      //           style: Constants.bigger1
                      //               .copyWith(color: Constants.Grey)),
                      //     )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "Transactions",
                          style: Constants.heading2,
                        ),
                      ),
                      snapshot.data!['data']['transactions'] == null ? Container(
                        child: Center(
                          child: Text("No Transactions Yet",style: Constants.heading3.copyWith(color: Constants.Black),),
                        ),
                      ) :  
                      ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          // itemCount: 2,
                          itemCount: snapshot.data!['data']['transactions'] ==
                                  null
                              ? 0
                              : snapshot.data!['data']['transactions'].length,
                          itemBuilder: (BuildContext context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data!['data']['transactions'][index]['request_type'].toString().toLowerCase() == "upcountry"? "Nationwide":
                                          '${snapshot.data!['data']['transactions'][index]['request_type'].toString().capitalize}',
                                          style: Constants.heading4,
                                        ),
                                        Text(
                                          'OrderNo# ${snapshot.data!['data']['transactions'][index]['orderNo']}',
                                          style: Constants.regular4.copyWith(
                                              color: Constants.Primary),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${snapshot.data!['data']['transactions'][index]['time']}',
                                          style: Constants.regular5.copyWith(
                                              color: Constants.Primary),
                                        ),
                                        Text(
                                            '-${snapshot.data!['data']['transactions'][index]['deductedAmount']} PKR',
                                            style: Constants.regular5.copyWith(
                                                color: Constants.BrightRed)),
                                      ],
                                    ),
                                    Custom3LocationWigetsWallet(
                                      pickup:
                                          '${snapshot.data!['data']['transactions'][index]['originAddress']}',
                                      dropoff:
                                          '${snapshot.data!['data']['transactions'][index]['destinationAddress']}',
                                      empty:
                                          '${snapshot.data!['data']['transactions'][index]['containerReturnAddress']}',
                                    )
                                  ],
                                ),
                              ),
                              // child: ListTile(
                              //   title: Padding(
                              //     padding: const EdgeInsets.only(top: 10.0),
                              //     child: Text("Saturday, 8:45 PM",style: Constants.regular3.copyWith(color:Constants.White)),
                              //   ),
                              //   trailing:  Text("PKR 345,000",style: Constants.regular3.copyWith(color:Constants.White),),
                              //   subtitle: Column(children: [
                              //     Padding(
                              //       padding: const EdgeInsets.symmetric(vertical:3.0),
                              //       child: Custom3LocationWigetsWallet(
                              //           pickup: 'destination Address',
                              //           dropoff: ('destination Address'),
                              //           empty: ('container Return Address'),),
                              //     ),
                              //   ],),
                              //     ),

                              // title: Column(
                              //   mainAxisSize: MainAxisSize.min,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     // const SizedBox(
                              //     //   height: 5,
                              //     // ),
                              //     // Text(
                              //     //   "Accepted Amount: ${_getWalletController.wallletData[0].data!.transactions![index].acceptedAmount}",
                              //     //   style: Constants.regular2.copyWith(
                              //     //       color: Colors.white, fontSize: 15),
                              //     // ),
                              //     // const SizedBox(
                              //     //   height: 5,
                              //     // ),
                              //     // Text(
                              //     //   "After Deduction: ${_getWalletController.wallletData[0].data!.transactions![index].afterDeduction}",
                              //     //   style: Constants.regular2.copyWith(
                              //     //     color: Colors.white,
                              //     //     fontSize: 15,
                              //     //   ),
                              //     // ),
                              //     // const SizedBox(
                              //     //   height: 5,
                              //     // ),
                              //     // Text(
                              //     //   "Deducted Amount: ${_getWalletController.wallletData[0].data!.transactions![index].deductedAmount}",
                              //     //   style: Constants.regular2.copyWith(
                              //     //       color: Colors.white, fontSize: 15),
                              //     // ),
                              //     // const SizedBox(
                              //     //   height: 5,
                              //     // ),
                              //   ],
                              // ),

                              // subtitle: Text(
                              //   '22-02-2022',
                              //   style: Constants.regular1
                              //       .copyWith(color: Constants.White),
                              // ),

                              // trailing: Container(
                              //   width: MediaQuery.of(context).size.width * 0.35,
                              //   child: Text(
                              //     '${_getWalletController.wallletData[0].data!.transactions![index].time}',
                              //     style: TextStyle(color: Colors.green[500]),
                              //   ),
                              // ),
                            );
                          })
                    ],
                  )

                  // Container(
                  //     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: Constants.White,
                  //     ),
                  //     width: MediaQuery.of(context).size.width,
                  //     // height: 300,
                  //     child: ListTile(
                  //       title: Text("My Payment Methods",
                  //           style:
                  //               Constants.regular3.copyWith(color: Constants.Black)),
                  //       trailing: IconButton(
                  //           onPressed: () => {},
                  //           icon: Icon(FontAwesomeIcons.chevronCircleRight,
                  //               color: Constants.Primary, size: 20)),
                  //     ))
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
