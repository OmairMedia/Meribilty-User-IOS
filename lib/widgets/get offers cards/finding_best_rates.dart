import 'package:flutter/material.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/transit/get_pending_orders.dart';
//import 'package:meribiltyapp/Api%20Services/deliveries/upcountry/get_upcountry_qoutes_n_counters.dart';
import 'package:meribiltyapp/config/constants.dart';
//import 'package:meribiltyapp/widgets/new%20cards/finding_best_rates_upcountry.dart';
import 'package:meribiltyapp/widgets/transit/findingbestrates.dart';
//import 'package:meribiltyapp/widgets/upcountry/qoutes_n_counters_card.dart';

class FindingRates extends StatefulWidget {
  const FindingRates({Key? key}) : super(key: key);

  @override
  State<FindingRates> createState() => _FindingRatesState();
}

class _FindingRatesState extends State<FindingRates> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Transit
        FutureBuilder(
            future: fetchTransitPendingDeliveries(),
            builder: (context, AsyncSnapshot snap) {
              if (snap.connectionState == ConnectionState.none ||
                  !snap.hasData) {
                return Padding(padding: EdgeInsets.only(top: 0));
              } else if (snap.hasError) {
                return Center(child: Text('Finding Best Rates Error'));
              } else if (snap.hasData) {

                return Column(children: [
                  ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: snap.data.length,
                          itemBuilder: (BuildContext context, int i) {
                            // return Text("data");
                            return FindingRatesCard(
                                status: 'Finding Best Rates',
                                colored: Constants.Primary,
                                data: snap.data[i]);
                          },
                        )

                ]);
              } else {
                return Padding(padding: EdgeInsets.only(top: 0));
              }
            }),

        // Upcountry

        // FindingBestRatesUpcountry()
      ],
    );
  }
}
