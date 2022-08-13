import 'package:flutter/material.dart';
import 'package:meribiltyapp/widgets/transit/qouted_delivery_card.dart';

import '../../Api Services/deliveries/transit/get_vendor_qoutes.dart';
import '../../config/constants.dart';

class TransitOfferRecieved extends StatefulWidget {
  const TransitOfferRecieved({ Key? key }) : super(key: key);

  @override
  State<TransitOfferRecieved> createState() => _TransitOfferRecievedState();
}

class _TransitOfferRecievedState extends State<TransitOfferRecieved> {
  @override
  Widget build(BuildContext context) {
    return Container(
       //Offer Recieved & Offer Rejected
        child:FutureBuilder(
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
                return Center(child: Text('Try reloading Offer recieved'));
              } else if (snap.hasData) {
                return Column(
                  children: [
                    (snap.data['pending']?.length != 0)
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: snap.data['pending']?.length,
                            itemBuilder: (BuildContext context, int i) {
                              return OfferRecievedCard(
                                  status: 'Offer Recieved',
                                  colored: Colors.blue,
                                  data: snap.data['pending']?[i]);
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