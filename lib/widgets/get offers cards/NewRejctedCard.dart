import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/constants.dart';
import '../location.dart';
import '../transit/subordercard.dart';

import 'dart:convert';

import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:http/http.dart' as http;

Future AllRejectedDeliveries() async {
  var headers = {'Content-Type': 'application/json'};

  Uri apiurl =
      Uri.parse("https://staging-api.meribilty.com/api/get_user_rejected_orders");
  var response = await http.Client().post(apiurl,
      headers: headers, body: json.encode({"token": box.read('token')}));
  if (response.statusCode == 200) {
    var body = json.decode(response.body);
    //print("Successfully fetched orders");
    // print(body['transit']['data'].length);
    return body['transit']['data'];
  } else {
    throw Exception('Failed to load orders');
  }
}


class Recjected_All extends StatefulWidget {
  const Recjected_All({ Key? key }) : super(key: key);

  @override
  State<Recjected_All> createState() => _Recjected_AllState();
}

class _Recjected_AllState extends State<Recjected_All> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Transit
        FutureBuilder(
            future:AllRejectedDeliveries(),
            builder: (context, AsyncSnapshot Snapshot) {
              if (Snapshot.connectionState == ConnectionState.none ||
                  !Snapshot.hasData) {
                return Padding(padding: EdgeInsets.only(top: 0));
              } else if (Snapshot.hasError) {
                return Center(child: Text('Rejected Error'));
              } else if (Snapshot.hasData) {

                return Column(
                  children: [
                  ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: Snapshot.data.length == null ? 0 : Snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
           Card(
              color: Constants.White,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Constants.BrightRed, width: 1),
              ),
              child: Column(
                children: [
                  
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: Constants.BrightRed,
                    ),
                    child: Center(
                      child: Text(
                        "Offer Rejected",
                        style:
                            Constants.regular4.copyWith(color: Constants.White),
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
                              "OrderNo# ${Snapshot.data[index]['orderNo']}",
                              style: Constants.regular4,
                            ),
                            Text(
                              "${DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(Snapshot.data[index]['date']))}",
                             style: Constants.regular4,
                            )
                          ],
                        ),
                        ListView.builder(
                            itemCount:
                                Snapshot.data[index]['bilty'].length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int i) {
                              if (Snapshot.data[index]['bilty'][i]
                                      ['type'] ==
                                  "vehicle") {
                                return (Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: ContainerDetailblue(
                                    vehicleType:
                                        "${Snapshot.data[index]['bilty'][i]['name']}",
                                    quantity:
                                        "${Snapshot.data[index]['bilty'][i]['quantity']}",
                                    weight:
                                        "${Snapshot.data[index]['bilty'][i]['weight']} Tons",
                                    material:
                                        "${Snapshot.data[index]['bilty'][i]['material']}",
                                        image: "${Snapshot.data[index]['bilty'][i]['image']}",
                                  ),
                                ));
                              } 
                              else if (Snapshot.data[index]['bilty'][i]
                                      ['type'] ==
                                  "loading/unloading") {
                                return (
                                  Container(
                                        decoration: BoxDecoration(
                                        color: Constants.Primary, borderRadius: BorderRadius.circular(12)),
                                        child: (
                                           Column(
                                             children: [
                                                ListView.builder(
                                                 shrinkWrap: true,
                                                 physics: ScrollPhysics(),
                                                 itemCount: Snapshot.data[index]['bilty'][i]['loading_options'] == null ? 0 : Snapshot.data[index]['bilty'][i]['loading_options'].length,
                                                 itemBuilder: (context,j){
                                                   return (
                                                     ContainerDetailblueLoading_UnLoading(
                                                       vehicleType:
                                                  "${Snapshot.data[index]['bilty'][i]['loading_options'][j]['name']}",
                                                    quantity:
                                                  "${Snapshot.data[index]['bilty'][i]['loading_options'][j]['quantity']}",
                                                    weight:
                                                  "${Snapshot.data[index]['bilty'][i]['loading_options'][j]['weight']} Tons",
                                                    material:
                                                  "${Snapshot.data[index]['bilty'][i]['loading_options'][j]['type']}",
                                                    image: "${Snapshot.data[index]['bilty'][i]['loading_options'][j]['image']}",

                                                     )
                                                   );
                                                 }),
                                                 ListView.builder(
                                                 shrinkWrap: true,
                                                 physics: ScrollPhysics(),
                                                 itemCount: Snapshot.data[index]['bilty'][i]['unloading_options'] == null ? 0 : Snapshot.data[index]['bilty'][i]['unloading_options'].length,
                                                 itemBuilder: (context,j){
                                                   return (
                                                     ContainerDetailblueLoading_UnLoading(
                                                       vehicleType:
                                                  "${Snapshot.data[index]['bilty'][i]['unloading_options'][j]['name']}",
                                                    quantity:
                                                  "${Snapshot.data[index]['bilty'][i]['unloading_options'][j]['quantity']}",
                                                    weight:
                                                  "${Snapshot.data[index]['bilty'][i]['unloading_options'][j]['weight']} Tons",
                                                    material:
                                                  "${Snapshot.data[index]['bilty'][i]['unloading_options'][j]['type']}",
                                                    image: "${Snapshot.data[index]['bilty'][i]['unloading_options'][j]['image']}",

                                                     )
                                                   );
                                                 }),
                                             ],
                                           )
                                        ),
                                  )
                                  );
                              }
                               else {
                                return SizedBox();
                              }
                            }),
                        Row(
                          children: [
                               Container(
                        decoration: BoxDecoration(
                            color: Constants.Primary,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 17),
                          child: Text(
                           Snapshot.data[index]['type'].toString().toLowerCase()=="upcountry"?"Nationwide":"${Snapshot.data[index]['type']}".capitalize(),
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
                                      "Distance ",
                                      style: Constants.regular4,
                                    ),
                                    Text(
                                      "${Snapshot.data[index]['disText']}",
                                      style: Constants.heading4,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Time ",
                                      style: Constants.regular4,
                                    ),
                                    Text(
                                     "${Snapshot.data[index]['createdAt']}",
                                      style: Constants.heading4.copyWith(fontSize: 14),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Custom3LocationWigets(
                              pickup:
                                  Snapshot.data[index]['originAddress'],
                              dropoff: Snapshot.data[index]['destinationAddress'],
                              empty: Snapshot.data[index]['containerReturnAddress']),
                        ),
                        Padding(
                  padding: const EdgeInsets.symmetric(vertical:5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: Constants.Grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 17),
                            child: Text(
                              "Rs ${Snapshot.data[index]['amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                              style: Constants.regular4
                                  .copyWith(color: Constants.Black),
                            ),
                          )),
                    ],
                  ),
                ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          // : Padding(padding: EdgeInsets.only(top: 0))
    ]);
                           
                          },
                        )

                ]);
              } else {
                return Padding(padding: EdgeInsets.only(top: 0));
              }
            }),

        // Upcountry

        // FindingBestRatesUpcountry()
      ],
    );
  }
}