import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/location.dart';
import 'package:meribiltyapp/widgets/transit/subordercard.dart';

class OfferRejected extends StatefulWidget {
  final status;
  final colored;
  final data;
  const OfferRejected({
    Key? key,
    required this.status,
    required this.colored,
    required this.data,
  }) : super(key: key);

  @override
  State<OfferRejected> createState() => _OfferRejectedState();
}

class _OfferRejectedState extends State<OfferRejected> {
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
                    itemCount: (widget.data ?? const {})['bilties'] == null
                        ? 0
                        : (widget.data ?? const {})['bilties'].length,
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
                              "${ (widget.data ?? const {})['type']}",
                              style: Constants.regular4
                                  .copyWith(color: Constants.White),
                            ),
                          )),
                    Spacer(),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              "${(widget.data ?? const {})['durText']}",
                              style: Constants.heading4,
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
                    empty:
                        (widget.data ?? const {})['containerReturnAddress']),
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
                              widget.data['qoute_amount'] != null
                                  ? "Rs ${widget.data['qoute_amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}"
                                  : "Rs ${widget.data['amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                              // "Rs ${(widget.data ?? const {})['qoute_amount'] ?? (widget.data ?? const {})['amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
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
        ],
      ),
    );
  }
}

class OfferCounterByUser extends StatefulWidget {
  final status;
  final colored;
  final data;
  const OfferCounterByUser({
    Key? key,
    required this.status,
    required this.colored,
    required this.data,
  }) : super(key: key);

  @override
  State<OfferCounterByUser> createState() => _OfferCounterByUserState();
}

class _OfferCounterByUserState extends State<OfferCounterByUser> {
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
                    itemCount: (widget.data ?? const {})['bilties'] == null ? 0 : (widget.data ?? const {})['bilties'].length,
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
                            (widget.data ?? const {})['request_type'].toString().toLowerCase()=="upcountry"? "Nationwide" :  "${(widget.data ?? const {})['request_type']}".capitalize(),
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
                    empty:
                        (widget.data ?? const {})['containerReturnAddress']),
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
                            child: InkWell(
                              child: Text(
                                "Rs ${(widget.data ?? const {})['qoute_amount'] ?? (widget.data ?? const {})['amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                                style: Constants.regular4
                                    .copyWith(color: Constants.Black),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
