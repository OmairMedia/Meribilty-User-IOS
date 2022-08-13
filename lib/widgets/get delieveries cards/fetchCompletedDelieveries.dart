import 'package:flutter/material.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/transit/get_completed_orders.dart';
import 'package:meribiltyapp/widgets/transit/completedorder.dart';

class FetchCompletedDelieveries extends StatefulWidget {
  const FetchCompletedDelieveries({Key? key}) : super(key: key);

  @override
  State<FetchCompletedDelieveries> createState() =>
      _FetchCompletedDelieveriesState();
}

class _FetchCompletedDelieveriesState extends State<FetchCompletedDelieveries> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchCompletedDeliveries(),
        builder: (context, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.none ||
              !snap.hasData) {
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
                        return OrderCompleted(
                            status: 'Order Completed',
                            colored: Colors.green,
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
