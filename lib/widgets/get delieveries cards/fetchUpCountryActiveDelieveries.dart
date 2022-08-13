import 'package:flutter/material.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/upcountry/get_up_active_orders.dart';
import 'package:meribiltyapp/widgets/upcountry/delivery_card.dart';

class FetchUpCountryActiveDelieveries extends StatefulWidget {
  const FetchUpCountryActiveDelieveries({Key? key}) : super(key: key);

  @override
  State<FetchUpCountryActiveDelieveries> createState() =>
      _FetchUpCountryActiveDelieveriesState();
}

class _FetchUpCountryActiveDelieveriesState
    extends State<FetchUpCountryActiveDelieveries> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchUpActiveDeliveries(),
        builder: (context, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.none ||
              !snap.hasData ) {
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
