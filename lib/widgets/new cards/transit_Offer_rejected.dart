import 'package:flutter/material.dart';
import 'package:meribiltyapp/config/constants.dart';

import '../../Api Services/deliveries/transit/get_vendor_qoutes.dart';
import '../transit/offerrejected.dart';

class TransitOfferRejected extends StatefulWidget {
  const TransitOfferRejected({ Key? key }) : super(key: key);

  @override
  State<TransitOfferRejected> createState() => _TransitOfferRejectedState();
}

class _TransitOfferRejectedState extends State<TransitOfferRejected> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:FutureBuilder(
            future: fetchQoutedDeliveries(),
            builder: (context, AsyncSnapshot snap) {
              if (snap.connectionState == ConnectionState.none ||
                  !snap.hasData ) {
                return Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.37),
                   // Center(child: CircularProgressIndicator(color: Constants.Primary,)),
                  ],
                );
              } else if (snap.hasError) {
                return Center(child: Text('Try reloading Offer recieved'));
              } else if (snap.hasData) {
                return Column(
                  children: [
                    (snap.data['rejected']?.length != 0)
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: snap.data['rejected']!=null?snap.data['rejected']?.length:0,
                            itemBuilder: (BuildContext context, int i) {
                              return OfferRejected(
                                  status: 'Offer Rejected',
                                  colored: Constants.BrightRed,
                                  data: snap.data['rejected']?[i]);
                            },
                          )
                        : Padding(padding: EdgeInsets.only(top: 0)),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator(color: Colors.red,));
              }
            }),
    );
  }
}