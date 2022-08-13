import 'package:flutter/material.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/upcountry/get_upcountry_qoutes_n_counters.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/location.dart';

import '../upcountry/findingbestrates.dart';

class FindingBestRatesUpcountry extends StatefulWidget {
  const FindingBestRatesUpcountry({Key? key}) : super(key: key);

  @override
  State<FindingBestRatesUpcountry> createState() =>
      _FindingBestRatesUpcountryState();
}

class _FindingBestRatesUpcountryState extends State<FindingBestRatesUpcountry> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchUpCountryQoutesNCounters(),
        builder: (context, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.none || !snap.hasData) {
            return Padding(padding: EdgeInsets.only(top: 0));
          } else if (snap.hasError) {
            return Center(child: Text('Try Reloading Upcountry'));
          } else if (snap.hasData) {
            return Column(children: [
              (snap.data?.length != 0)
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: snap.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return GestureDetector(
                            onTap: () {
                              print(snap.data[i]);
                            },
                            child: Column(children: [
      
          Card(
              color: Constants.White,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Constants.Primary, width: 1),
              ),
              child: Column(
                children: [
                  
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: Constants.Primary,
                    ),
                    child: Center(
                      child: Text(
                        "Finding Best Rates",
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
                              "OrderNo:${snap.data[i]['orderNo']}",
                              style: Constants.regular4,
                            ),
                            Text(
                              "date: ${snap.data[i]['createdAt']}",
                              style: Constants.regular4,
                            )
                          ],
                        ),
                        ListView.builder(
                            itemCount:
                            snap.data[i]["subOrders"].length,
                                // (widget.data ?? const {})['bilty'].length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int i) {
                              // if ((widget.data ?? const {})['bilty'][i]
                              //         ['type'] ==
                              //     "vehicle") {
                                return (Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: ContainerDetailblue(
                                    vehicleType:
                                        "{(widget.data ?? const {})['bilty'][i]['name']}",
                                    quantity:
                                        "{(widget.data ?? const {})['bilty'][i]['quantity']}",
                                    weight:
                                        "{(widget.data ?? const {})['bilty'][i]['weight']} Tons",
                                    material:
                                        "{(widget.data ?? const {})['bilty'][i]['type']}",
                                  ),
                                ));
                              // }
                              //  else if ((widget.data ?? const {})['bilty'][i]
                              //         ['type'] ==
                              //     "loading/unloading") {
                                // return (
                                //   Container(
                                //         decoration: BoxDecoration(
                                //         color: Constants.Primary, borderRadius: BorderRadius.circular(12)),
                                //         child: (
                                //            Column(
                                //              children: [
                                //                 ListView.builder(
                                //                  shrinkWrap: true,
                                //                  physics: ScrollPhysics(),
                                //                  itemCount: (widget.data ?? const {})['bilty'][i]['loading_options'] == null ? 0 : (widget.data ?? const {})['bilty'][i]['loading_options'].length,
                                //                  itemBuilder: (context,j){
                                //                    return (
                                //                      ContainerDetailblue(
                                //                        vehicleType:
                                //                   "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['name']}",
                                //                     quantity:
                                //                   "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['quantity']}",
                                //                     weight:
                                //                   "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['weight']} Tons",
                                //                     material:
                                //                   "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['type']}",

                                //                      )
                                //                    );
                                //                  }),
                                //                  ListView.builder(
                                //                  shrinkWrap: true,
                                //                  physics: ScrollPhysics(),
                                //                  itemCount: (widget.data ?? const {})['bilty'][i]['unloading_options'] == null ? 0 : (widget.data ?? const {})['bilty'][i]['unloading_options'].length,
                                //                  itemBuilder: (context,j){
                                //                    return (
                                //                      ContainerDetailblue(
                                //                        vehicleType:
                                //                   "${(widget.data ?? const {})['bilty'][i]['unloading_options'][j]['name']}",
                                //                     quantity:
                                //                   "${(widget.data ?? const {})['bilty'][i]['unloading_options'][j]['quantity']}",
                                //                     weight:
                                //                   "${(widget.data ?? const {})['bilty'][i]['unloading_options'][j]['weight']} Tons",
                                //                     material:
                                //                   "${(widget.data ?? const {})['bilty'][i]['unloading_options'][j]['type']}",

                                //                      )
                                //                    );
                                //                  }),
                                //              ],
                                //            )
                                //         ),
                                //   )
                                //   );
                              // }
                              //  else {
                              //   return SizedBox();
                              // }
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
                                  "{(widget.data ?? const {})['disText']}",
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
                                  "{(widget.data ?? const {})['durText']}",
                                  style: Constants.heading3,
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Custom3LocationWigets(
                              pickup:
                                  'originAddress',
                              dropoff: 'destinationAddress',
                              empty: 'containerReturnAddress'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          
    ]));
                        // QoutesNCountersCard(data: snap.data[i]);
                      },
                    )
                  : Padding(padding: EdgeInsets.only(top: 0))
            ]);
          } else {
            return Padding(padding: EdgeInsets.only(top: 0));
          }
        });
  }
}
