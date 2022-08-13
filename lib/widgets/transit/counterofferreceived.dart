import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meribiltyapp/Api%20Services/ppl/transit/accept_counter.dart';
import 'package:meribiltyapp/Api%20Services/ppl/transit/reject_counter.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_deliveries.dart';
import 'package:meribiltyapp/screens/ppl/select_payment_method.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/custuminput.dart';
import 'package:meribiltyapp/widgets/location.dart';
import 'package:meribiltyapp/widgets/transit/subordercard.dart';
import 'package:meribiltyapp/widgets/transit/qouted_delivery_card.dart';
import 'package:meribiltyapp/widgets/upload_documents_transit.dart';
import 'package:meribiltyapp/widgets/upload_documents_upcountry.dart';

class PartnerCounterOffer extends StatefulWidget {
  final status;
  final colored;
  final data;
  const PartnerCounterOffer({
    Key? key,
    required this.status,
    required this.colored,
    required this.data,
  }) : super(key: key);

  @override
  State<PartnerCounterOffer> createState() => _PartnerCounterOfferState();
}

class _PartnerCounterOfferState extends State<PartnerCounterOffer> {
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
                              vertical: 5, horizontal: 17),
                          child: Text(
                           (widget.data ?? const {})['type'].toString().toLowerCase()=="upcountry"?"Nationwide": "${(widget.data ?? const {})['type']}".capitalize(),
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
                              "${(widget.data ?? const {})['vendor_countered_on']}",
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
                            color: widget.colored,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 17),
                            child: Text(
                              "Rs ${(widget.data ?? const {})['amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                              style: Constants.regular4
                                  .copyWith(color: Constants.White),
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
                      onPressed: (){
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
                                                   (widget.data ?? const {})['type']
                                    .toString()
                                    .toLowerCase() ==
                                "transit"
                            ? Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UploadDocumnetsTransit(
                                          orderNo: (widget.data ??
                                              const {})['orderNo'],
                                          vendorPhone:
                                              "${widget.data['vendor_phone']} ",
                                          vendorName:
                                              "${(widget.data ?? const {})['vendor_name']}",
                                          functionToRun: () {
                                            acceptCounter(
                                                (widget.data ??
                                                    const {})['orderNo'],
                                                widget.data['vendor_phone']);
                                          },
                                        )))
                            : Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => UploadDocumnetsUpcountry(
                                      vendorPhone:
                                              "${widget.data['vendor_phone']} ",
                                          vendorName:
                                              "${(widget.data ?? const {})['vendor_name']}",
                                          orderNo: (widget.data ??
                                              const {})['orderNo'],
                                          functionToRun: () {
                                            acceptCounter(
                                                (widget.data ??
                                                    const {})['orderNo'],
                                                widget.data['vendor_phone']);
                                          },
                                        )));
                                          },
                                          outlinebtn: false)
                                    ],
                                  ),
                                )),
                              ),
                            );
                          });
                          //    showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) => AlertDialog(
                          //        title: Text('Congratulations',style: Constants.heading2,),
                          //         content: Text(
                          //         "You have successfully accepted the Offer!",
                          //         style: Constants.regular4,
                          //       ),
                          //       actions: [
                          //         TextButton(onPressed: () async{
                          //                 (widget.data ?? const {})['type']
                          //           .toString()
                          //           .toLowerCase() ==
                          //       "transit"
                          //   ? Navigator.pushReplacement(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               UploadDocumnetsTransit(
                          //                 orderNo: (widget.data ??
                          //                     const {})['orderNo'],
                          //                 vendorPhone:
                          //                     "${widget.data['vendor_phone']} ",
                          //                 vendorName:
                          //                     "${(widget.data ?? const {})['vendor_name']}",
                          //                 functionToRun: () {
                          //                   acceptCounter(
                          //                       (widget.data ??
                          //                           const {})['orderNo'],
                          //                       widget.data['vendor_phone']);
                          //                 },
                          //               )))
                          //   : Navigator.pushReplacement(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (_) => UploadDocumnetsUpcountry(
                          //             vendorPhone:
                          //                     "${widget.data['vendor_phone']} ",
                          //                 vendorName:
                          //                     "${(widget.data ?? const {})['vendor_name']}",
                          //                 orderNo: (widget.data ??
                          //                     const {})['orderNo'],
                          //                 functionToRun: () {
                          //                   acceptCounter(
                          //                       (widget.data ??
                          //                           const {})['orderNo'],
                          //                       widget.data['vendor_phone']);
                          //                 },
                          //               )));
                          //         }, child: Text("Ok",style: Constants.regular3.copyWith(color: Constants.Grey),) )
                          //       ],
                          // ));
                      },
                      //  () async {
                  
                      //    },

                         //commented
                        // final res = await acceptCounter(
                        //     (widget.data ?? const {})['orderNo'],
                        //     (widget.data ?? const {})['vendor_phone']);
                        // if (res['status']) {
                        //   Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => MyDeliveries()));

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => SelectPaymentMethod(
                        //               functionToRun: (){
                        //                  acceptCounter((widget.data ?? const {})['orderNo'],
                        //     widget.data['vendor_phone']);
                        //               },
                        //               orderNo:
                        //                   (widget.data ?? const {})['orderNo'],
                        //             )));
                        //   } else {
                        //     popup(context,
                        //         success: false,
                        //         title: "Error Accepting Offer!",
                        //         message: res['error']);
                        //   }
                     
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
                        final res = await rejectCounter(
                            (widget.data ?? const {})['orderNo'],
                            (widget.data ?? const {})['vendor_phone']);
                        if (res['status']) {
                          popup(context,
                              title: "Offer Rejected!",
                              message: res['message']);
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
