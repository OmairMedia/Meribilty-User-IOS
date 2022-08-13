import 'package:flutter/material.dart';
import 'package:meribiltyapp/Api%20Services/ppl/acceptOrder.dart';
import 'package:meribiltyapp/Api%20Services/ppl/reject_order.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/ppl/select_payment_method.dart';
import 'package:meribiltyapp/widgets/upcountry/activeorder.dart';
import 'package:meribiltyapp/widgets/upcountry/offerrecieved.dart';

class UpcountryDeliveryCard extends StatefulWidget {
  final data;

  UpcountryDeliveryCard({Key? key, required this.data}) : super(key: key);

  @override
  _UpcountryDeliveryCardState createState() => _UpcountryDeliveryCardState();
}

class _UpcountryDeliveryCardState extends State<UpcountryDeliveryCard> {
  _UpcountryDeliveryCardState();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.White,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Constants.Black, width: 1),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: Constants.White,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order No. ${(widget.data ?? const {})['orderNo']}",
                    style: Constants.regular4,
                  ),
                  Text(
                    (widget.data ?? const {})['date'],
                    style: Constants.regular4,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Constants.Primary,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 20),
                            child: Text(
                              "Upcountry",
                              style: Constants.regular3
                                  .copyWith(color: Constants.White),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: (widget.data ?? const {})['subOrders']?.length,
              itemBuilder: (BuildContext context, int i) {
                return Column(
                  children: [
                    ((widget.data ?? const {})['status'] == 'pending')
                        ? UpcountryActiveOrderCard(
                            status: 'Pending Order',
                            colored: Colors.indigo,
                            data: (widget.data ?? const {})['subOrders'][i],
                          )
                        : ((widget.data ?? const {})['status'] == 'accepted')
                            ? UpcountryActiveOrderCard(
                                status: 'Active Order',
                                colored: Colors.amber,
                                date: widget.data['date'],
                                data: (widget.data ?? const {})['subOrders'][i],
                              )
                            : ((widget.data ?? const {})['status'] ==
                                    'completed')
                                ? UpcountryActiveOrderCard(
                                    status: 'Order Completed',
                                    colored: Colors.green,
                                    data: (widget.data ?? const {})['subOrders']
                                        [i],
                                  )
                                : Padding(padding: EdgeInsets.only(top: 0))
                  ],
                );
              }),
          ((widget.data ?? const {})['status'] == 'pending')
              ? Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    children: [
                      //Accept

                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        width: MediaQuery.of(context).size.width * 0.463,
                        height: MediaQuery.of(context).size.width * 0.11,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff13DD80)),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(15)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(18)),
                                ))),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectPaymentMethod(
                                            functionToRun: () {
                                              print(
                                                  "yaha par accept wala function daydena");
                                            },
                                            orderNo: (widget.data ??
                                                const {})['orderNo'],
                                          )));
                            },
                            child: Text(
                              "Accept",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ),

                      //Rejected
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        width: MediaQuery.of(context).size.width * 0.463,
                        height: MediaQuery.of(context).size.width * 0.11,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(15)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(18)),
                                ))),
                            onPressed: () async {
                              final res = await rejectOrder(
                                  (widget.data ?? const {})['orderNo']);
                              if (res['status']) {
                                popup(context,
                                    title: "Order Rejected!",
                                    message: res['message']);
                              } else {
                                popup(context,
                                    success: false,
                                    title: "Error Rejecting Order!",
                                    message: res['error']);
                              }
                            },
                            child: Text("Reject",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                      ),
                    ],
                  ),
                )
              : Padding(padding: EdgeInsets.only(top: 0))
        ],
      ),
    );
  }
}
