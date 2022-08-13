import 'package:flutter/material.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/upcountry/get_up_completed_orders.dart';
import 'package:meribiltyapp/widgets/upcountry/delivery_card.dart';

class FetchUpCountryCompletedDeleiveries extends StatefulWidget {
  const FetchUpCountryCompletedDeleiveries({Key? key}) : super(key: key);

  @override
  State<FetchUpCountryCompletedDeleiveries> createState() =>
      _FetchUpCountryCompletedDeleiveriesState();
}

class _FetchUpCountryCompletedDeleiveriesState
    extends State<FetchUpCountryCompletedDeleiveries> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchUpCompletedDeliveries(),
        builder: (context, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.none &&
              snap.hasData == null) {
            return Padding(padding: EdgeInsets.only(top: 0));
          } else if (snap.hasError) {
            return Center(child: Text(' '));
          } else if (snap.hasData) {
            return Column(children: [
              (snap.data?.length != 0)
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: snap.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return UpcountryDeliveryCard(data: snap.data[i]);
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
