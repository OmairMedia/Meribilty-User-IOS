import 'package:flutter/material.dart';

import '../../Api Services/deliveries/transit/get_partner_counter_offers.dart';
import '../transit/counterofferreceived.dart';

class CounteredByVendorRecieved extends StatefulWidget {
  const CounteredByVendorRecieved({ Key? key }) : super(key: key);

  @override
  State<CounteredByVendorRecieved> createState() => _CounteredByVendorRecievedState();
}

class _CounteredByVendorRecievedState extends State<CounteredByVendorRecieved> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
            future: fetchVendorCounteredDeliveries(),
            builder: (context, AsyncSnapshot snap) {
              if (snap.connectionState == ConnectionState.none ||
                  !snap.hasData) {
                return Center(child: SizedBox());
              } else if (snap.hasError) {
                return Center(child: Text('Try Reloading Counter Offer'));
              } else if (snap.hasData) {
                return Column(children: [
                  (snap.data['pending']?.length != 0)
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snap.data['pending'].length,
                          itemBuilder: (BuildContext context, int i) {
                            return PartnerCounterOffer(
                                status: 'Partner Counter Offer Recieved',
                                colored: Colors.purple,
                                data: snap.data['pending'][i]);
                          },
                        )
                      : Padding(padding: EdgeInsets.only(top: 0))
                ]);
              } else {
                return Padding(padding: EdgeInsets.only(top: 0));
              }
            }),
    );
  }
}