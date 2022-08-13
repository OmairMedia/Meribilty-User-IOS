import 'package:flutter/material.dart';

import '../../Api Services/deliveries/transit/get_counter_offers.dart';
import '../transit/qouted_delivery_card.dart';

class UserCounterAcceptedByVendor extends StatefulWidget {
  const UserCounterAcceptedByVendor({ Key? key }) : super(key: key);

  @override
  State<UserCounterAcceptedByVendor> createState() => _UserCounterAcceptedByVendorState();
}

class _UserCounterAcceptedByVendorState extends State<UserCounterAcceptedByVendor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: fetchCounteredDeliveries(),
          builder: (context, AsyncSnapshot snap) {
            if (snap.connectionState == ConnectionState.none ||
                !snap.hasData ) {
              return Center(child: SizedBox());
            } else if (snap.hasError) {
              return Center(child: Text(''));
            } else if (snap.hasData) {
              return Column(
                children: [
                  (snap.data['accepted']?.length != 0)
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snap.data['accepted'] == null  ? 0 : snap.data['accepted']?.length,
                          itemBuilder: (BuildContext context, int i) {
                            return UserCounterAcceptedByVendorCard(
                                status: "Accepted By Vendor",
                                colored: Colors.indigo,
                                data: snap.data['accepted']?[i]);
                          },
                        )
                      : Padding(padding: EdgeInsets.only(top: 0)),
                ],
              );
            } else {
              return Center(child: SizedBox());
            }
          }),
    );
  }
}