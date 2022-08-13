import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_offers.dart';
import 'package:meribiltyapp/widgets/timer_widget.dart';
import 'package:meribiltyapp/widgets/upcountry/activeorder.dart';
import 'package:meribiltyapp/widgets/upcountry/offerrecieved.dart';
import 'package:meribiltyapp/widgets/upcountry/partnerofferreceived.dart';
import 'package:meribiltyapp/widgets/upcountry/ratesnotfound.dart';

class QoutesNCountersCard extends StatefulWidget {
  final data;

  QoutesNCountersCard({Key? key, required this.data}) : super(key: key);

  @override
  _QoutesNCountersCardState createState() => _QoutesNCountersCardState();
}

class _QoutesNCountersCardState extends State<QoutesNCountersCard> {
  CountdownTimerController? controller;

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.White,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Constants.Black, width: 1),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              log(widget.data.toString());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: Constants.White,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order No. {(widget.data ?? const {})['orderNo']}",
                      style: Constants.regular4,
                    ),
                    Text(
                      "(widget.data ?? const {})['date']",
                      style: Constants.regular4,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Constants.Primary,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 20),
                            child: Text(
                              "Upcountry",
                              style: Constants.regular3
                                  .copyWith(color: Constants.White),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: (widget.data ?? const {})['subOrders']?.length,
              itemBuilder: (BuildContext context, int i) {
                return Column(
                  children: [
                   
                    widget.data['subOrders'][i]["counter"] != null
                        ? Column(
                            children: [
                               ElevatedButton(
                        onPressed: () {
                          print(widget.data['subOrders'][i]["counter"].toString()
                              );
                          print(int.parse(widget.data['subOrders'][i]["counter"][0])*60);
                          //     print(widget.data['subOrders'][i]["counter"].substring(0,widget.data['subOrders'][i]["counter"].indexOf(':')));
                              print(widget.data['subOrders'][i]["counter"].substring(widget.data['subOrders'][i]["counter"].length-2));
                        },
                        child: Text("TEST")),
                        
                        //Foo(seconds: 120),

                              // CountdownTimer(
                              //   controller: controller,
                              //   endTime: DateTime.now().millisecondsSinceEpoch + 
                              //       1000 *2*20,
                              //   onEnd: () {
                              //     (context as Element).reassemble();
                              //   },
                              //   textStyle: Constants.heading1
                              //       .copyWith(color: Constants.Primary),
                              //   endWidget: Center(
                              //       child: Text(
                              //     "You will get a quote on your request shortly",
                              //     style: const TextStyle(
                              //         fontSize: 15,
                              //         color: Color(0xFF2F4D84),
                              //         fontWeight: FontWeight.bold),
                              //   )),
                              // ),
                             
                              Text(
                                "Time Left for finding quote",
                                style: Constants.heading3,
                              ),
                              // ElevatedButton(
                              //     onPressed: () {
                              //       print(widget.data['subOrders'][i]["counter"]
                              //           .substring(
                              //               0,
                              //               widget.data['subOrders'][i]
                              //                       ["counter"]
                              //                   .indexOf(':')));
                              //     },
                              //     child: Text("HEgeg"))
                            ],
                          )
                        : Text(" "),
                    ((widget.data ?? const {})['subOrders'][i]['qoute']
                                    ?['nature'] ==
                                'Qoute' &&
                            (widget.data ?? const {})['subOrders'][i]['qoute']
                                    ?['status'] !=
                                'rejected')
                        ? UpcountryOfferRecieved(
                            status: ((widget.data ?? const {})['subOrders'][i]
                                        ['qoute']?['status'] ==
                                    'accepted')
                                ? 'Offer Accepted'
                                : 'Offer Recieved',
                            colored: ((widget.data ?? const {})['subOrders'][i]
                                        ['qoute']?['status'] ==
                                    'accepted')
                                ? Colors.green
                                : Colors.blue,
                            data: (widget.data ?? const {})['subOrders'][i],
                            order: widget.data,
                          )
                        : Padding(padding: EdgeInsets.only(top: 0)),
                    (!((widget.data ?? const {})['subOrders'][i]
                            ['rates_found']))
                        ? RatesNotFoundCard(
                            status: 'Rates Not Found',
                            colored: Colors.pink,
                            data: (widget.data ?? const {})['subOrders'][i],
                          )
                        : Padding(padding: EdgeInsets.only(top: 0)),
                    ((widget.data ?? const {})['subOrders'][i]['qoute']
                                ?['status'] ==
                            'rejected')
                        ? UpcountryActiveOrderCard(
                            status: ((widget.data ?? const {})['subOrders'][i]
                                        ['qoute']?['nature'] ==
                                    'User Counter Offer')
                                ? 'Counter Offer Rejected'
                                : ((widget.data ?? const {})['subOrders'][i]
                                            ['qoute']?['nature'] ==
                                        'Vendor Counter Offer')
                                    ? 'Partner Counter Offer Rejected'
                                    : 'Offer Rejected',
                            colored: Colors.red,
                            data: (widget.data ?? const {})['subOrders'][i],
                          )
                        : Padding(padding: EdgeInsets.only(top: 0)),
                    ((widget.data ?? const {})['subOrders'][i]['qoute']
                                    ?['nature'] ==
                                'User Counter Offer' &&
                            (widget.data ?? const {})['subOrders'][i]['qoute']
                                    ?['status'] !=
                                'rejected')
                        ? UpcountryActiveOrderCard(
                            status: ((widget.data ?? const {})['subOrders'][i]
                                        ['qoute']?['status'] ==
                                    'accepted')
                                ? 'Counter Offer Accepted'
                                : 'Counter Offer Sent',
                            colored: ((widget.data ?? const {})['subOrders'][i]
                                        ['qoute']?['status'] ==
                                    'accepted')
                                ? Colors.green
                                : Colors.purple,
                            data: (widget.data ?? const {})['subOrders'][i],
                          )
                        : Padding(padding: EdgeInsets.only(top: 0)),
                    ((widget.data ?? const {})['subOrders'][i]['qoute']
                                    ?['nature'] ==
                                'Vendor Counter Offer' &&
                            (widget.data ?? const {})['subOrders'][i]['qoute']
                                    ?['status'] !=
                                'rejected')
                        ? UpcountryPartnerCounterRecieved(
                            status: ((widget.data ?? const {})['subOrders'][i]
                                        ['qoute']?['status'] ==
                                    'accepted')
                                ? 'Partner Counter Offer Accepted'
                                : 'Partner Counter Offer Recieved',
                            colored: ((widget.data ?? const {})['subOrders'][i]
                                        ['qoute']?['status'] ==
                                    'accepted')
                                ? Colors.green
                                : Colors.purple,
                            data: (widget.data ?? const {})['subOrders'][i],
                            order: widget.data,
                          )
                        : Padding(padding: EdgeInsets.only(top: 0)),
                  ],
                );
              })
        ],
      ),
    );
  }
}
