import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/location.dart';
import 'package:meribiltyapp/widgets/transit/subordercard.dart';

class FindingRatesCard extends StatefulWidget {
  final status;
  final colored;
  final data;
  const FindingRatesCard({
    Key? key,
    required this.status,
    required this.colored,
    required this.data,
  }) : super(key: key);

  @override
  State<FindingRatesCard> createState() => _FindingRatesCardState();
}

class _FindingRatesCardState extends State<FindingRatesCard> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // ((widget.data ?? const {})['request_type'] == 'transit') ?
          
           Card(
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
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: widget.colored,
                    ),
                    child: Center(
                      child: Text(
                        "${widget.status}",
                        style:
                            Constants.regular4.copyWith(color: Constants.White),
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
                              "OrderNo# ${(widget.data ?? const {})['orderNo']}",
                              style: Constants.regular4,
                            ),
                            Text(
                              "${DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse((widget.data ?? const {})['date']))}",
                              // '${DateTime.parse((widget.data ?? const {})['date']).day}/${DateTime.parse((widget.data ?? const {})['date']).month}/${DateTime.parse((widget.data ?? const {})['date']).year}-${DateTime.parse((widget.data ?? const {})['date']).hour}:${DateTime.parse((widget.data ?? const {})['date']).minute}0',
                              // "${DateFormat('dd/MM/YYYY hh:mm a').format((widget.data ?? const {})['date']!)}",
                              // "${(widget.data ?? const {})['date']}",
                              style: Constants.regular4,
                            )
                          ],
                        ),
                        ListView.builder(
                            itemCount:
                                (widget.data ?? const {})['bilty'].length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int i) {
                              if ((widget.data ?? const {})['bilty'][i]
                                      ['type'] ==
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
                                return (
                                  Container(
                                        decoration: BoxDecoration(
                                        color: Constants.Primary, borderRadius: BorderRadius.circular(12)),
                                        child: (
                                           Column(
                                             children: [
                                                ListView.builder(
                                                 shrinkWrap: true,
                                                 physics: ScrollPhysics(),
                                                 itemCount: (widget.data ?? const {})['bilty'][i]['loading_options'] == null ? 0 : (widget.data ?? const {})['bilty'][i]['loading_options'].length,
                                                 itemBuilder: (context,j){
                                                   return (
                                                     ContainerDetailblueLoading_UnLoading(
                                                       vehicleType:
                                                  "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['name']}",
                                                    quantity:
                                                  "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['quantity']}",
                                                    weight:
                                                  "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['weight']} Tons",
                                                    material:
                                                  "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['type']}",
                                                    image: "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['image']}",

                                                     )
                                                   );
                                                 }),
                                                 ListView.builder(
                                                 shrinkWrap: true,
                                                 physics: ScrollPhysics(),
                                                 itemCount: (widget.data ?? const {})['bilty'][i]['unloading_options'] == null ? 0 : (widget.data ?? const {})['bilty'][i]['unloading_options'].length,
                                                 itemBuilder: (context,j){
                                                   return (
                                                     ContainerDetailblueLoading_UnLoading(
                                                       vehicleType:
                                                  "${(widget.data ?? const {})['bilty'][i]['unloading_options'][j]['name']}",
                                                    quantity:
                                                  "${(widget.data ?? const {})['bilty'][i]['unloading_options'][j]['quantity']}",
                                                    weight:
                                                  "${(widget.data ?? const {})['bilty'][i]['unloading_options'][j]['weight']} Tons",
                                                    material:
                                                  "${(widget.data ?? const {})['bilty'][i]['unloading_options'][j]['type']}",
                                                    image: "${(widget.data ?? const {})['bilty'][i]['unloading_options'][j]['image']}",

                                                     )
                                                   );
                                                 }),
                                             ],
                                           )
                                        ),
                                  )
                                  );
                              }
                               else {
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
                              vertical: 3, horizontal: 15),
                          child: Text(
                           widget.data['type'].toString().toLowerCase()=="upcountry"? "Nationwide": "${widget.data['type']}".capitalize(),
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
                                
                              ],
                            ),
                          ],
                        ),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Pickup Time ",
                                      style: Constants.regular4,
                                    ),
                                    Text(
                                      "${(widget.data ?? const {})['createdAt']}",
                                      style: Constants.heading4,
                                    )
                                  ],
                                ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Custom3LocationWigets(
                              pickup:
                                  (widget.data ?? const {})['originAddress'],
                              dropoff: (widget.data ??
                                  const {})['destinationAddress'],
                              empty: (widget.data ??
                                  const {})['containerReturnAddress']),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          // : Padding(padding: EdgeInsets.only(top: 0))
    ]);
  }
}
