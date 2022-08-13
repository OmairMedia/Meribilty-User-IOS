import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/ppl/single_bilty_transitfile.dart';
import 'package:meribiltyapp/widgets/location.dart';
import 'package:meribiltyapp/widgets/transit/subordercard.dart';
import 'package:meribiltyapp/widgets/transit/qouted_delivery_card.dart';

import '../test.dart';

class ActiverOrder extends StatefulWidget {
  final status;
  final colored;
  final data;
  const ActiverOrder(
      {Key? key,
      required this.status,
      required this.colored,
      required this.data})
      : super(key: key);

  @override
  State<ActiverOrder> createState() => _ActiverOrderState();
}

class _ActiverOrderState extends State<ActiverOrder> {
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
                    itemCount: (widget.data ?? const {})['bilty'].length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int i) {
                      if ((widget.data ?? const {})['bilty'][i]['type'] ==
                          "vehicle") {
                        return (Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ContainerDetailblue(
                            vehicleType:
                                "${(widget.data ?? const {})['bilty'][i]['name']}",
                            quantity:
                                "${(widget.data ?? const {})['bilty'][i]['quantity']}",
                            weight:
                                "${(widget.data ?? const {})['bilty'][i]['weight']} Tons",
                            material:
                                "${(widget.data ?? const {})['bilty'][i]['material']}",
                            image:
                                "${(widget.data ?? const {})['bilty'][i]['image']}",
                          ),
                        ));
                      } else if ((widget.data ?? const {})['bilty'][i]
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
                                  itemCount: (widget.data ?? const {})['bilty']
                                              [i]['loading_options'] ==
                                          null
                                      ? 0
                                      : (widget.data ?? const {})['bilty'][i]
                                              ['loading_options']
                                          .length,
                                  itemBuilder: (context, j) {
                                    return (ContainerDetailblueLoading_UnLoading(
                                      vehicleType:
                                          "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['name']}",
                                      quantity:
                                          "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['quantity']}",
                                      weight:
                                          "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['weight']} Tons",
                                      material:
                                          "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['type']}",
                                      image:
                                          "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['image']}",
                                    ));
                                  }),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: (widget.data ?? const {})['bilty']
                                              [i]['unloading_options'] ==
                                          null
                                      ? 0
                                      : (widget.data ?? const {})['bilty'][i]
                                              ['unloading_options']
                                          .length,
                                  itemBuilder: (context, j) {
                                    return (ContainerDetailblueLoading_UnLoading(
                                      vehicleType:
                                          "${(widget.data ?? const {})['bilty'][i]['unloading_options'][j]['name']}",
                                      quantity:
                                          "${(widget.data ?? const {})['bilty'][i]['unloading_options'][j]['quantity']}",
                                      weight:
                                          "${(widget.data ?? const {})['bilty'][i]['unloading_options'][j]['weight']} Tons",
                                      material:
                                          "${(widget.data ?? const {})['bilty'][i]['unloading_options'][j]['type']}",
                                      image:
                                          "${(widget.data ?? const {})['bilty'][i]['unloading_options'][j]['image']}",
                                    ));
                                  }),
                            ],
                          )),
                        ));
                      } else {
                        return SizedBox();
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Constants.Primary,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                              (widget.data ?? const {})['type']
                                          .toString()
                                          .toLowerCase() ==
                                      "upcountry"
                                  ? "Nationwide"
                                  : "${(widget.data ?? const {})['type']}"
                                      .capitalize(),
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
                                style:
                                    Constants.heading3.copyWith(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Pickup Time ",
                      style: Constants.regular4,
                    ),
                    Text(
                      "${(widget.data ?? const {})['createdAt']}",
                      style: Constants.heading3.copyWith(fontSize: 15),
                    )
                  ],
                ),
                Custom3LocationWigets(
                    pickup: (widget.data ?? const {})['originAddress'],
                    dropoff: (widget.data ?? const {})['destinationAddress'],
                    empty: (widget.data ?? const {})['containerReturnAddress']),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 60,
                        //width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                        ),
                        child: TextButton(
                            onPressed: () {
                  //             Navigator.of(context).push(MaterialPageRoute(
                  //            builder: (_) =>
                  // MapSample()));   
                              showAllBilties(context, (widget.data ?? const {})['bilty'],"${widget.data['orderNo']}",
                                  (widget.data ?? const {})['date'], "${(widget.data ?? const {})['type']}",
                                  (widget.data ?? const {})['orgLat'],
                                  (widget.data ?? const {})['orgLng'],
                                  (widget.data ?? const {})['desLat'],
                                  (widget.data ?? const {})['desLng']);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 17),
                                  child: Text(
                                    "Meribilty",
                                    style: Constants.regular3
                                        .copyWith(color: Constants.White),
                                  ),
                                )))),
                    Container(
                        decoration: BoxDecoration(
                          color: Constants.Grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 17),
                          child: Text(
                            "Rs ${(widget.data ?? const {})['qoute']?['qoute_amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') ?? (widget.data ?? const {})['user_counter']?['amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') ?? (widget.data ?? const {})['vendor_counter']?['amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                            style: Constants.regular4
                                .copyWith(color: Constants.Black),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),

          // ElevatedButton(
          //     onPressed: () {
          //       print((widget.data ?? const {})['bilty'][0]['biltyNo']);
          //     },
          //     child: Text("child"))
        ],
      ),
    );
  }
}
