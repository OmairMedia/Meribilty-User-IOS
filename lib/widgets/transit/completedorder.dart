import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meribiltyapp/Api%20Services/pdf_for_invoice.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/drawer_pages/rating_user.dart';
import 'package:meribiltyapp/widgets/location.dart';
import 'package:meribiltyapp/widgets/transit/qouted_delivery_card.dart';
import 'package:meribiltyapp/widgets/transit/subordercard.dart';
import 'package:meribiltyapp/widgets/transit/qouted_delivery_card.dart';
class OrderCompleted extends StatefulWidget {
  final status;
  final colored;
  final data;
  const OrderCompleted(
      {Key? key,
      required this.status,
      required this.colored,
      required this.data})
      : super(key: key);

  @override
  State<OrderCompleted> createState() => _OrderCompletedState();
}

class _OrderCompletedState extends State<OrderCompleted> {
  var invoiceData;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.White,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: widget.colored, width: 1),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: widget.colored,
            ),
            child: Center(
              child: Text(
                "${widget.status}",
                style: Constants.regular4.copyWith(color: Constants.White),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order#${(widget.data ?? const {})['orderNo']}",
                      style: Constants.regular4,
                    ),
                    Text(
                      "${DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse((widget.data ?? const {})['date']))}",
                      style: Constants.regular4,
                    )
                  ],
                ),
                ListView.builder(
                    itemCount: (widget.data ?? const {})['bilty'].length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int i) {
                      if ((widget.data ?? const {})['bilty'][i]['type'] ==
                          "vehicle") {
                        return (Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ContainerDetailblue(
                            vehicleType:
                                "${(widget.data ?? const {})['bilty'][i]['name']}",
                            quantity:
                                "${(widget.data ?? const {})['bilty'][i]['quantity']}",
                            weight:
                                "${(widget.data ?? const {})['bilty'][i]['weight']} Tons",
                            material:
                                "${(widget.data ?? const {})['bilty'][i]['material']}",
                            image:
                                "${(widget.data ?? const {})['bilty'][i]['image']}",
                          ),
                        ));
                      } else if ((widget.data ?? const {})['bilty'][i]
                              ['type'] ==
                          "loading/unloading") {
                        return (Container(
                          decoration: BoxDecoration(
                              color: Constants.Primary,
                              borderRadius: BorderRadius.circular(12)),
                          child: (Column(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: (widget.data ?? const {})['bilty']
                                              [i]['loading_options'] ==
                                          null
                                      ? 0
                                      : (widget.data ?? const {})['bilty'][i]
                                              ['loading_options']
                                          .length,
                                  itemBuilder: (context, j) {
                                    return (ContainerDetailblueLoading_UnLoading(
                                      vehicleType:
                                          "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['name']}",
                                      quantity:
                                          "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['quantity']}",
                                      weight:
                                          "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['weight']} Tons",
                                      material:
                                          "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['type']}",
                                      image:
                                          "${(widget.data ?? const {})['bilty'][i]['loading_options'][j]['image']}",
                                    ));
                                  }),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: (widget.data ?? const {})['bilty']
                                              [i]['unloading_options'] ==
                                          null
                                      ? 0
                                      : (widget.data ?? const {})['bilty'][i]
                                              ['unloading_options']
                                          .length,
                                  itemBuilder: (context, j) {
                                    return (ContainerDetailblueLoading_UnLoading(
                                      vehicleType:
                                          "${(widget.data ?? const {})['bilty'][i]['unloading_options'][j]['name']}",
                                      quantity:
                                          "${(widget.data ?? const {})['bilty'][i]['unloading_options'][j]['quantity']}",
                                      weight:
                                          "${(widget.data ?? const {})['bilty'][i]['unloading_options'][j]['weight']} Tons",
                                      material:
                                          "${(widget.data ?? const {})['bilty'][i]['unloading_options'][j]['type']}",
                                      image:
                                          "${(widget.data ?? const {})['bilty'][i]['unloading_options'][j]['image']}",
                                    ));
                                  }),
                            ],
                          )),
                        ));
                      } else {
                        return SizedBox();
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Row(
                    children: [
                       Container(
                          decoration: BoxDecoration(
                              color: Constants.Primary,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 10),
                            child: Text(
                              (widget.data ?? const {})['type'].toString().toLowerCase() == "upcountry" ? "Nationwide" :
                              "${(widget.data ?? const {})['type']}".capitalize(),
                              style: Constants.regular4
                                  .copyWith(color: Constants.White),
                            ),
                          )),
                      Spacer(),
                      Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Distance: ",
                                style: Constants.regular4,

                              ),
                              Text(
                                "${(widget.data ?? const {})['disText']}",
                                style: Constants.heading3.copyWith(fontSize: 15),
                              ),
                            ],
                          ),
                          
                        ],
                      ),
                    ],
                  ),
                ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Pickup Time: ",
                              style: Constants.regular4,
                            ),
                            Text(
                              "${(widget.data ?? const {})['createdAt']}",
                              style: Constants.heading3.copyWith(fontSize: 15),
                            )
                          ],
                        ),
                Custom3LocationWigets(
                    pickup: (widget.data ?? const {})['originAddress'],
                    dropoff: (widget.data ?? const {})['destinationAddress'],
                    empty:
                        (widget.data ?? const {})['containerReturnAddress']),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   ElevatedButton.icon(
              onPressed: () async {
                List weightList = [];
                print((widget.data ?? const {})['bilty'].length);
                (widget.data ?? const {})['bilty'].forEach((val) {
                  if (val['weight'] != null) {
                    weightList.add(val['weight']);
                  }
                });
                await getInvoiceData((widget.data ?? const {})['orderNo'])
                    .then((value) {
                  setState(() {
                    invoiceData = value;
                  });
                  print(invoiceData);
                });
                downloadOrderInvoice(
                     fuelAndOther:
                        "${invoiceData['data']['user']['fuelAndOtherCharges']}",
                     customerId:
                          "${invoiceData['data']['user']['Customer ID']}",
                      origin: 
                          "${invoiceData['data']['user']['From (Origin)']}",
                      vehicleRegistration:
                        "${invoiceData['data']['user']['Vehicle Registrations']}" ,
                      vehicleType:
                        "${invoiceData['data']['user']['Vehicle Types']}" ,
                      insurance: 
                        "${invoiceData['data']['user']['Cargo Insurance']}",
                      invoiceAmount: 
                        "${invoiceData['data']['user']['fuelAndOtherCharges']}",
                      salesTax: 
                        "${invoiceData['data']['user']['salesTax']}",
                      serviceCharges: 
                        "${invoiceData['data']['user']['serviceCharges']}",
                      totalInWords: 
                        "${invoiceData['data']['user']['totalInWords']}",
                      destination:
                          "${invoiceData['data']['user']['To: (Destination)']}",
                      sender:
                          "${invoiceData['data']['user']['Sender Name']}",
                      senderAddress:
                          "${invoiceData['data']['user']['Sender Address']}",
                      receiver:
                          "${invoiceData['data']['user']['Receiver Name']}",
                      invoiceNo:
                          "${invoiceData['data']['user']['Invoice Number']}",
                      bookingNumber:
                          "${invoiceData['data']['user']['Booking Number']}",
                      date:
                          "${invoiceData['data']['user']['Date']}",
                      material:
                          "${invoiceData['data']['user']['Materials']}",
                      weight:
                          "${invoiceData['data']['user']['Weights']}",
                      amount:
                          "${invoiceData['data']['user']['total']}",
                  
                      recieverAddress:
                          "${invoiceData['data']['user']['Receiver Address']}",

                    	);
              },
              icon: Icon(FontAwesomeIcons.fileDownload),
              label: Text("Invoice"),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green.shade900),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                            color: Colors.green.shade900,
                          ))))),
                          InkWell(
                     child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green.shade900,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 17),
                            child: Text(
                              "Meribilty",
                              style: TextStyle(
                                  color: Colors.white,
                                  ),
                            ),
                          )),
                          onTap: (){
                            showAllBilties(context, (widget.data ?? const {})['bilty'],"${widget.data['orderNo']}",
                      (widget.data ?? const {})['date'], "${(widget.data ?? const {})['type']}",
                      (widget.data ?? const {})['orgLat'],
                      (widget.data ?? const {})['orgLng'],
                      (widget.data ?? const {})['desLat'],
                      (widget.data ?? const {})['desLng']);
                            
                           
                          },
                   ),
                   InkWell(
                     child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green.shade900,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 17),
                            child: Text(
                              "Give Rating",
                              style: TextStyle(
                                  color: Colors.white,
                                  ),
                            ),
                          )),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_) => ratings_user(
                              orderNo: (widget.data)['orderNo'],
                              vendorName: (widget.data)['name'],
                            )));
                          },
                   ),
                  ],
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                    Container(
                            decoration: BoxDecoration(
                              color: Constants.Grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 17),
                              child: Text(
                                "Rs ${((widget.data ?? const {})['amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'))}",
                                style: Constants.regular4
                                    .copyWith(color: Constants.Black),
                              ),
                            )),
                   ],
                 ),
                        SizedBox(height: 10,),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
