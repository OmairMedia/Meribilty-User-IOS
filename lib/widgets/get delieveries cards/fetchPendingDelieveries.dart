import 'package:flutter/material.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/transit/get_counter_offers.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/transit/get_partner_counter_offers.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/transit/get_vendor_qoutes.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/transit/qouted_delivery_card.dart';

class FetchPendingDelieveries extends StatefulWidget {
  const FetchPendingDelieveries({Key? key}) : super(key: key);

  @override
  State<FetchPendingDelieveries> createState() =>
      _FetchPendingDelieveriesState();
}

class _FetchPendingDelieveriesState extends State<FetchPendingDelieveries> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      FutureBuilder(
          future: fetchQoutedDeliveries(),
          builder: (context, AsyncSnapshot snap) {
            if (snap.connectionState == ConnectionState.none ||
                !snap.hasData ) {
              return Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.37),
                  Center(child: CircularProgressIndicator(color: Constants.Primary,)),
                ],
              );
            } else if (snap.hasError) {
              return Center(child: Text(' '));
            } else if (snap.hasData) {
              return Column(
                children: [
                  ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snap.data['pending'].length,
                          itemBuilder: (BuildContext context, int i) {
                            return OfferPendingCard(
                                status: "Pending Order",
                                colored: Colors.indigo,
                                data: snap.data['pending'][i]);
                          },
                        )
                      
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator(color: Constants.Primary,));
            }
          }),
      
    ]);
  }
}
