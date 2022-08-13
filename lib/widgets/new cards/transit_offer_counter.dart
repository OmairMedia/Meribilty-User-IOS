import 'package:flutter/material.dart';

import '../../Api Services/deliveries/transit/get_counter_offers.dart';
import '../transit/offerrejected.dart';

class CounteredByUserSent extends StatefulWidget {
  const CounteredByUserSent({ Key? key }) : super(key: key);

  @override
  State<CounteredByUserSent> createState() => _CounteredByUserSentState();
}

class _CounteredByUserSentState extends State<CounteredByUserSent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  FutureBuilder(
            future: fetchCounteredDeliveries(),
            builder: (context, AsyncSnapshot snap) {
              if (snap.connectionState == ConnectionState.none ||
                  !snap.hasData) {
                return Center(child: SizedBox());
              } else if (snap.hasError) {
                return Center(child: Text('Try Reloading Offer sent'));
              } else if (snap.hasData) {
                return Column(children: [
                  (snap.data['data']?.length != 0)
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snap.data['data']?.length,
                          itemBuilder: (BuildContext context, int i) {
                            return OfferCounterByUser(
                                status: 'Counter Offer Sent',
                                colored: Colors.purple,
                                data: snap.data['data']?[i]);
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