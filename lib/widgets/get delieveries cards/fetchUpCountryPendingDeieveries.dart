import 'package:flutter/material.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/upcountry/get_up_pending_orders.dart';
import 'package:meribiltyapp/widgets/upcountry/delivery_card.dart';

class FetchUpCountryPendingDelieveries extends StatefulWidget {
  const FetchUpCountryPendingDelieveries({Key? key}) : super(key: key);

  @override
  State<FetchUpCountryPendingDelieveries> createState() =>
      _FetchUpCountryPendingDelieveriesState();
}

class _FetchUpCountryPendingDelieveriesState
    extends State<FetchUpCountryPendingDelieveries> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchUpPendingDeliveries(),
        builder: (context, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.none &&
              snap.hasData ) {
            return Padding(padding: EdgeInsets.only(top: 0));
          } else if (snap.hasError) {
            return Center(child: Text(' '));
          } else if (snap.hasData) {
            return Column(children: [
              ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: snap.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return UpcountryDeliveryCard(data: snap.data[i]);
                      },
                    )
                  
            ]);
          } else {
            return Padding(padding: EdgeInsets.only(top: 0));
          }
        });
  }
}
