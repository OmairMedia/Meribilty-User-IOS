import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meribiltyapp/Api%20Services/ppl/acceptOrder.dart';
//import 'package:meribiltyapp/Api%20Services/ppl/acceptOrder.dart';
import 'package:meribiltyapp/Api%20Services/ppl/transit/accept_qoute.dart';
import 'package:meribiltyapp/Api%20Services/ppl/transit/counter_qoute.dart';
import 'package:meribiltyapp/Api%20Services/ppl/reject_order.dart';
import 'package:meribiltyapp/Api%20Services/ppl/transit/reject_qoute.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_offers.dart';
import 'package:meribiltyapp/screens/ppl/finding_best_qoute.dart';
//import 'package:meribiltyapp/screens/ppl/single_bilty.dart';
import 'package:meribiltyapp/screens/ppl/single_bilty_Upcountry.dart';
import 'package:meribiltyapp/screens/ppl/single_bilty_transitfile.dart';
import 'package:meribiltyapp/widgets/location.dart';
import 'package:meribiltyapp/widgets/transit/subordercard.dart';

import 'package:meribiltyapp/widgets/upload_documents_transit.dart';
import 'package:meribiltyapp/widgets/upload_documents_upcountry.dart';

import '../btns_all.dart';

class OfferRecievedCard extends StatefulWidget {
  final status;
  final colored;
  final data;

  OfferRecievedCard({
    Key? key,
    required this.status,
    required this.colored,
    required this.data,
  }) : super(key: key);

  @override
  _OfferRecievedCardState createState() => _OfferRecievedCardState();
}

class _OfferRecievedCardState extends State<OfferRecievedCard> {
  _OfferRecievedCardState();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.White,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: widget.colored, width: 1),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: widget.colored,
            ),
            child: Center(
              child: Text(
                "${widget.status}",
                style: Constants.regular4.copyWith(color: Constants.White),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order#${(widget.data ?? const {})['orderNo']}",
                      style: Constants.regular4,
                    ),
                    Text(
                      "${DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse((widget.data ?? const {})['date']))}",
                      style: Constants.regular4,
                    )
                  ],
                ),
                ListView.builder(
                    itemCount: (widget.data ?? const {})['bilties'].length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int i) {
                      if ((widget.data ?? const {})['bilties'][i]['type'] ==
                          "vehicle") {
                        return (Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ContainerDetailblue(
                            vehicleType:
                                "${(widget.data ?? const {})['bilties'][i]['name']}",
                            quantity:
                                "${(widget.data ?? const {})['bilties'][i]['quantity']}",
                            weight:
                                "${(widget.data ?? const {})['bilties'][i]['weight']} Tons",
                            material:
                                "${(widget.data ?? const {})['bilties'][i]['material']}",
                            image:
                                "${(widget.data ?? const {})['bilties'][i]['image']}",
                          ),
                        ));
                      } else if ((widget.data ?? const {})['bilties'][i]
                              ['type'] ==
                          "loading/unloading") {
                        return (Container(
                          decoration: BoxDecoration(
                              color: Constants.Primary,
                              borderRadius: BorderRadius.circular(12)),
                          child: (Column(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount:
                                      (widget.data ?? const {})['bilties'][i]
                                                  ['loading_options'] ==
                                              null
                                          ? 0
                                          : (widget.data ?? const {})['bilties']
                                                  [i]['loading_options']
                                              .length,
                                  itemBuilder: (context, j) {
                                    return (ContainerDetailblueLoading_UnLoading(
                                      vehicleType:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['name']}",
                                      quantity:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['quantity']}",
                                      weight:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['weight']} Tons",
                                      material:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['type']}",
                                      image:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['image']}",
                                    ));
                                  }),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount:
                                      (widget.data ?? const {})['bilties'][i]
                                                  ['unloading_options'] ==
                                              null
                                          ? 0
                                          : (widget.data ?? const {})['bilties']
                                                  [i]['unloading_options']
                                              .length,
                                  itemBuilder: (context, j) {
                                    return (ContainerDetailblueLoading_UnLoading(
                                      vehicleType:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['name']}",
                                      quantity:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['quantity']}",
                                      weight:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['weight']} Tons",
                                      material:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['type']}",
                                      image:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['image']}",
                                    ));
                                  }),
                            ],
                          )),
                        ));
                      } else {
                        return SizedBox();
                      }
                    }),
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Constants.Primary,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          child: Text(
                            widget.data['type'].toString().toLowerCase() ==
                                    "upcountry"
                                ? "Nationwide"
                                : "${widget.data['type']}".capitalize(),
                            style: Constants.regular4
                                .copyWith(color: Constants.White),
                          ),
                        )),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Distance ",
                              style: Constants.regular4,
                            ),
                            Text(
                              "${(widget.data ?? const {})['disText']}",
                              style: Constants.heading4,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Time ",
                              style: Constants.regular4,
                            ),
                            Text(
                              "${(widget.data ?? const {})['qoutedAt']}",
                              style: Constants.heading4.copyWith(fontSize: 13),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Custom3LocationWigets(
                    pickup: (widget.data ?? const {})['originAddress'],
                    dropoff: (widget.data ?? const {})['destinationAddress'],
                    empty: (widget.data ?? const {})['containerReturnAddress']),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Container(
                            decoration: BoxDecoration(
                              color: Constants.Primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 17),
                              child: Text(
                                "My Offer",
                                style: Constants.regular4
                                    .copyWith(color: Constants.White),
                              ),
                            )),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => FindingBestQoute(
                                      orderNo:
                                          (widget.data ?? const {})['orderNo'],
                                      createdAt: (widget.data ??
                                          const {})['qoutedAt'])));
                        },
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: Constants.Grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 17),
                            child: Text(
                              "Rs ${(widget.data ?? const {})['qoute_amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                              style: Constants.regular4
                                  .copyWith(color: Constants.Black),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              //Rejected
              Container(
                width: MediaQuery.of(context).size.width * 0.3091,
                height: MediaQuery.of(context).size.width * 0.11,
                child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(0)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(18)),
                        ))),
                    onPressed: () async {
                      final res = await rejectQoute(
                          (widget.data ?? const {})['orderNo'],
                          (widget.data ?? const {})['phone']);
                      if (res['status']) {
                        popup(context,
                            title: "Offer Rejected!", message: res['message']);
                      } else {
                        popup(context,
                            success: false,
                            title: "Error Rejecting Offer!",
                            message: res['error']);
                      }
                    },
                    child: Text("Reject",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20))),
              ),
              // Counter
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                width: MediaQuery.of(context).size.width * 0.3091,
                height: MediaQuery.of(context).size.width * 0.11,
                child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(0)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xff62CAFA)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder())),
                    onPressed: () {
                      sendCounterOfferModel(
                          context,
                          (widget.data ?? const {})['orderNo'],
                          (widget.data ?? const {})['phone']);
                    },
                    child: Text("Counter",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20))),
              ),

              // Accept
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                width: MediaQuery.of(context).size.width * 0.3091,
                height: MediaQuery.of(context).size.width * 0.11,
                child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xff13DD80)),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(0)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(18)),
                        ))),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext buildcontext) {
                            return SingleChildScrollView(
                              child: SafeArea(
                                child: Container(
                                    child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                       Icon(
                                              FontAwesomeIcons.solidCheckCircle,
                                              size: 64,
                                              color: (Colors.green)),
                                        
                                      Text(
                                        "Offer Accepted !",
                                        style: Constants.heading2
                                            .copyWith(color: Constants.Primary),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "You have accepted the offer.",
                                        style: Constants.regular4
                                            .copyWith(color: Constants.Grey),
                                        textAlign: TextAlign.center,
                                      ),
                                      CustomBtn(
                                          text: "Done",
                                          onpreased: () {
                                       widget.data['type'].toString().toLowerCase() == "transit"
                              ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UploadDocumnetsTransit(
                                    vendorName:(widget.data ??
                                                  const {})['vendor_name'] ,
                                        functionToRun: () async {
                                          final res = await acceptQoute(
                                              (widget.data ??
                                                  const {})['orderNo'],
                                              (widget.data ??
                                                  const {})['phone']);
                                          if (res['status']) {
                                            print("Done");
                                          }
                                        },
                                        orderNo: (widget.data ??
                                            const {})['orderNo'],
                                        vendorPhone:
                                            (widget.data ?? const {})['user_phone'],
                                      )))
                              : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UploadDocumnetsUpcountry(
                                    vendorPhone:
                                            (widget.data ?? const {})['user_phone'],
                                            vendorName:(widget.data ??
                                                  const {})['vendor_name'] ,
                                        functionToRun: () async {
                                          final res = await acceptQoute(
                                              (widget.data ??
                                                  const {})['orderNo'],
                                              (widget.data ??
                                                  const {})['phone']);
                                          if (res['status']) {
                                            print("Done");
                                          }
                                        },
                                        orderNo: (widget.data ??
                                            const {})['orderNo'],
                                      )));
                                          },
                                          outlinebtn: false)
                                    ],
                                  ),
                                )),
                              ),
                            );
                          });
                      // showDialog(
                      //         context: context,
                      //         builder: (BuildContext context) => AlertDialog(
                      //            title: Text('Congratulations',style: Constants.heading2,),
                      //             content: Text(
                      //             "You have successfully accepted the Offer !",
                      //             style: Constants.regular4,
                      //           ),
                      //           actions: [
                      //             TextButton(onPressed: () async{
                      //                   widget.data['type'].toString().toLowerCase() == "transit"
                      //         ? Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => UploadDocumnetsTransit(
                      //               vendorName:(widget.data ??
                      //                             const {})['vendor_name'] ,
                      //                   functionToRun: () async {
                      //                     final res = await acceptQoute(
                      //                         (widget.data ??
                      //                             const {})['orderNo'],
                      //                         (widget.data ??
                      //                             const {})['phone']);
                      //                     if (res['status']) {
                      //                       print("Done");
                      //                     }
                      //                   },
                      //                   orderNo: (widget.data ??
                      //                       const {})['orderNo'],
                      //                   vendorPhone:
                      //                       (widget.data ?? const {})['user_phone'],
                      //                 )))
                      //         : Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => UploadDocumnetsUpcountry(
                      //               vendorPhone:
                      //                       (widget.data ?? const {})['user_phone'],
                      //                       vendorName:(widget.data ??
                      //                             const {})['vendor_name'] ,
                      //                   functionToRun: () async {
                      //                     final res = await acceptQoute(
                      //                         (widget.data ??
                      //                             const {})['orderNo'],
                      //                         (widget.data ??
                      //                             const {})['phone']);
                      //                     if (res['status']) {
                      //                       print("Done");
                      //                     }
                      //                   },
                      //                   orderNo: (widget.data ??
                      //                       const {})['orderNo'],
                      //                 )));
                      //             }, child: Text("Ok",style: Constants.regular3.copyWith(color: Constants.Grey),) )
                      //           ],
                      //     ));
                    },
                    // () async {
                    //   widget.data['type'].toString().toLowerCase() == "transit"
                    //       ? Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => UploadDocumnetsTransit(
                    //                 vendorName:(widget.data ??
                    //                               const {})['vendor_name'] ,
                    //                     functionToRun: () async {
                    //                       final res = await acceptQoute(
                    //                           (widget.data ??
                    //                               const {})['orderNo'],
                    //                           (widget.data ??
                    //                               const {})['phone']);
                    //                       if (res['status']) {
                    //                         print("Done");
                    //                       }
                    //                     },
                    //                     orderNo: (widget.data ??
                    //                         const {})['orderNo'],
                    //                     vendorPhone:
                    //                         (widget.data ?? const {})['user_phone'],
                    //                   )))
                    //       : Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => UploadDocumnetsUpcountry(
                    //                 vendorPhone:
                    //                         (widget.data ?? const {})['user_phone'],
                    //                         vendorName:(widget.data ??
                    //                               const {})['vendor_name'] ,
                    //                     functionToRun: () async {
                    //                       final res = await acceptQoute(
                    //                           (widget.data ??
                    //                               const {})['orderNo'],
                    //                           (widget.data ??
                    //                               const {})['phone']);
                    //                       if (res['status']) {
                    //                         print("Done");
                    //                       }
                    //                     },
                    //                     orderNo: (widget.data ??
                    //                         const {})['orderNo'],
                    //                   )));
                    //                 },
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SelectPaymentMethod(
                    //               orderNo:
                    //                   (widget.data ?? const {})['orderNo'],
                    //             )));
                    // } else {
                    //   popup(context,
                    //       success: false,
                    //       title: "Error Accepting Offer!",
                    //       message: res['error']);
                    // }

                    child: Text(
                      "Accept",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class OfferAcceptedCard extends StatefulWidget {
  final status;
  final colored;
  final data;

  OfferAcceptedCard(
      {Key? key,
      required this.status,
      required this.colored,
      required this.data})
      : super(key: key);

  @override
  _OfferAcceptedCardState createState() => _OfferAcceptedCardState();
}

class _OfferAcceptedCardState extends State<OfferAcceptedCard> {
  _OfferAcceptedCardState();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.White,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: widget.colored, width: 1),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: widget.colored,
            ),
            child: Center(
              child: Text(
                "${widget.status}",
                style: Constants.regular4.copyWith(color: Constants.White),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order #${(widget.data ?? const {})['orderNo']}",
                      style: Constants.regular4,
                    ),
                    InkWell(
                      onTap: () {
                        print(widget.data);
                      },
                      child: Text(
                        "${(widget.data ?? const {})['qoutedAt'] ?? (widget.data ?? const {})['counteredAt'] ?? (widget.data ?? const {})['vendor_countered_on']}",
                        style: Constants.regular4,
                      ),
                    )
                  ],
                ),
                ListView.builder(
                    itemCount: widget.data['bilties'].length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int i) {
                      if ((widget.data ?? const {})['bilties'][i]['type'] ==
                          "vehicle") {
                        return (Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ContainerDetailblue(
                            vehicleType:
                                "${(widget.data ?? const {})['bilties'][i]['name']}",
                            quantity:
                                "${(widget.data ?? const {})['bilties'][i]['quantity']}",
                            weight:
                                "${(widget.data ?? const {})['bilties'][i]['weight']} Tons",
                            material:
                                "${(widget.data ?? const {})['bilties'][i]['type']}",
                            image:
                                "${(widget.data ?? const {})['bilties'][i]['image']}",
                          ),
                        ));
                      } else if ((widget.data ?? const {})['bilties'][i]
                              ['type'] ==
                          "loading/unloading") {
                        return (Container(
                          decoration: BoxDecoration(
                              color: Constants.Primary,
                              borderRadius: BorderRadius.circular(12)),
                          child: (Column(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount:
                                      (widget.data ?? const {})['bilties'][i]
                                                  ['loading_options'] ==
                                              null
                                          ? 0
                                          : (widget.data ?? const {})['bilties']
                                                  [i]['loading_options']
                                              .length,
                                  itemBuilder: (context, j) {
                                    return (ContainerDetailblueLoading_UnLoading(
                                      vehicleType:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['name']}",
                                      quantity:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['quantity']}",
                                      weight:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['weight']} Tons",
                                      material:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['type']}",
                                      image:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['image']}",
                                    ));
                                  }),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount:
                                      (widget.data ?? const {})['bilties'][i]
                                                  ['unloading_options'] ==
                                              null
                                          ? 0
                                          : (widget.data ?? const {})['bilties']
                                                  [i]['unloading_options']
                                              .length,
                                  itemBuilder: (context, j) {
                                    return (ContainerDetailblueLoading_UnLoading(
                                      vehicleType:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['name']}",
                                      quantity:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['quantity']}",
                                      weight:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['weight']} Tons",
                                      material:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['type']}",
                                      image:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['image']}",
                                    ));
                                  }),
                            ],
                          )),
                        ));
                      } else {
                        return SizedBox();
                      }

                      //  Padding(
                      //   padding: const EdgeInsets.only(bottom: 8.0),
                      //   child: ContainerDetailblue(
                      //     vehicleType: widget.data['request_type'] == "transit"
                      //         ? "${(widget.data ?? const {})['bilties'][i]['type']}"
                      //         : "${widget.data['subOrder']['type']}",
                      //     quantity: widget.data['request_type'] == "transit"
                      //         ? "1"
                      //         : "1",
                      //     weight: widget.data['request_type'] == "transit"
                      //         ? "${(widget.data ?? const {})['bilties'][i]['weight']} Tons"
                      //         : "${widget.data['subOrder']['weight']} Tons",
                      //     material: widget.data['request_type'] == "transit"
                      //         ? "${(widget.data ?? const {})['bilties'][i]['material'][0]}"
                      //         : "${widget.data['subOrder']['material'][0]}",
                      //   ),
                      // );
                    }),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Distance ",
                          style: Constants.regular3,
                        ),
                        Text(
                          "${(widget.data ?? const {})['disText']}",
                          style: Constants.heading3,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Time ",
                          style: Constants.regular3,
                        ),
                        Text(
                          "${(widget.data ?? const {})['durText']}",
                          style: Constants.heading3,
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Custom3LocationWigets(
                      pickup: (widget.data ?? const {})['originAddress'],
                      dropoff: (widget.data ?? const {})['destinationAddress'],
                      empty:
                          (widget.data ?? const {})['containerReturnAddress']),
                ),
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
                                vertical: 5, horizontal: 30),
                            child: Text(
                              "Transit",
                              // "${widget.data['request_type'] ?? widget.data['type']}",
                              style: Constants.regular4
                                  .copyWith(color: Constants.White),
                            ),
                          )),
                      Container(
                          decoration: BoxDecoration(
                            color: Constants.Grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 30),
                            child: Text(
                              "Rs ${(widget.data ?? const {})['qoute_amount'] ?? (widget.data ?? const {})['amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                              style: Constants.regular4
                                  .copyWith(color: Constants.Black),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Row(
              children: [
                //Accept

                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  width: MediaQuery.of(context).size.width * 0.463,
                  height: MediaQuery.of(context).size.width * 0.11,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff13DD80)),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(18)),
                          ))),
                      onPressed: () {
                        // acceptOrder(
                        //     orderNo: widget.data['orderNo'], context: context);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => SelectPaymentMethod(
                        //           orderNo:
                        //               (widget.data ?? const {})['orderNo']),
                        // ));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UploadDocumnetsTransit(
                                      functionToRun: () {
                                        acceptOrder(
                                            orderNo: widget.data['orderNo'],
                                            context: context);
                                      },
                                      orderNo:
                                          (widget.data ?? const {})['orderNo'],
                                      vendorPhone:
                                          "${(widget.data ?? const {})['vendor_phone']}",
                                      vendorName:
                                          "${(widget.data ?? const {})['vendor_name']}",
                                    )));
                      },
                      child: Text(
                        "Accept",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                ),

                //Rejected
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  width: MediaQuery.of(context).size.width * 0.463,
                  height: MediaQuery.of(context).size.width * 0.11,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(0)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(18)),
                          ))),
                      onPressed: () async {
                        final res = await rejectOrder(
                            (widget.data ?? const {})['orderNo']);
                        if (res['status']) {
                          popup(context,
                              title: "Order Rejected!",
                              message: res['message']);
                        } else {
                          popup(context,
                              success: false,
                              title: "Error Rejecting Order!",
                              message: res['error']);
                        }
                      },
                      child: Text("Reject",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//UserCounterAcceptedByVendor
class UserCounterAcceptedByVendorCard extends StatefulWidget {
  final status;
  final colored;
  final data;

  UserCounterAcceptedByVendorCard(
      {Key? key,
      required this.status,
      required this.colored,
      required this.data})
      : super(key: key);
 
  @override
  _UserCounterAcceptedByVendorCardState createState() =>
      _UserCounterAcceptedByVendorCardState();
}

class _UserCounterAcceptedByVendorCardState
    extends State<UserCounterAcceptedByVendorCard> {
  //UserCounterAcceptedByVendorCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.White,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: widget.colored, width: 1),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: widget.colored,
            ),
            child: Center(
              child: Text(
                "${widget.status}",
                style: Constants.regular4.copyWith(color: Constants.White),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order #${(widget.data ?? const {})['orderNo']}",
                      style: Constants.regular4,
                    ),
                    InkWell(
                      onTap: () {
                        print(widget.data);
                      },
                      child: Text(
                        "${DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse((widget.data ?? const {})['date']))}",
                        //"${(widget.data ?? const {})['date']??(widget.data ?? const {})['qoutedAt'] ?? (widget.data ?? const {})['counteredAt'] ?? (widget.data ?? const {})['vendor_countered_on']}",
                        style: Constants.regular4,
                      ),
                    )
                  ],
                ),
                ListView.builder(
                    itemCount: widget.data['bilties'] == null
                        ? 0
                        : widget.data['bilties'].length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int i) {
                      if ((widget.data ?? const {})['bilties'][i]['type'] ==
                          "vehicle") {
                        return (Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ContainerDetailblue(
                            vehicleType:
                                "${(widget.data ?? const {})['bilties'][i]['name']}",
                            quantity:
                                "${(widget.data ?? const {})['bilties'][i]['quantity']}",
                            weight:
                                "${(widget.data ?? const {})['bilties'][i]['weight']} Tons",
                            material:
                                "${(widget.data ?? const {})['bilties'][i]['material']}",
                            image:
                                "${(widget.data ?? const {})['bilties'][i]['image']}",
                          ),
                        ));
                      } else if ((widget.data ?? const {})['bilties'][i]
                              ['type'] ==
                          "loading/unloading") {
                        return (Container(
                          decoration: BoxDecoration(
                              color: Constants.Primary,
                              borderRadius: BorderRadius.circular(12)),
                          child: (Column(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount:
                                      (widget.data ?? const {})['bilties'][i]
                                                  ['loading_options'] ==
                                              null
                                          ? 0
                                          : (widget.data ?? const {})['bilties']
                                                  [i]['loading_options']
                                              .length,
                                  itemBuilder: (context, j) {
                                    return (ContainerDetailblueLoading_UnLoading(
                                      vehicleType:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['name']}",
                                      quantity:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['quantity']}",
                                      weight:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['weight']} Tons",
                                      material:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['type']}",
                                      image:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['image']}",
                                    ));
                                  }),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount:
                                      (widget.data ?? const {})['bilties'][i]
                                                  ['unloading_options'] ==
                                              null
                                          ? 0
                                          : (widget.data ?? const {})['bilties']
                                                  [i]['unloading_options']
                                              .length,
                                  itemBuilder: (context, j) {
                                    return (ContainerDetailblueLoading_UnLoading(
                                      vehicleType:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['name']}",
                                      quantity:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['quantity']}",
                                      weight:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['weight']} Tons",
                                      material:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['type']}",
                                      image:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['image']}",
                                    ));
                                  }),
                            ],
                          )),
                        ));
                      } else {
                        return SizedBox();
                      }
                    }),
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Constants.Primary,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 17),
                          child: Text(
                            (widget.data ?? const {})['request_type']
                                        .toString()
                                        .toLowerCase() ==
                                    "upcountry"
                                ? "Nationwide"
                                : "${(widget.data ?? const {})['request_type']}"
                                    .capitalize(),
                            // "${widget.data['request_type'] ?? widget.data['type']}",
                            style: Constants.regular4
                                .copyWith(color: Constants.White),
                          ),
                        )),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Distance ",
                              style: Constants.regular4,
                            ),
                            Text(
                              "${(widget.data ?? const {})['disText']}",
                              style: Constants.heading4,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Time ",
                              style: Constants.regular4,
                            ),
                            Text(
                              "${(widget.data ?? const {})['counteredAt']}",
                              style: Constants.heading4.copyWith(fontSize: 14),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Custom3LocationWigets(
                    pickup: (widget.data ?? const {})['originAddress'],
                    dropoff: (widget.data ?? const {})['destinationAddress'],
                    empty: (widget.data ?? const {})['containerReturnAddress']),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: Constants.Grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 17),
                            child: Text(
                              "Rs ${(widget.data ?? const {})['qoute_amount'] ?? (widget.data ?? const {})['amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                              style: Constants.regular4
                                  .copyWith(color: Constants.Black),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Row(
              children: [
                //Accept

                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  width: MediaQuery.of(context).size.width * 0.463,
                  height: MediaQuery.of(context).size.width * 0.11,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff13DD80)),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(18)),
                          ))),
                      onPressed: () {
                           showModalBottomSheet(
                          context: context,
                          builder: (BuildContext buildcontext) {
                            return SingleChildScrollView(
                              child: SafeArea(
                                child: Container(
                                    child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                       Icon(
                                              FontAwesomeIcons.solidCheckCircle,
                                              size: 64,
                                              color: (Colors.green)),
                                        
                                      Text(
                                        "Offer Accepted !",
                                        style: Constants.heading2
                                            .copyWith(color: Constants.Primary),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "You have accepted the offer.",
                                        style: Constants.regular4
                                            .copyWith(color: Constants.Grey),
                                        textAlign: TextAlign.center,
                                      ),
                                      CustomBtn(
                                          text: "Done",
                                          onpreased: () {
                                              "${(widget.data ?? const {})['request_type'].toString().toLowerCase()}" ==
                                                  "upcountry"
                                              ? Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UploadDocumnetsUpcountry(
                                                            functionToRun: () {
                                                              acceptOrder(
                                                                  orderNo: widget
                                                                          .data[
                                                                      'orderNo'],
                                                                  context:
                                                                      context);
                                                            },
                                                            orderNo: (widget
                                                                        .data ??
                                                                    const {})[
                                                                'orderNo'],
                                                            vendorPhone:
                                                                "${(widget.data ?? const {})['vendor_phone']}",
                                                            vendorName:
                                                                "${(widget.data ?? const {})['vendor_name']}",
                                                          )))
                                              : Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UploadDocumnetsTransit(
                                                            functionToRun: () {
                                                              acceptOrder(
                                                                  orderNo: widget
                                                                          .data[
                                                                      'orderNo'],
                                                                  context:
                                                                      context);
                                                            },
                                                            orderNo: (widget
                                                                        .data ??
                                                                    const {})[
                                                                'orderNo'],
                                                            vendorPhone:
                                                                "${(widget.data ?? const {})['vendor_phone']}",
                                                            vendorName:
                                                                "${(widget.data ?? const {})['vendor_name']}",
                                                          )));
                                          },
                                          outlinebtn: false)
                                    ],
                                  ),
                                )),
                              ),
                            );
                          });
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) => AlertDialog(
                        //           title: Text(
                        //             'congratulations',
                        //             style: Constants.heading2,
                        //           ),
                        //           content: Text(
                        //             "You have successfully accepted the Offer !",
                        //             style: Constants.regular4,
                        //           ),
                        //           actions: [
                        //             TextButton(
                        //                 onPressed: () async {
                        //                   "${(widget.data ?? const {})['request_type'].toString().toLowerCase()}" ==
                        //                           "upcountry"
                        //                       ? Navigator.push(
                        //                           context,
                        //                           MaterialPageRoute(
                        //                               builder: (context) =>
                        //                                   UploadDocumnetsUpcountry(
                        //                                     functionToRun: () {
                        //                                       acceptOrder(
                        //                                           orderNo: widget
                        //                                                   .data[
                        //                                               'orderNo'],
                        //                                           context:
                        //                                               context);
                        //                                     },
                        //                                     orderNo: (widget
                        //                                                 .data ??
                        //                                             const {})[
                        //                                         'orderNo'],
                        //                                     vendorPhone:
                        //                                         "${(widget.data ?? const {})['vendor_phone']}",
                        //                                     vendorName:
                        //                                         "${(widget.data ?? const {})['vendor_name']}",
                        //                                   )))
                        //                       : Navigator.push(
                        //                           context,
                        //                           MaterialPageRoute(
                        //                               builder: (context) =>
                        //                                   UploadDocumnetsTransit(
                        //                                     functionToRun: () {
                        //                                       acceptOrder(
                        //                                           orderNo: widget
                        //                                                   .data[
                        //                                               'orderNo'],
                        //                                           context:
                        //                                               context);
                        //                                     },
                        //                                     orderNo: (widget
                        //                                                 .data ??
                        //                                             const {})[
                        //                                         'orderNo'],
                        //                                     vendorPhone:
                        //                                         "${(widget.data ?? const {})['vendor_phone']}",
                        //                                     vendorName:
                        //                                         "${(widget.data ?? const {})['vendor_name']}",
                        //                                   )));
                        //                 },
                        //                 child: Text(
                        //                   "Ok",
                        //                   style: Constants.regular3
                        //                       .copyWith(color: Constants.Grey),
                        //                 ))
                        //           ],
                        //         ));
                      },
                      child: Text(
                        "Accept",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                ),

                //Rejected
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  width: MediaQuery.of(context).size.width * 0.463,
                  height: MediaQuery.of(context).size.width * 0.11,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(0)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(18)),
                          ))),
                      onPressed: () async {
                        final res = await rejectOrder(
                            (widget.data ?? const {})['orderNo']);
                        if (res['status']) {
                          popup(context,
                              title: "Order Rejected!",
                              message: res['message']);
                        } else {
                          popup(context,
                              success: false,
                              title: "Error Rejecting Order!",
                              message: res['error']);
                        }
                      },
                      child: Text("Reject",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//Offer Pending Card
class OfferPendingCard extends StatefulWidget {
  final status;
  final colored;
  final data;

  OfferPendingCard(
      {Key? key,
      required this.status,
      required this.colored,
      required this.data})
      : super(key: key);

  @override
  _OfferPendingCardState createState() => _OfferPendingCardState();
}

class _OfferPendingCardState extends State<OfferPendingCard> {
  _OfferPendingCardState();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.White,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: widget.colored, width: 1),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: widget.colored,
            ),
            child: Center(
              child: Text(
                "${widget.status}",
                style: Constants.regular4.copyWith(color: Constants.White),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order #${(widget.data ?? const {})['orderNo']}",
                      style: Constants.regular4,
                    ),
                    InkWell(
                      onTap: () {
                        print(widget.data);
                      },
                      child: Text(
                        "${(widget.data ?? const {})['qoutedAt'] ?? (widget.data ?? const {})['counteredAt'] ?? (widget.data ?? const {})['vendor_countered_on']}",
                        style: Constants.regular4,
                      ),
                    )
                  ],
                ),
                ListView.builder(
                    itemCount: widget.data['bilties'].length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int i) {
                      if ((widget.data ?? const {})['bilties'][i]['type'] ==
                          "vehicle") {
                        return (Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ContainerDetailblue(
                            vehicleType:
                                "${(widget.data ?? const {})['bilties'][i]['name']}",
                            quantity:
                                "${(widget.data ?? const {})['bilties'][i]['quantity']}",
                            weight:
                                "${(widget.data ?? const {})['bilties'][i]['weight']} Tons",
                            material:
                                "${(widget.data ?? const {})['bilties'][i]['type']}",
                            image:
                                "${(widget.data ?? const {})['bilties'][i]['image']}",
                          ),
                        ));
                      } else if ((widget.data ?? const {})['bilties'][i]
                              ['type'] ==
                          "loading/unloading") {
                        return (Container(
                          decoration: BoxDecoration(
                              color: Constants.Primary,
                              borderRadius: BorderRadius.circular(12)),
                          child: (Column(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount:
                                      (widget.data ?? const {})['bilties'][i]
                                                  ['loading_options'] ==
                                              null
                                          ? 0
                                          : (widget.data ?? const {})['bilties']
                                                  [i]['loading_options']
                                              .length,
                                  itemBuilder: (context, j) {
                                    return (ContainerDetailblueLoading_UnLoading(
                                      vehicleType:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['name']}",
                                      quantity:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['quantity']}",
                                      weight:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['weight']} Tons",
                                      material:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['type']}",
                                      image:
                                          "${(widget.data ?? const {})['bilties'][i]['loading_options'][j]['image']}",
                                    ));
                                  }),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount:
                                      (widget.data ?? const {})['bilties'][i]
                                                  ['unloading_options'] ==
                                              null
                                          ? 0
                                          : (widget.data ?? const {})['bilties']
                                                  [i]['unloading_options']
                                              .length,
                                  itemBuilder: (context, j) {
                                    return (ContainerDetailblueLoading_UnLoading(
                                      vehicleType:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['name']}",
                                      quantity:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['quantity']}",
                                      weight:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['weight']} Tons",
                                      material:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['type']}",
                                      image:
                                          "${(widget.data ?? const {})['bilties'][i]['unloading_options'][j]['image']}",
                                    ));
                                  }),
                            ],
                          )),
                        ));
                      } else {
                        return SizedBox();
                      }

                      //  Padding(
                      //   padding: const EdgeInsets.only(bottom: 8.0),
                      //   child: ContainerDetailblue(
                      //     vehicleType: widget.data['request_type'] == "transit"
                      //         ? "${(widget.data ?? const {})['bilties'][i]['type']}"
                      //         : "${widget.data['subOrder']['type']}",
                      //     quantity: widget.data['request_type'] == "transit"
                      //         ? "1"
                      //         : "1",
                      //     weight: widget.data['request_type'] == "transit"
                      //         ? "${(widget.data ?? const {})['bilties'][i]['weight']} Tons"
                      //         : "${widget.data['subOrder']['weight']} Tons",
                      //     material: widget.data['request_type'] == "transit"
                      //         ? "${(widget.data ?? const {})['bilties'][i]['material'][0]}"
                      //         : "${widget.data['subOrder']['material'][0]}",
                      //   ),
                      // );
                    }),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Distance ",
                          style: Constants.regular3,
                        ),
                        Text(
                          "${(widget.data ?? const {})['disText']}",
                          style: Constants.heading3,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Time ",
                          style: Constants.regular3,
                        ),
                        Text(
                          "${(widget.data ?? const {})['durText']}",
                          style: Constants.heading3,
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Custom3LocationWigets(
                      pickup: (widget.data ?? const {})['originAddress'],
                      dropoff: (widget.data ?? const {})['destinationAddress'],
                      empty:
                          (widget.data ?? const {})['containerReturnAddress']),
                ),
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
                                vertical: 5, horizontal: 30),
                            child: Text(
                              "Transit",
                              // "${widget.data['request_type'] ?? widget.data['type']}",
                              style: Constants.regular4
                                  .copyWith(color: Constants.White),
                            ),
                          )),
                      Container(
                          decoration: BoxDecoration(
                            color: Constants.Grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 30),
                            child: Text(
                              "Rs ${(widget.data ?? const {})['qoute_amount'] ?? (widget.data ?? const {})['amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                              style: Constants.regular4
                                  .copyWith(color: Constants.Black),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Row(
              children: [
                //Accept

                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  width: MediaQuery.of(context).size.width * 0.463,
                  height: MediaQuery.of(context).size.width * 0.11,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff13DD80)),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(18)),
                          ))),
                      onPressed: () {
                        // acceptOrder(
                        //     orderNo: widget.data['orderNo'], context: context);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => SelectPaymentMethod(
                        //           orderNo:
                        //               (widget.data ?? const {})['orderNo']),
                        // ));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UploadDocumnetsTransit(
                                      functionToRun: () {
                                        acceptOrder(
                                            orderNo: widget.data['orderNo'],
                                            context: context);
                                      },
                                      orderNo:
                                          (widget.data ?? const {})['orderNo'],
                                      vendorPhone:
                                          "${(widget.data ?? const {})['vendor_phone']}",
                                      vendorName:
                                          "${(widget.data ?? const {})['vendor_name']}",
                                    )));
                      },
                      child: Text(
                        "Accept",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                ),

                //Rejected
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  width: MediaQuery.of(context).size.width * 0.463,
                  height: MediaQuery.of(context).size.width * 0.11,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(0)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(18)),
                          ))),
                      onPressed: () async {
                        final res = await rejectOrder(
                            (widget.data ?? const {})['orderNo']);
                        if (res['status']) {
                          popup(context,
                              title: "Order Rejected!",
                              message: res['message']);
                        } else {
                          popup(context,
                              success: false,
                              title: "Error Rejecting Order!",
                              message: res['error']);
                        }
                      },
                      child: Text("Reject",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
// Commented For second phase
// void ManageOrderForUpcountry(context, bilties, date, {type = null}) {
//   showModalBottomSheet(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
//       backgroundColor: Colors.white,
//       context: context,
//       builder: (BuildContext buildcontext) {
//         return SingleChildScrollView(
//           child: SafeArea(
//             child: Container(
//                 height: MediaQuery.of(context).size.height * .60,
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                     child: Column(
//                       children: [
//                         Text(
//                           "Order Bilties",
//                           style: Constants.heading3
//                               .copyWith(color: Constants.Primary),
//                         ),
//                         Column(
//                           children: [
//                             Container(
//                               height: 400,
//                               child: ListView.builder(
//                                 padding: EdgeInsets.all(10.0),
//                                 scrollDirection: Axis.vertical,
//                                 shrinkWrap: true,
//                                 itemCount: bilties.length,
//                                 itemBuilder: (BuildContext context, int i) {
//                                   return GestureDetector(
//                                     onTap: () {
//                                       // print(
//                                       //   bilties[i]['biltyNo'],
//                                       // );
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   SingleBiltyTransit(
//                                                     biltyNo: bilties[i]
//                                                         ['biltyNo'],
//                                                   )));
//                                       print('${bilties[i]['biltyNo']}');
//                                     },
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Image.asset(
//                                               "assets/images/vehicle.png",
//                                               height: 50,
//                                             ),
//                                             Text(
//                                               (type ?? bilties[i]['type']),
//                                               style: Constants.regular4
//                                                   .copyWith(
//                                                       color: Constants.Grey),
//                                               textAlign: TextAlign.left,
//                                             ),
//                                             (bilties[i]['vehicle_number'] !=
//                                                     null)
//                                                 ? Text(
//                                                     bilties[i]
//                                                         ['vehicle_number'],
//                                                     style: Constants.regular4
//                                                         .copyWith(
//                                                             color:
//                                                                 Constants.Grey),
//                                                     textAlign: TextAlign.left,
//                                                   )
//                                                 : Text(
//                                                     'Pending',
//                                                     style: Constants.regular4
//                                                         .copyWith(
//                                                             color: Constants
//                                                                 .BrightRed),
//                                                     textAlign: TextAlign.left,
//                                                   )
//                                           ],
//                                         ),
//                                         Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               bilties[i]['biltyNo'],
//                                               style: Constants.heading4
//                                                   .copyWith(
//                                                       color: Constants.Black),
//                                               textAlign: TextAlign.left,
//                                             ),
//                                             Text(
//                                               (bilties[i]['driver_name'] ??
//                                                   'Driver'),
//                                               style: Constants.heading4
//                                                   .copyWith(
//                                                       color: Constants.Black),
//                                               textAlign: TextAlign.left,
//                                             ),
//                                             Text(
//                                               "Status:",
//                                               style: Constants.heading4
//                                                   .copyWith(
//                                                       color: Constants.Black),
//                                               textAlign: TextAlign.left,
//                                             ),
//                                           ],
//                                         ),
//                                         Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.end,
//                                           children: [
//                                             Text(
//                                               date,
//                                               style: Constants.regular4
//                                                   .copyWith(
//                                                       color: Constants.Grey),
//                                               textAlign: TextAlign.left,
//                                             ),
//                                             (bilties[i]['driver_phone'] != null)
//                                                 ? Text(
//                                                     bilties[i]['driver_phone'],
//                                                     style: Constants.regular4
//                                                         .copyWith(
//                                                             color:
//                                                                 Constants.Grey),
//                                                     textAlign: TextAlign.left,
//                                                   )
//                                                 : Text(
//                                                     'Pending',
//                                                     style: Constants.regular4
//                                                         .copyWith(
//                                                             color: Constants
//                                                                 .BrightRed),
//                                                     textAlign: TextAlign.left,
//                                                   ),
//                                             Text(
//                                               bilties[i]['status'],
//                                               style: Constants.regular4
//                                                   .copyWith(
//                                                       color: Constants.Grey),
//                                               textAlign: TextAlign.left,
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 )),
//           ),
//         );
//       });
// }

// Show All Bilties(Rayyan)
void showAllBilties(context, bilties, orderNo, date, requestType, originLat,
    originLng, destLat, destLng,
    {type = null}) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext buildcontext) {
        return SingleChildScrollView(
          child: SafeArea(
            child: Container(
                height: MediaQuery.of(context).size.height * .60,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Text(
                          "Order Bilties",
                          style: Constants.heading3
                              .copyWith(color: Constants.Primary),
                        ),
                        Column(
                          children: [
                            Container(
                              height: 400,
                              child: ListView.builder(
                                padding: EdgeInsets.all(10.0),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: bilties.length,
                                itemBuilder: (BuildContext context, int i) {
                                  if (bilties[i]['type'] == "vehicle") {
                                    return Column(
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            requestType == "transit"
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SingleBiltyUpcountry(
                                                              biltyNo: bilties[
                                                                  i]['biltyNo'],
                                                              orderNumber:
                                                                  orderNo,
                                                              originLat:
                                                                  originLat,
                                                              originLng:
                                                                  originLng,
                                                              destinationLat:
                                                                  destLat,
                                                              destinationLng:
                                                                  destLng,
                                                            )))
                                                :
                                                // The following condition is for upcountry request just ignore the name
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SingleBiltyTransit(
                                                              biltyNo: bilties[
                                                                  i]['biltyNo'],
                                                              orderNumber:
                                                                  orderNo,
                                                              originLat:
                                                                  originLat,
                                                              originLng:
                                                                  originLng,
                                                              destinationLat:
                                                                  destLat,
                                                              destinationLng:
                                                                  destLng,
                                                            )));
                                            print('${bilties[i]['biltyNo']}');
                                          },
                                          leading: Expanded(
                                            child: Column(
                                              children: [
                                                Image(
                                                  image: NetworkImage(
                                                      "${(type ?? bilties[i]['image'])}"),
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "${(type ?? bilties[i]['biltyNo'])}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                //Text("BT145857",)
                                              ],
                                            ),
                                          ),
                                          title: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "${(type ?? bilties[i]['name'])}",
                                                  ),
                                                ],
                                              ),
                                              // Row(
                                              //   children: [
                                              //     //Spacer(),
                                              //     //Text("09 Sept, 2021"),
                                              //     (type ?? bilties[i]['driver_alotted_on']) ==
                                              //             null
                                              //         ? Text("Pending")
                                              //         : Text(
                                              //             "${(type ?? bilties[i]['driver_alotted_on'])}",
                                              //             style: TextStyle(
                                              //                 color:
                                              //                     Constants.Grey)),
                                              //   ],
                                              // ),
                                              Row(
                                                children: [
                                                  (type ??
                                                              bilties[i][
                                                                  'driver_name']) ==
                                                          null
                                                      ? Text("Driver Pending",
                                                          style: TextStyle(
                                                              color: Constants
                                                                  .BrightRed))
                                                      : Text(
                                                          "${(type ?? bilties[i]['driver_name'])}",
                                                          style: TextStyle(
                                                              color: Constants
                                                                  .Black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  Spacer(),
                                                  (type ??
                                                              bilties[i][
                                                                  'driver_phone']) ==
                                                          null
                                                      ? Text("",
                                                          style: TextStyle(
                                                              color: Constants
                                                                  .BrightRed))
                                                      : Text(
                                                          "${(type ?? bilties[i]['driver_phone'])}",
                                                          style: TextStyle(
                                                              color: Constants
                                                                  .Black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  (type ??
                                                              bilties[i][
                                                                  'vehicle_number']) ==
                                                          null
                                                      ? Text("Details Pending",
                                                          style: TextStyle(
                                                              color: Constants
                                                                  .BrightRed))
                                                      : Text(
                                                          "${(type ?? bilties[i]['vehicle_number'])}",
                                                          style: TextStyle(
                                                            color:
                                                                Constants.Black,
                                                            //fontWeight: FontWeight.bold
                                                          )),
                                                  Spacer(),
                                                  switchStatus(
                                                    "${(type ?? bilties[i]['status'])}",
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1,
                                        )
                                      ],
                                    );
                                    // return GestureDetector(
                                    //   onTap: () {
                                    //     // print(
                                    //     //   bilties[i]['biltyNo'],
                                    //     // );
                                    //     requestType == "transit"
                                    //         ? Navigator.push(
                                    //             context,
                                    //             MaterialPageRoute(
                                    //                 builder: (context) =>
                                    //                     SingleBiltyUpcountry(
                                    //                       biltyNo: bilties[i]
                                    //                           ['biltyNo'],
                                    //                       orderNumber: orderNo,
                                    //                       originLat: originLat,
                                    //                       originLng: originLng,
                                    //                       destinationLat:
                                    //                           destLat,
                                    //                       destinationLng:
                                    //                           destLng,
                                    //                     )))
                                    //         :
                                    //         // The following condition is for upcountry request just ignore the name
                                    //         Navigator.push(
                                    //             context,
                                    //             MaterialPageRoute(
                                    //                 builder: (context) =>
                                    //                     SingleBiltyTransit(
                                    //                       biltyNo: bilties[i]
                                    //                           ['biltyNo'],
                                    //                       orderNumber: orderNo,
                                    //                       originLat: originLat,
                                    //                       originLng: originLng,
                                    //                       destinationLat:
                                    //                           destLat,
                                    //                       destinationLng:
                                    //                           destLng,
                                    //                     )));
                                    //     print('${bilties[i]['biltyNo']}');
                                    //   },
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceEvenly,
                                    //     children: [
                                    //       Column(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.start,
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment.start,
                                    //         children: [
                                    //           Image(
                                    //             image: NetworkImage(
                                    //               "${(type ?? bilties[i]['image'])}",
                                    //             ),
                                    //             height: 40,
                                    //             width: 50,
                                    //           ),
                                    //           Text(
                                    //             "${(type ?? bilties[i]['type'])}",
                                    //             style: Constants.regular4
                                    //                 .copyWith(
                                    //                     color: Constants.Grey),
                                    //             textAlign: TextAlign.left,
                                    //           ),
                                    //           Container(
                                    //             width: 100,
                                    //             child: Text(
                                    //               bilties[i]['vehicle_number'] ==
                                    //                       null
                                    //                   ? ' '
                                    //                   : "${bilties[i]['vehicle_number']}",
                                    //               overflow: TextOverflow.fade,
                                    //               style: Constants.regular4
                                    //                   .copyWith(
                                    //                       color:
                                    //                           Constants.Grey),
                                    //               textAlign: TextAlign.left,
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       Column(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.start,
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment.start,
                                    //         children: [
                                    //           Text(
                                    //             "${bilties[i]['biltyNo']}",
                                    //             style: Constants.heading4
                                    //                 .copyWith(
                                    //                     color: Constants.Black),
                                    //             textAlign: TextAlign.left,
                                    //           ),
                                    //           Text(
                                    //             "Driver",
                                    //             style: Constants.heading4
                                    //                 .copyWith(
                                    //                     color: Constants.Black),
                                    //             textAlign: TextAlign.left,
                                    //           ),
                                    //           Text(
                                    //             "Status",
                                    //             style: Constants.heading4
                                    //                 .copyWith(
                                    //                     color: Constants.Black),
                                    //             textAlign: TextAlign.left,
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       Column(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.start,
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment.end,
                                    //         children: [
                                    //           Container(
                                    //             width: 100,
                                    //             child: Text(
                                    //               (bilties[i]['driver_name'] ??
                                    //                           'Driver') ==
                                    //                       null
                                    //                   ? "pending"
                                    //                   : "${(bilties[i]['driver_name'] ?? 'Driver')}",
                                    //               style: Constants.regular4
                                    //                   .copyWith(
                                    //                       color:
                                    //                           Constants.Grey),
                                    //               textAlign: TextAlign.left,
                                    //             ),
                                    //           ),
                                    //           // formatDate("${data[index]['driver_alotted_on']}",),

                                    //           Container(
                                    //             width: 100,
                                    //             child: Text(
                                    //               bilties[i]['driver_phone'] ==
                                    //                       null
                                    //                   ? "pending"
                                    //                   : "${bilties[i]['driver_phone']}",
                                    //               style: Constants.regular4
                                    //                   .copyWith(
                                    //                       color:
                                    //                           Constants.Grey),
                                    //               textAlign: TextAlign.left,
                                    //             ),
                                    //           ),
                                    //           switchRayyan(
                                    //             "${bilties[i]['status']}",
                                    //           ),
                                    //           // Text(
                                    //           //   "Pending",
                                    //           //   style: Constants.regular4
                                    //           //       .copyWith(color: Constants.Grey),
                                    //           //   textAlign: TextAlign.left,
                                    //           // ),
                                    //         ],
                                    //       )
                                    //     ],

                                    //     //   mainAxisAlignment:
                                    //     //       MainAxisAlignment.spaceEvenly,
                                    //     //   children: [
                                    //     //     Column(
                                    //     //       mainAxisAlignment:
                                    //     //           MainAxisAlignment.start,
                                    //     //       crossAxisAlignment:
                                    //     //           CrossAxisAlignment.start,
                                    //     //       children: [
                                    //     //         Image.asset(
                                    //     //           "assets/images/vehicle.png",
                                    //     //           height: 40,
                                    //     //         ),
                                    //     //         Text(
                                    //     //           (type ?? bilties[i]['type']),
                                    //     //           style: Constants.regular4
                                    //     //               .copyWith(
                                    //     //                   color: Constants.Grey),
                                    //     //           textAlign: TextAlign.left,
                                    //     //         ),
                                    //     //         (bilties[i]['vehicle_number'] !=
                                    //     //                 null)
                                    //     //             ? Text(
                                    //     //                 bilties[i]
                                    //     //                     ['vehicle_number'],
                                    //     //                 style: Constants.regular4
                                    //     //                     .copyWith(
                                    //     //                         color: Constants
                                    //     //                             .Grey),
                                    //     //                 textAlign: TextAlign.left,
                                    //     //               )
                                    //     //             : Text(
                                    //     //                 'Pending',
                                    //     //                 style: Constants.regular4
                                    //     //                     .copyWith(
                                    //     //                         color: Constants
                                    //     //                             .BrightRed),
                                    //     //                 textAlign: TextAlign.left,
                                    //     //               )
                                    //     //       ],
                                    //     //     ),
                                    //     //     Column(
                                    //     //       mainAxisAlignment:
                                    //     //           MainAxisAlignment.start,
                                    //     //       crossAxisAlignment:
                                    //     //           CrossAxisAlignment.start,
                                    //     //       children: [
                                    //     //         Text(
                                    //     //           bilties[i]['biltyNo'],
                                    //     //           style: Constants.heading4
                                    //     //               .copyWith(
                                    //     //                   color: Constants.Black),
                                    //     //           textAlign: TextAlign.left,
                                    //     //         ),
                                    //     //         Text(
                                    //     //           (bilties[i]['driver_name'] ??
                                    //     //               'Driver'),
                                    //     //           style: Constants.heading4
                                    //     //               .copyWith(
                                    //     //                   color: Constants.Black),
                                    //     //           textAlign: TextAlign.left,
                                    //     //         ),
                                    //     //         Text(
                                    //     //           "Status:",
                                    //     //           style: Constants.heading4
                                    //     //               .copyWith(
                                    //     //                   color: Constants.Black),
                                    //     //           textAlign: TextAlign.left,
                                    //     //         ),
                                    //     //       ],
                                    //     //     ),
                                    //     //     Column(
                                    //     //       mainAxisAlignment:
                                    //     //           MainAxisAlignment.start,
                                    //     //       crossAxisAlignment:
                                    //     //           CrossAxisAlignment.end,
                                    //     //       children: [
                                    //     //         Text(
                                    //     //           date,
                                    //     //           style: Constants.regular4
                                    //     //               .copyWith(
                                    //     //                   color: Constants.Grey),
                                    //     //           textAlign: TextAlign.left,
                                    //     //         ),
                                    //     //         (bilties[i]['driver_phone'] !=
                                    //     //                 null)
                                    //     //             ? Text(
                                    //     //                 bilties[i]
                                    //     //                     ['driver_phone'],
                                    //     //                 style: Constants.regular4
                                    //     //                     .copyWith(
                                    //     //                         color: Constants
                                    //     //                             .Grey),
                                    //     //                 textAlign: TextAlign.left,
                                    //     //               )
                                    //     //             : Text(
                                    //     //                 'Pending',
                                    //     //                 style: Constants.regular4
                                    //     //                     .copyWith(
                                    //     //                         color: Constants
                                    //     //                             .BrightRed),
                                    //     //                 textAlign: TextAlign.left,
                                    //     //               ),
                                    //     //         Text(
                                    //     //           bilties[i]['status'],
                                    //     //           style: Constants.regular4
                                    //     //               .copyWith(
                                    //     //                   color: Constants.Grey),
                                    //     //           textAlign: TextAlign.left,
                                    //     //         ),
                                    //     //       ],
                                    //     //     )
                                    //     //   ],
                                    //   ),
                                    // );
                                  } else if (bilties[i]['type'] ==
                                      "loading/unloading") {
                                    return Column(
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: ScrollPhysics(),
                                            itemCount: bilties[i]
                                                        ['loading_options'] ==
                                                    null
                                                ? 0
                                                : bilties[i]['loading_options']
                                                    .length,
                                            itemBuilder: (context, j) {
                                              return (ListTile(
                                                leading: Column(
                                                  children: [
                                                    Image(
                                                      image: NetworkImage(
                                                          "${(type ?? bilties[i]['loading_options'][j]['image'])}"),
                                                      height: 40,
                                                      width: 60,
                                                    ),
                                                  ],
                                                ),
                                                // leading: Image(
                                                //   image: NetworkImage(
                                                //     "${(type ?? bilties[i]['loading_options'][j]['image'])}",
                                                //   ),
                                                //   height: 40,
                                                //   width: 50,
                                                // ),
                                                title: Text(
                                                  bilties[i]['loading_options']
                                                      [j]['name'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                subtitle: Text(
                                                  bilties[i]['loading_options']
                                                      [j]['type'],
                                                  // style: Constants.regular3
                                                  //     .copyWith(
                                                  //         color:
                                                  //             Constants.Grey),
                                                ),
                                                trailing: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        bilties[i]['loading_options']
                                                                        [j]
                                                                    ['name'] ==
                                                                "Labor"
                                                            ? ""
                                                            : "${bilties[i]['loading_options'][j]['weight']} Tons",
                                                        style: Constants
                                                            .regular3
                                                            .copyWith(
                                                                color: Constants
                                                                    .Primary,
                                                                fontSize: 14),
                                                      ),
                                                      Text(
                                                        bilties[i]['loading_options']
                                                                        [j][
                                                                    'driver_phone'] ==
                                                                null
                                                            ? ""
                                                            : "${bilties[i]['loading_options'][j]['driver_phone']}",
                                                        style: Constants
                                                            .regular3
                                                            .copyWith(
                                                                color: Constants
                                                                    .Primary,
                                                                fontSize: 13),
                                                      ),
                                                      Text(
                                                        bilties[i]['loading_options']
                                                                        [j][
                                                                    'driver_name'] ==
                                                                null
                                                            ? ""
                                                            : "${bilties[i]['loading_options'][j]['driver_name']}",
                                                        style: Constants
                                                            .regular3
                                                            .copyWith(
                                                                color: Constants
                                                                    .Primary,
                                                                fontSize: 13),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                            }),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: ScrollPhysics(),
                                            itemCount: bilties[i]
                                                        ['unloading_options'] ==
                                                    null
                                                ? 0
                                                : bilties[i]
                                                        ['unloading_options']
                                                    .length,
                                            itemBuilder: (context, j) {
                                              return (ListTile(
                                                leading: Image(
                                                  image: NetworkImage(
                                                    "${(type ?? bilties[i]['unloading_options'][j]['image'])}",
                                                  ),
                                                  height: 40,
                                                  width: 60,
                                                ),
                                                title: Text(
                                                  bilties[i]
                                                          ['unloading_options']
                                                      [j]['name'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                subtitle: Text(
                                                  bilties[i]
                                                          ['unloading_options']
                                                      [j]['type'],
                                                  // style: Constants.regular3
                                                  //     .copyWith(
                                                  //         color:
                                                  //             Constants.Grey),
                                                ),
                                                trailing: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        bilties[i]['unloading_options']
                                                                        [j]
                                                                    ['name'] ==
                                                                "Labor"
                                                            ? ""
                                                            : "${bilties[i]['unloading_options'][j]['weight']} Tons",
                                                        style: Constants
                                                            .regular3
                                                            .copyWith(
                                                                color: Constants
                                                                    .Primary,
                                                                fontSize: 14),
                                                      ),
                                                      Text(
                                                        bilties[i]['unloading_options']
                                                                        [j][
                                                                    'driver_phone'] ==
                                                                null
                                                            ? ""
                                                            : "${bilties[i]['unloading_options'][j]['driver_phone']}",
                                                        style: Constants
                                                            .regular3
                                                            .copyWith(
                                                                color: Constants
                                                                    .Primary,
                                                                fontSize: 13),
                                                      ),
                                                      Text(
                                                        bilties[i]['unloading_options']
                                                                        [j][
                                                                    'driver_name'] ==
                                                                null
                                                            ? ""
                                                            : "${bilties[i]['unloading_options'][j]['driver_name']}",
                                                        style: Constants
                                                            .regular3
                                                            .copyWith(
                                                                color: Constants
                                                                    .Primary,
                                                                fontSize: 13),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                            }),
                                      ],
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        );
      });
}

switchStatus(position) {
  switch (position) {
    case "pending":
      return Text(
        "",
        style: TextStyle(color: Constants.BrightRed),
      );
      break;
    case "inprocess":
      return Text(
        "In-Process",
        style: TextStyle(color: Colors.green),
      );
      break;
    case "driver_reached":
      return Text(
        "Driver Reached",
        style: TextStyle(color: Colors.green[500]),
      );
    case "driver_pickup":
      return Text(
        "Driver Pickup",
        style: TextStyle(color: Colors.green[500]),
      );
    case "driver_delivered":
      return Text(
        "Driver Delivered",
        style: TextStyle(color: Colors.green[500]),
      );
    case "unloading_complete":
      return Text(
        "Unloading Complete",
        style: TextStyle(color: Colors.green[500]),
      );
    case "container_returned":
      return Text(
        "Container Returned",
        style: TextStyle(color: Colors.green[500]),
      );
    default:
      return Text(
        "pending",
        style: TextStyle(color: Constants.BrightRed),
      );
  }
}

void sendCounterOfferModel(context, orderNo, vendor_phone) {
  TextEditingController amount = TextEditingController();
  showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: Text(
                    "If your counter is accepted, the transaction will be considered confirmed If you reject a 5% penalty will be applied of the value. Enter the counter offer below, which you want to send to the vendor",
                    style: Constants.regular4.copyWith(color: Constants.Black),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 8.0,
                        ),
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                color: Constants.Primary, width: 0.5),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: TextFormField(
                          controller: amount,
                          decoration: InputDecoration(
                              hintText: "Enter Amount",
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                                vertical: 10.0,
                              )),
                          keyboardType: TextInputType.number,
                          onChanged: (string) {
                            string = '${formNum(
                              string.replaceAll(',', ''),
                            )}';
                            amount.value = TextEditingValue(
                              text: string,
                              selection: TextSelection.collapsed(
                                offset: string.length,
                              ),
                            );
                          },
                        ),
                      ),
                      CustomBtn(
                          text: "Send Counter Offer",
                          onpreased: () async {
                            if (amount.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please enter amount",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  fontSize: 16.0);
                            } else {
                              final res = await counterQoute(
                                  orderNo,
                                  amount.text.replaceAll(",", ""),
                                  vendor_phone,
                                  context);
                              if (res['status']) {
                                // Navigator.of(context).pop();
                                popup(context,
                                    success: true,
                                    color: Constants.Primary,
                                    title: "Offer Countered!",
                                    message: res['message']);
                              } else {
                                // Navigator.of(context).pop();
                                popup(context,
                                    success: false,
                                    title: "Error Countering Offer!",
                                    message: res['error']);
                              }
                            }
                          },
                          outlinebtn: false),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ));
}

String formNum(String s) {
  return NumberFormat.decimalPattern().format(
    int.parse(s),
  );
}

void popup(context,
    {success = true,
    color = null,
    title = "Offer Rejected !",
    message =
        "You have rejected the offer. Your order details are saved in your profile."}) {
  //TextEditingController amount = TextEditingController();
  showModalBottomSheet(
      context: context,
      builder: (BuildContext buildcontext) {
        return SingleChildScrollView(
          child: SafeArea(
            child: Container(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  success
                      ? Icon(FontAwesomeIcons.solidCheckCircle,
                          size: 64, color: (color ?? Constants.BrightRed))
                      : Icon(FontAwesomeIcons.solidTimesCircle,
                          size: 64, color: Constants.BrightRed),
                  Text(
                    title,
                    style:
                        Constants.heading2.copyWith(color: Constants.Primary),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    message,
                    style: Constants.regular4.copyWith(color: Constants.Grey),
                    textAlign: TextAlign.center,
                  ),
                  CustomBtn(
                      text: "Done",
                      onpreased: () {
                        // (title.contains('Reject') || title.contains('Counter'))
                        //     ? Get.to(MyOffers())
                        //     : Get.to(MyDeliveries());
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyOffers()));
                        //print("HH");
                      },
                      outlinebtn: false)
                ],
              ),
            )),
          ),
        );
      });
}
