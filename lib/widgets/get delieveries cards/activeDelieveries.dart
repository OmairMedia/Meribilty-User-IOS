import 'package:flutter/material.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/transit/get_active_orders.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/transit/activeorder.dart';

class FetchActiveDelieveries extends StatefulWidget {
  const FetchActiveDelieveries({Key? key}) : super(key: key);

  @override
  State<FetchActiveDelieveries> createState() => _FetchActiveDelieveriesState();
}

class _FetchActiveDelieveriesState extends State<FetchActiveDelieveries> {
  @override 
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchActiveDeliveries(),
        builder: (context, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.none ||
              !snap.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical:300.0),
              child: CircularProgressIndicator(color: Constants.Primary,),
            );
          } else if (snap.hasError) {
            return Center(child: CircularProgressIndicator());
          } else if (snap.hasData) {
            return Column(children: [
              (snap.data?.length != 0)
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: snap.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return ActiverOrder(
                            status: 'Active Order',
                            colored: Colors.amber,
                            data: snap.data[i]);
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
