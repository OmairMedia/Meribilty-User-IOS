import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/transit/subordercard.dart';

import '../location.dart';

class WaitingForAdminApproval extends StatefulWidget {
  const WaitingForAdminApproval({ 
    Key? key,
    required this.data,
    required this.colored,
    required this.status,
   }) : super(key: key);
   final data;
   final colored;
   final status;

  @override
  State<WaitingForAdminApproval> createState() => _WaitingForAdminApprovalState();
}

class _WaitingForAdminApprovalState extends State<WaitingForAdminApproval> {
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
                        style: Constants.regular4,
                      ),
                    )
                  ],
                ),
                ListView.builder(
                    itemCount: widget.data['bilty'].length,
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
                                image: "${(widget.data ?? const {})['bilty'][i]['image']}",

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
                                  itemCount:(widget.data ?? const {})['bilty'][i]['loading_options'] == null ? 0
                                          : (widget.data ?? const {})['bilty'][i]['loading_options'].length,
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
                                      image: "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['image']}",

                                    ));
                                  }),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount:(widget.data ?? const {})['bilty'][i]['unloading_options'] ==null? 0
                                          : (widget.data ?? const {})['bilty'][i]['unloading_options'].length,
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
                                          image: "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['image']}",
                                    ));
                                  }),
                            ],
                          )),
                        ));
                      } else {
                        return SizedBox();
                      }
                    }),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          style: Constants.heading4.copyWith(fontSize: 14),
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
                             widget.data['type'].toString().toLowerCase()=="upcountry"?"Nationwide": "${widget.data['type']}".capitalize(),
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
                              "Rs ${(widget.data ?? const {})['amount'] ??(widget.data ?? const {})['vendor_counter']['amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
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