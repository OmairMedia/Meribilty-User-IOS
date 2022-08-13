import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meribiltyapp/Api%20Services/cancel/cancel_order.dart';
import 'package:meribiltyapp/Api%20Services/cancel/cancellation.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_deliveries.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_offers.dart';
import 'package:meribiltyapp/screens/home/drawer_User.dart';
import 'package:meribiltyapp/screens/ppl/downloadTermsandCondirions.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';

import '../../Api Services/ppl/transit/accept_qoute.dart';
import '../../Api Services/ppl/transit/reject_qoute.dart';
import '../../widgets/location.dart';
import '../../widgets/transit/qouted_delivery_card.dart';
import '../../widgets/transit/subordercard.dart';
import '../../widgets/upload_documents_transit.dart';
import '../../widgets/upload_documents_upcountry.dart';

class FindingBestQoute extends StatefulWidget {
  FindingBestQoute({Key? key, required this.orderNo, required this.createdAt})
      : super(key: key);
  var orderNo;
  var createdAt;

  @override
  _FindingBestQouteState createState() => _FindingBestQouteState();
}

class _FindingBestQouteState extends State<FindingBestQoute> {
  late CountdownTimerController controller;

  void onEnd() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MyDeliveries()));
  }

  // getTimerEndTime() {
  //   var date = DateFormat("dd/MM/yyyy, HH:mm:ss").parse(widget.createdAt).add(Duration(hours: 1));
  //    var date2 = DateFormat("dd/MM/yyyy, HH:mm:ss").parse(widget.createdAt).add(Duration(hours: hourLimit));
  //   var date3 = DateTime.now().add(Duration(hours: 1));
  //   var difference = date2.difference(date);
  //   var seconds = difference.inSeconds;
  //   var hours = difference.inHours;
  //   print(hours);
  //   print(seconds);
  // }

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60 * 3;
  Timer? timer;
  void initState() {
    super.initState();
    getModelSheetopeningTime();
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
    final now = DateTime.now();
    var newDateTimeObj2 =
        new DateFormat("dd/MM/yyyy, HH:mm:ss").parse(widget.createdAt);
    // if (!now.isAfter(newDateTimeObj2.add(Duration(hours: hourLimit)))) {
    //   print("Condition chal rahi hia");
    //   // Navigator.push(
    //   //     context, MaterialPageRoute(builder: (context) => FinalOrderCard(orderNo: widget.orderNo,)));

    // }
    getOrderInfo(navfunc: () {});
    timer = Timer.periodic(Duration(seconds: 5), (t) {
      getOrderInfo();
    });
    // You should have take care about the date format coming from backend becuase sholw structure is standing at this indexing of time
    // print(DateTime.parse(widget.createdAt).toString());
    // print(widget.createdAt.toString().substring(
    //     widget.createdAt.toString().indexOf(",") + 1,
    //     widget.createdAt.toString().indexOf(":")));

    // Future.delayed(const Duration(seconds: 10), () {
    //   Navigator.pushReplacement(context,
    //       MaterialPageRoute(builder: (context) => const MyDeliveries()));
    // });
  }

  getEndTime() {
    var date = DateFormat("dd/MM/yyyy, h:mm")
        .parse(widget.createdAt)
        .add(Duration(hours: hourLimit));
    var time = TimeOfDay.fromDateTime(date.add(Duration(hours: 2)));
    var dateFormat = DateFormat("h:mm a");
    // var abc =widget.createdAt.toString().substring(widget.createdAt.toString().length-3, widget.createdAt.toString().length)=="pm"? dateFormat.format(date.add(Duration(hours:12))):dateFormat.format(date);
    var abc = dateFormat.format(date.add(Duration(hours: 12)));
    // if(widget.createdAt.toString().substring(widget.createdAt.toString().length-3, widget.createdAt.toString().length)=="pm"){
    //   time = TimeOfDay.fromDateTime(date.add(Duration(hours: 12)));
    // }
    // var formattedDate = "${date.day}/${date.month}/${date.year}, ${date.hour}:${date.minute} ${widget.createdAt.toString().substring(widget.createdAt.toString().length-3, widget.createdAt.toString().length)} ${time.period.name} $abc";

    if (widget.createdAt.toString().substring(
            widget.createdAt.toString().length - 2,
            widget.createdAt.toString().length) ==
        "pm") {
      var formattedDate = dateFormat.format(DateFormat("dd/MM/yyyy, h:mm")
          .parse(widget.createdAt)
          .add(Duration(hours: hourLimit))
          .add(Duration(hours: 12)));
      return formattedDate;
    } else {
      var formattedDate = dateFormat.format(DateFormat("dd/MM/yyyy, h:mm")
          .parse(widget.createdAt)
          .add(Duration(hours: hourLimit)));
      return formattedDate;
    }
  }

  var quoteAmount;
  var minEstimateRates;
  var maxEstimateRates;
  String estimateMsgAvailable = "";
  int hourLimit = 3;
  @override
  void dispose() {
    controller.dispose();
    timer!.cancel();
    super.dispose();
    print("Dispse is running");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.Primary,
        elevation: 0,
        title: Text(
          "Finding Best Qoute",
          style: Constants.regular4.copyWith(color: Constants.White),
        ),
      ),
      drawer: Drawer(
        elevation: 5,
        child: SingleChildScrollView(
          child: Column(
            children: [CustomDrawerHeader(), CustomDrawerBody()],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child:
            //  Text("HELLO")
            SingleChildScrollView(
          child: Column(
            children: [
              if (quoteAmount != null)
                CustomBtn(
                    text: "You have a new offer",
                    onpreased: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              FinalOrderCard(orderNo: widget.orderNo)));
                    },
                    outlinebtn: false),
              // ElevatedButton(
              //     onPressed: () {
              //       print(widget.createdAt);
              //       final now = DateTime.now();
              //       var newDateTimeObj2 = new DateFormat("dd/MM/yyyy, HH:mm:ss")
              //           .parse(widget.createdAt);
              //       print(newDateTimeObj2);
              //       print("This is Now ${now}");
              //       print(
              //           "This is future ${newDateTimeObj2.add(Duration(hours: 3)).hour}");
              //       // print(now.hour> newDateTimeObj2.add(Duration(hours: 3)).hour);
              //       print(
              //           now.isBefore(newDateTimeObj2.add(Duration(hours: 3))));
              //       // final formattedDate =
              //       //     DateFormat.yMEd().add_jms().format(newDateTimeObj2);
              //       // print(DateTime.parse(formattedDate));
              //       //           print(DateTime.parse(widget.createdAt).toString());
              //       // print(widget.createdAt.toString().substring(
              //       //     widget.createdAt.toString().indexOf(",") + 1,
              //       //     widget.createdAt.toString().indexOf(":")));
              //     },
              //     child: Text("child")),
              const SizedBox(
                height: 40,
              ),
              Text("Date: ${widget.createdAt}",
                  style: Constants.heading4.copyWith(color: Constants.Primary)),
              Text("Order No: ${widget.orderNo}",
                  style: Constants.heading4.copyWith(color: Constants.Primary)),
              Text(
                  quoteAmount != null
                      ? "Qoute Recieved of ${quoteAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} PKR"
                      : estimateMsgAvailable,
                  style: Constants.heading4.copyWith(color: Constants.Primary)),
              // Text("Rs 120,000 - 130,000",
              //     style: Constants.heading4.copyWith(color: Constants.Primary)),
              const SizedBox(
                height: 10,
              ),
              // Align(
              //   alignment: Alignment.center,
              //   child: Text(
              //       "The market opens at 4 PM. The rates mentioned here are average rates and could be less or more when the market opens.",
              //       textAlign: TextAlign.center,
              //       style: Constants.regular4),
              // ),
              Image.asset(
                "assets/icon/loading.gif",
                height: 250,
              ),
              // Text(
              //   "10:00",
              //   style: Constants.heading1.copyWith(color: Constants.Primary),
              // ),
              Text(
                "You will get best qoute till",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF2F4D84),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "${getEndTime().toString()}",
                style: Constants.heading1.copyWith(color: Constants.Primary),
              ),
              // CountdownTimer(
              //   controller: controller,
              //   endTime: endTime,
              //   onEnd: onEnd,
              //   textStyle:
              //       Constants.heading1.copyWith(color: Constants.Primary),
              //   endWidget: Center(
              //       child: Text(
              //     "You will get a quote on your request shortly",
              //     style: const TextStyle(
              //         fontSize: 15,
              //         color: Color(0xFF2F4D84),
              //         fontWeight: FontWeight.bold),
              //   )),
              // ),
              Text(
                "We are negotiating best rates for you.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF2F4D84),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    icon: Icon(
                      FontAwesomeIcons.timesCircle,
                      color: Constants.BrightRed,
                    ),
                    label: Text(
                      "Cancel",
                      style: Constants.regular3
                          .copyWith(color: Constants.BrightRed),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text("Cancellation Reason"),
                                content: Container(
                                  height:
                                      300.0, // Change as per your requirement
                                  width:
                                      300.0, // Change as per your requirement
                                  child: FutureBuilder(
                                      future: cancellation_reason(),
                                      builder:
                                          (context, AsyncSnapshot Snapshot) {
                                        if (Snapshot.hasData) {
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                Snapshot.data['data'].length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return ListTile(
                                                onTap: () {
                                                  cancelOrder(
                                                      orderNo: widget.orderNo,
                                                      context: context);
                                                },
                                                title: Text(
                                                    "${Snapshot.data['data'][index]}"),
                                              );
                                            },
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      }),
                                ));
                          });
                    },
                  ),
                  OutlineButton(
                    child: Text("My Requests", style: Constants.regular3),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => MyOffers()));
                      // Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              CustomBtn(
                  text: "Terms And Conditions",
                  onpreased: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => TermsAndConditions()));
                  },
                  outlinebtn: false)
            ],
          ),
        ),
      ),
    );
  }

  Future getOrderInfo({navfunc}) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://staging-api.meribilty.com/api/user_get_vendor_qoute'));
    request.body = json.encode(
        {"token": "${box.read('token')}", "orderNo": "${widget.orderNo}"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    Map responseMap = json.decode(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      // print(responseMap['pending'][0]['qoute_amount']);
      if (responseMap['pending'].length == 0) {
        setState(() {
          maxEstimateRates = responseMap['maximum'];
          minEstimateRates = responseMap['minimum'];
          if (maxEstimateRates==0 && maxEstimateRates==0) {
            estimateMsgAvailable = "Estimated Rates : Not Available";
          }else
          {
              estimateMsgAvailable="Estimated Rates : Rs ${minEstimateRates.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} - ${maxEstimateRates.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}";
          }
        });

        // print("\n\nmiximum${responseMap['maximum']}\n\n");

        // print("\n\nminimum${responseMap['minimum']}\n\n");
      } else if (responseMap['pending'][0]['qoute_amount'] != null) {
        // navfunc();
        // print(responseMap['pending'][0]['qoute_amount']);
        setState(() {
          quoteAmount = responseMap['pending'][0]['qoute_amount'];
        });

        return responseMap['pending'];
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  // get time of limit
  getModelSheetopeningTime() async {
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://staging-api.meribilty.com/api/get_vendor_quote_time'));

    http.StreamedResponse response = await request.send();
    Map responseMap = json.decode(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      setState(() {
        hourLimit = responseMap['data']['hour'];
      });
    } else {
      print(response.reasonPhrase);
    }
  }
}

class FinalOrderCard extends StatefulWidget {
  FinalOrderCard({Key? key, required this.orderNo}) : super(key: key);
  var orderNo;

  @override
  State<FinalOrderCard> createState() => _FinalOrderCardState();
}

class _FinalOrderCardState extends State<FinalOrderCard> {
  Future getOrderInfo() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://staging-api.meribilty.com/api/user_get_vendor_qoute'));
    request.body = json.encode(
        {"token": "${box.read('token')}", "orderNo": "${widget.orderNo}"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    Map responseMap = json.decode(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      // print(responseMap['pending'][0]['qoute_amount']);
      if (responseMap['pending'][0]['qoute_amount'] != null) {
        print(responseMap['pending'][0]['qoute_amount']);

        return responseMap['pending'];
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.Primary,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.chevronLeft,
            color: Constants.White,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
          future: getOrderInfo(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                !snapshot.hasData) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.77,
                  child: Center(
                      child:
                          CircularProgressIndicator(color: Constants.Primary)));
            }
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.77,
                  child: Center(
                      child:
                          CircularProgressIndicator(color: Constants.Primary)));
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: ((context, index) {
                        return Card(
                          color: Constants.White,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Colors.lightBlue, width: 1),
                          ),
                          child: Column(
                            children: [
                              // Container(
                              //   width: MediaQuery.of(context).size.width,
                              //   padding: EdgeInsets.all(5),
                              //   decoration: BoxDecoration(
                              //     borderRadius: const BorderRadius.only(
                              //         topLeft: Radius.circular(15),
                              //         topRight: Radius.circular(15)),
                              //     color: Colors.lightBlue,
                              //   ),
                              //   child: Center(
                              //     child: Text(
                              //       "Final Offer Recieved",
                              //       style: Constants.regular4
                              //           .copyWith(color: Colors.white),
                              //     ),
                              //   ),
                              // ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Order #${snapshot.data[index]['orderNo']}",
                                          style: Constants.regular4,
                                        ),
                                        Text(
                                          "${DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(snapshot.data[index]['date']))}",
                                          style: Constants.regular4,
                                        )
                                      ],
                                    ),
                                    ListView.builder(
                                        itemCount: snapshot.data[index]
                                                    ['bilties'] ==
                                                null
                                            ? 0
                                            : snapshot
                                                .data[index]['bilties'].length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, ind) {
                                          if (snapshot.data[index]['bilties']
                                                  [ind]['type'] ==
                                              'vehicle') {
                                            return (Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: ContainerDetailblue(
                                                vehicleType:
                                                    "${snapshot.data[index]['bilties'][ind]['name']}",
                                                quantity:
                                                    "${snapshot.data[index]['bilties'][ind]['quantity']}",
                                                weight:
                                                    "${snapshot.data[index]['bilties'][ind]['weight']} Tons",
                                                material:
                                                    "${snapshot.data[index]['bilties'][ind]['material']}",
                                                image:
                                                    "${snapshot.data[index]['bilties'][ind]['image']}",
                                              ),
                                            ));
                                          }
                                          if (snapshot.data[index]['bilties']
                                                  [ind]['type'] ==
                                              'loading/unloading') {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  color: Constants.Primary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: (Column(
                                                children: [
                                                  ListView.builder(
                                                      shrinkWrap: true,
                                                      physics: ScrollPhysics(),
                                                      itemCount: snapshot.data[
                                                                          index]
                                                                      [
                                                                      'bilties'][ind]
                                                                  [
                                                                  'loading_options'] ==
                                                              null
                                                          ? 0
                                                          : snapshot
                                                              .data[index]
                                                                  ['bilties']
                                                                  [ind][
                                                                  'loading_options']
                                                              .length,
                                                      itemBuilder:
                                                          (context, i) {
                                                        return (ContainerDetailblueLoading_UnLoading(
                                                          vehicleType:
                                                              "${snapshot.data[index]['bilties'][ind]['loading_options'][i]['name']}",
                                                          quantity:
                                                              "${snapshot.data[index]['bilties'][ind]['loading_options'][i]['quantity']}",
                                                          weight:
                                                              "${snapshot.data[index]['bilties'][ind]['loading_options'][i]['weight']} Tons",
                                                          material:
                                                              "${snapshot.data[index]['bilties'][ind]['loading_options'][i]['type']}",
                                                          image:
                                                              "${snapshot.data[index]['bilties'][ind]['loading_options'][i]['image']}",
                                                        ));
                                                      }),
                                                  ListView.builder(
                                                      shrinkWrap: true,
                                                      physics: ScrollPhysics(),
                                                      itemCount: snapshot.data[
                                                                          index]
                                                                      [
                                                                      'bilties'][ind]
                                                                  [
                                                                  'unloading_options'] ==
                                                              null
                                                          ? 0
                                                          : snapshot
                                                              .data[index]
                                                                  ['bilties']
                                                                  [ind][
                                                                  'unloading_options']
                                                              .length,
                                                      itemBuilder:
                                                          (context, i) {
                                                        return (ContainerDetailblueLoading_UnLoading(
                                                          vehicleType:
                                                              "${snapshot.data[index]['bilties'][ind]['unloading_options'][i]['name']}",
                                                          quantity:
                                                              "${snapshot.data[index]['bilties'][ind]['unloading_options'][i]['quantity']}",
                                                          weight:
                                                              "${snapshot.data[index]['bilties'][ind]['unloading_options'][i]['weight']} Tons",
                                                          material:
                                                              "${snapshot.data[index]['bilties'][ind]['unloading_options'][i]['type']}",
                                                          image:
                                                              "${snapshot.data[index]['bilties'][ind]['unloading_options'][i]['image']}",
                                                        ));
                                                      }),
                                                ],
                                              )),
                                            );
                                          } else {
                                            return (Text(""));
                                          }
                                        }),
                                    Row(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                color: Constants.Primary,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 17),
                                              child: Text(
                                                snapshot.data[index]
                                                                ['request_type']
                                                            .toString()
                                                            .toLowerCase() ==
                                                        "upcountry"
                                                    ? "Nationwide"
                                                    : "${snapshot.data[index]['request_type']}"
                                                        .capitalize(),
                                                style: Constants.regular4
                                                    .copyWith(
                                                        color: Constants.White),
                                              ),
                                            )),
                                        Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Distance ",
                                                  style: Constants.regular4,
                                                ),
                                                Text(
                                                  "${snapshot.data[index]['disText']}",
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
                                                  "${snapshot.data[index]['qoutedAt']}",
                                                  style: Constants.heading4
                                                      .copyWith(fontSize: 14),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      child: Custom3LocationWigets(
                                        pickup:
                                            "${snapshot.data[index]['originAddress']},",
                                        dropoff:
                                            "${snapshot.data[index]['destinationAddress']},",
                                        empty:
                                            "${snapshot.data[index]['containerReturnAddress']},",
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                color: Constants.Grey,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 17),
                                                child: Text(
                                                  "Rs ${snapshot.data[index]['qoute_amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                                                  style: Constants.regular4
                                                      .copyWith(
                                                          color:
                                                              Constants.Black),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  //Rejected
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.325,
                                    height: MediaQuery.of(context).size.width *
                                        0.11,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all<EdgeInsets>(
                                                EdgeInsets.all(0)),
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
                                                  bottomLeft:
                                                      Radius.circular(18)),
                                            ))),
                                        onPressed: () async {
                                          final res = await rejectQoute(
                                              snapshot.data[index]['orderNo'],
                                              snapshot.data[index]['phone']);
                                          if (res['status']) {
                                            popup(context,
                                                title: "Offer Rejected!",
                                                message: res['message']);
                                          } else {
                                            popup(context,
                                                success: false,
                                                title: "Error Rejecting Offer!",
                                                message: res['error']);
                                          }
                                        },
                                        child: Text("Reject",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20))),
                                  ),
                                  //counter
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15))),
                                    width: MediaQuery.of(context).size.width *
                                        0.325,
                                    height: MediaQuery.of(context).size.width *
                                        0.11,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                EdgeInsets>(EdgeInsets.all(0)),
                                            foregroundColor:
                                                MaterialStateProperty.all<Color>(
                                                    Colors.white),
                                            backgroundColor:
                                                MaterialStateProperty.all<Color>(
                                                    Color(0xff62CAFA)),
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder())),
                                        onPressed: () {
                                          sendCounterOfferModel(
                                              context,
                                              snapshot.data[index]['orderNo'],
                                              snapshot.data[index]['phone']);
                                        },
                                        child: Text("Counter",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20))),
                                  ),
                                  // Accept
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15))),
                                    width: MediaQuery.of(context).size.width *
                                        0.328,
                                    height: MediaQuery.of(context).size.width *
                                        0.11,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Color(0xff13DD80)),
                                            padding: MaterialStateProperty.all<
                                                EdgeInsets>(EdgeInsets.all(0)),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(18)),
                                            ))),
                                        onPressed: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder:
                                                  (BuildContext buildcontext) {
                                                return SingleChildScrollView(
                                                  child: SafeArea(
                                                    child: Container(
                                                        child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20,
                                                              vertical: 5),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Icon(
                                                              FontAwesomeIcons
                                                                  .solidCheckCircle,
                                                              size: 64,
                                                              color: (Colors
                                                                  .green)),
                                                          Text(
                                                            "Offer Accepted !",
                                                            style: Constants
                                                                .heading2
                                                                .copyWith(
                                                                    color: Constants
                                                                        .Primary),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          Text(
                                                            "You have accepted the offer.",
                                                            style: Constants
                                                                .regular4
                                                                .copyWith(
                                                                    color: Constants
                                                                        .Grey),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          CustomBtn(
                                                              text: "Done",
                                                              onpreased: () {
                                                                snapshot.data[index]['type']
                                                                            .toString()
                                                                            .toLowerCase() ==
                                                                        "transit"
                                                                    ? Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => UploadDocumnetsTransit(
                                                                                  vendorName: snapshot.data[index]['vendor_name'],
                                                                                  functionToRun: () async {
                                                                                    final res = await acceptQoute(snapshot.data[index]['orderNo'], snapshot.data[index]['phone']);
                                                                                    if (res['status']) {
                                                                                      print("Done");
                                                                                    }
                                                                                  },
                                                                                  orderNo: snapshot.data[index]['orderNo'],
                                                                                  vendorPhone: snapshot.data[index]['user_phone'],
                                                                                )))
                                                                    : Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => UploadDocumnetsUpcountry(
                                                                                  vendorPhone: snapshot.data[index]['user_phone'],
                                                                                  vendorName: snapshot.data[index]['vendor_name'],
                                                                                  functionToRun: () async {
                                                                                    final res = await acceptQoute(snapshot.data[index]['orderNo'], snapshot.data[index]['phone']);
                                                                                    if (res['status']) {
                                                                                      print("Done");
                                                                                    }
                                                                                  },
                                                                                  orderNo: snapshot.data[index]['orderNo'],
                                                                                )));
                                                              },
                                                              outlinebtn: false)
                                                        ],
                                                      ),
                                                    )),
                                                  ),
                                                );
                                              });
                                          // showDialog(
                                          //     context: context,
                                          //     builder: (BuildContext context) =>
                                          //         AlertDialog(
                                          //           title: Text(
                                          //             'congratulations',
                                          //             style: Constants.heading2,
                                          //           ),
                                          //           content: Text(
                                          //             "You have successfully accepted the Offer !",
                                          //             style: Constants.regular4,
                                          //           ),
                                          //           actions: [
                                          //             TextButton(
                                          //                 onPressed: () async {
                                          //                   snapshot.data[index]
                                          //                                   [
                                          //                                   'type']
                                          //                               .toString()
                                          //                               .toLowerCase() ==
                                          //                           "transit"
                                          //                       ? Navigator.push(
                                          //                           context,
                                          //                           MaterialPageRoute(
                                          //                               builder: (context) => UploadDocumnetsTransit(
                                          //                                     vendorName: snapshot.data[index]['vendor_name'],
                                          //                                     functionToRun: () async {
                                          //                                       final res = await acceptQoute(snapshot.data[index]['orderNo'], snapshot.data[index]['phone']);
                                          //                                       if (res['status']) {
                                          //                                         print("Done");
                                          //                                       }
                                          //                                     },
                                          //                                     orderNo: snapshot.data[index]['orderNo'],
                                          //                                     vendorPhone: snapshot.data[index]['user_phone'],
                                          //                                   )))
                                          //                       : Navigator.push(
                                          //                           context,
                                          //                           MaterialPageRoute(
                                          //                               builder: (context) => UploadDocumnetsUpcountry(
                                          //                                     vendorPhone: snapshot.data[index]['user_phone'],
                                          //                                     vendorName: snapshot.data[index]['vendor_name'],
                                          //                                     functionToRun: () async {
                                          //                                       final res = await acceptQoute(snapshot.data[index]['orderNo'], snapshot.data[index]['phone']);
                                          //                                       if (res['status']) {
                                          //                                         print("Done");
                                          //                                       }
                                          //                                     },
                                          //                                     orderNo: snapshot.data[index]['orderNo'],
                                          //                                   )));
                                          //                 },
                                          //                 child: Text(
                                          //                   "Ok",
                                          //                   style: Constants
                                          //                       .regular3
                                          //                       .copyWith(
                                          //                           color: Constants
                                          //                               .Grey),
                                          //                 ))
                                          //           ],
                                          //         ));
                                        },
                                        child: Text(
                                          "Accept",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      })),
                ],
              );
            } else {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.77,
                  child: Center(
                      child:
                          CircularProgressIndicator(color: Constants.Primary)));
            }
          }),
    );
  }
}

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms and Conditions"),
        backgroundColor: Constants.Primary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Image.asset(
                  "assets/logo1.png",
                  width: 200,
                )),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                          "1.	This request will remain active for three (3) hours. Please continue to refresh to explore the best rate. Please note that the request will be cancelled if there is no activity for three (3) hours.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal))),
                ),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                          "2.	Insurance if not opted then Meribilty takes no responsibility.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal))),
                ),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                          "3.	For damages/loss Meribilty is not responsible for fire, theft, accidents, unforeseen situations, political activity and acts-of-God.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal))),
                ),
                Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("4.	Meribilty will not be responsible for:",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal))),
                Text("        a.	Container detention charges",
                    textAlign: TextAlign.justify,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                Text("        b.	If container is dirty and/or",
                    textAlign: TextAlign.justify,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                Text("        c.	If container is damaged.",
                    textAlign: TextAlign.justify,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                          "5.	Loading and unloading if not opted then Meribilty takes no responsibility.  In this case Loading and unloading will be arranged by the customer.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal))),
                ),
                Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("6.	Truck detention charges are:",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal))),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, top: 0, bottom: 12, right: 12),
                  child: Text("a.	Nationwide:",
                      textAlign: TextAlign.justify,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                      "            i.	24 hours free thereafter for PKR 4,000 for 20’ and PKR 5,000 for 40’. PKR 10,000 for low-bed",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal)),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, top: 0, bottom: 12, right: 12),
                  child: Text("b.	Transit:",
                      textAlign: TextAlign.justify,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                      "            i.	72 hours free thereafter for PKR 5,000 for 20’ and PKR 6,000 for 40’, PKR 15,000 for low-bed",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal)),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 3.0),
                    child: ElevatedButton.icon(
                        onPressed: () async {
                          downloadTermsandConditions();
                        },
                        icon: Icon(Icons.download),
                        label: Text("Terms and Conditions"),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Constants.Primary),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//  Text("""
// //         1.	This request will remain active for three (3) hours. Please continue to refresh to explore the best rate. Please note that the request will be cancelled if there is no activity for three (3) hours.\n
// //         2.	Insurance if not opted then Meribilty takes no responsibility.\n
// //         3.	For damages/loss Meribilty is not responsible for fire, theft, accidents, unforeseen situations, political activity and acts-of-God.\n
// //         4.	Meribilty will not be responsible for:\n
// //             a.	Container detention charges;\n
// //             b.	If container is dirty and/or;\n
// //             c.	If container is damaged.\n
// //         5.	Loading and unloading if not opted then Meribilty takes no responsibility.  In this case Loading and unloading will be arranged by the customer.\n
// //         6.	Truck detention charges are:\n
// //             a.	Nationwide:\n
// //           i.	24 hours free thereafter for PKR 4,000 for 20’ and PKR 5,000 for 40’. PKR 10,000 for low-bed\n
// //             b.	Transit:\n
// //           i.	72 hours free thereafter for PKR 5,000 for 20’ and PKR 6,000 for 40’, PKR 15,000 for low-bed\n
// //         """,textAlign:TextAlign.justify,style:TextStyle(fontSize: 18,fontWeight: FontWeight.normal),)
// //                                                                     

//  getfinalOrder() {
//     showModalBottomSheet(
//         context: context,
//         builder: (builder) {
//           return new Container(
//             height: 350.0,
//             child: new Container(
//                 decoration: new BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: new BorderRadius.only(
//                         topLeft: const Radius.circular(10.0),
//                         topRight: const Radius.circular(10.0))),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       FutureBuilder(
//                           future: getOrderInfo(),
//                           builder: (context, AsyncSnapshot snapshot) {
//                             if (snapshot.connectionState ==
//                                     ConnectionState.none ||
//                                 !snapshot.hasData) {
//                               return SizedBox(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.77,
//                                   child: Center(
//                                       child: CircularProgressIndicator(
//                                           color: Constants.Primary)));
//                             }
//                             if (snapshot.connectionState ==
//                                     ConnectionState.waiting ||
//                                 !snapshot.hasData) {
//                               return SizedBox(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.77,
//                                   child: Center(
//                                       child: CircularProgressIndicator(
//                                           color: Constants.Primary)));
//                             }
//                             if (snapshot.hasError) {
//                               return Center(
//                                   child: Text(snapshot.error.toString()));
//                             }
//                             if (snapshot.hasData) {
//                               return Column(
//                                 children: [
//                                   ListView.builder(
//                                       shrinkWrap: true,
//                                       physics: NeverScrollableScrollPhysics(),
//                                       itemCount: snapshot.data.length,
//                                       itemBuilder: ((context, index) {
//                                         return Card(
//                                           color: Constants.White,
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(15.0),
//                                             side: BorderSide(
//                                                 color: Colors.lightBlue,
//                                                 width: 1),
//                                           ),
//                                           child: Column(
//                                             children: [
//                                               Container(
//                                                 width: MediaQuery.of(context)
//                                                     .size
//                                                     .width,
//                                                 padding: EdgeInsets.all(5),
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       const BorderRadius.only(
//                                                           topLeft:
//                                                               Radius.circular(
//                                                                   15),
//                                                           topRight:
//                                                               Radius.circular(
//                                                                   15)),
//                                                   color: Colors.lightBlue,
//                                                 ),
//                                                 child: Center(
//                                                   child: Text(
//                                                     "Final Offer Recieved",
//                                                     style: Constants.regular4
//                                                         .copyWith(
//                                                             color:
//                                                                 Colors.white),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 20, right: 20),
//                                                 child: Column(
//                                                   children: [
//                                                     Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Text(
//                                                           "Order #${snapshot.data[index]['orderNo']}",
//                                                           style: Constants
//                                                               .regular4,
//                                                         ),
//                                                         Text(
//                                                           "${DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(snapshot.data[index]['date']))}",
//                                                           style: Constants
//                                                               .regular4,
//                                                         )
//                                                       ],
//                                                     ),
//                                                     ListView.builder(
//                                                         itemCount: snapshot.data[
//                                                                         index][
//                                                                     'bilties'] ==
//                                                                 null
//                                                             ? 0
//                                                             : snapshot
//                                                                 .data[index]
//                                                                     ['bilties']
//                                                                 .length,
//                                                         shrinkWrap: true,
//                                                         physics:
//                                                             NeverScrollableScrollPhysics(),
//                                                         itemBuilder:
//                                                             (context, ind) {
//                                                           if (snapshot.data[
//                                                                           index]
//                                                                       [
//                                                                       'bilties']
//                                                                   [
//                                                                   ind]['type'] ==
//                                                               'vehicle') {
//                                                             return (Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                           .only(
//                                                                       bottom:
//                                                                           8.0),
//                                                               child:
//                                                                   ContainerDetailblue(
//                                                                 vehicleType:
//                                                                     "${snapshot.data[index]['bilties'][ind]['name']}",
//                                                                 quantity:
//                                                                     "${snapshot.data[index]['bilties'][ind]['quantity']}",
//                                                                 weight:
//                                                                     "${snapshot.data[index]['bilties'][ind]['weight']} Tons",
//                                                                 material:
//                                                                     "${snapshot.data[index]['bilties'][ind]['material']}",
//                                                                 image:
//                                                                     "${snapshot.data[index]['bilties'][ind]['image']}",
//                                                               ),
//                                                             ));
//                                                           }
//                                                           if (snapshot.data[
//                                                                           index]
//                                                                       [
//                                                                       'bilties']
//                                                                   [
//                                                                   ind]['type'] ==
//                                                               'loading/unloading') {
//                                                             return Container(
//                                                               decoration: BoxDecoration(
//                                                                   color: Constants
//                                                                       .Primary,
//                                                                   borderRadius:
//                                                                       BorderRadius
//                                                                           .circular(
//                                                                               12)),
//                                                               child: (Column(
//                                                                 children: [
//                                                                   ListView.builder(
//                                                                       shrinkWrap: true,
//                                                                       physics: ScrollPhysics(),
//                                                                       itemCount: snapshot.data[index]['bilties'][ind]['loading_options'] == null ? 0 : snapshot.data[index]['bilties'][ind]['loading_options'].length,
//                                                                       itemBuilder: (context, i) {
//                                                                         return (ContainerDetailblueLoading_UnLoading(
//                                                                           vehicleType:
//                                                                               "${snapshot.data[index]['bilties'][ind]['loading_options'][i]['name']}",
//                                                                           quantity:
//                                                                               "${snapshot.data[index]['bilties'][ind]['loading_options'][i]['quantity']}",
//                                                                           weight:
//                                                                               "${snapshot.data[index]['bilties'][ind]['loading_options'][i]['weight']} Tons",
//                                                                           material:
//                                                                               "${snapshot.data[index]['bilties'][ind]['loading_options'][i]['type']}",
//                                                                           image:
//                                                                               "${snapshot.data[index]['bilties'][ind]['loading_options'][i]['image']}",
//                                                                         ));
//                                                                       }),
//                                                                   ListView.builder(
//                                                                       shrinkWrap: true,
//                                                                       physics: ScrollPhysics(),
//                                                                       itemCount: snapshot.data[index]['bilties'][ind]['unloading_options'] == null ? 0 : snapshot.data[index]['bilties'][ind]['unloading_options'].length,
//                                                                       itemBuilder: (context, i) {
//                                                                         return (ContainerDetailblueLoading_UnLoading(
//                                                                           vehicleType:
//                                                                               "${snapshot.data[index]['bilties'][ind]['unloading_options'][i]['name']}",
//                                                                           quantity:
//                                                                               "${snapshot.data[index]['bilties'][ind]['unloading_options'][i]['quantity']}",
//                                                                           weight:
//                                                                               "${snapshot.data[index]['bilties'][ind]['unloading_options'][i]['weight']} Tons",
//                                                                           material:
//                                                                               "${snapshot.data[index]['bilties'][ind]['unloading_options'][i]['type']}",
//                                                                           image:
//                                                                               "${snapshot.data[index]['bilties'][ind]['unloading_options'][i]['image']}",
//                                                                         ));
//                                                                       }),
//                                                                 ],
//                                                               )),
//                                                             );
//                                                           } else {
//                                                             return (Text(""));
//                                                           }
//                                                         }),
//                                                     Row(
//                                                       children: [
//                                                         Container(
//                                                             decoration: BoxDecoration(
//                                                                 color: Constants
//                                                                     .Primary,
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             20)),
//                                                             child: Padding(
//                                                               padding: const EdgeInsets
//                                                                       .symmetric(
//                                                                   vertical: 5,
//                                                                   horizontal:
//                                                                       17),
//                                                               child: Text(
//                                                                 snapshot.data[index]['request_type']
//                                                                             .toString()
//                                                                             .toLowerCase() ==
//                                                                         "upcountry"
//                                                                     ? "Nationwide"
//                                                                     : "${snapshot.data[index]['request_type']}"
//                                                                         .capitalize(),
//                                                                 style: Constants
//                                                                     .regular4
//                                                                     .copyWith(
//                                                                         color: Constants
//                                                                             .White),
//                                                               ),
//                                                             )),
//                                                         Spacer(),
//                                                         Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Row(
//                                                               children: [
//                                                                 Text(
//                                                                   "Distance ",
//                                                                   style: Constants
//                                                                       .regular4,
//                                                                 ),
//                                                                 Text(
//                                                                   "${snapshot.data[index]['disText']}",
//                                                                   style: Constants
//                                                                       .heading4,
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                             Row(
//                                                               children: [
//                                                                 Text(
//                                                                   "Time ",
//                                                                   style: Constants
//                                                                       .regular4,
//                                                                 ),
//                                                                 Text(
//                                                                   "${snapshot.data[index]['qoutedAt']}",
//                                                                   style: Constants
//                                                                       .heading4
//                                                                       .copyWith(
//                                                                           fontSize:
//                                                                               14),
//                                                                 )
//                                                               ],
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     Padding(
//                                                       padding:
//                                                           EdgeInsets.symmetric(
//                                                               vertical: 15),
//                                                       child:
//                                                           Custom3LocationWigets(
//                                                         pickup:
//                                                             "${snapshot.data[index]['originAddress']},",
//                                                         dropoff:
//                                                             "${snapshot.data[index]['destinationAddress']},",
//                                                         empty:
//                                                             "${snapshot.data[index]['containerReturnAddress']},",
//                                                       ),
//                                                     ),
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               bottom: 10),
//                                                       child: Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceAround,
//                                                         children: [
//                                                           Container(
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 color: Constants
//                                                                     .Grey,
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             20),
//                                                               ),
//                                                               child: Padding(
//                                                                 padding: const EdgeInsets
//                                                                         .symmetric(
//                                                                     vertical: 5,
//                                                                     horizontal:
//                                                                         17),
//                                                                 child: Text(
//                                                                   "Rs ${snapshot.data[index]['qoute_amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
//                                                                   style: Constants
//                                                                       .regular4
//                                                                       .copyWith(
//                                                                           color:
//                                                                               Constants.Black),
//                                                                 ),
//                                                               )),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   //Rejected
//                                                   Container(
//                                                     width:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .width *
//                                                             0.3091,
//                                                     height:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .width *
//                                                             0.11,
//                                                     child: ElevatedButton(
//                                                         style: ButtonStyle(
//                                                             padding:
//                                                                 MaterialStateProperty.all<EdgeInsets>(
//                                                                     EdgeInsets.all(
//                                                                         0)),
//                                                             foregroundColor: MaterialStateProperty.all<Color>(
//                                                                 Colors.white),
//                                                             backgroundColor:
//                                                                 MaterialStateProperty.all<Color>(
//                                                                     Colors.red),
//                                                             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                                                 RoundedRectangleBorder(
//                                                               borderRadius:
//                                                                   BorderRadius.only(
//                                                                       bottomLeft:
//                                                                           Radius.circular(
//                                                                               18)),
//                                                             ))),
//                                                         onPressed: () async {
//                                                           final res =
//                                                               await rejectQoute(
//                                                                   snapshot.data[
//                                                                           index]
//                                                                       [
//                                                                       'orderNo'],
//                                                                   snapshot.data[
//                                                                           index]
//                                                                       [
//                                                                       'phone']);
//                                                           if (res['status']) {
//                                                             popup(context,
//                                                                 title:
//                                                                     "Offer Rejected!",
//                                                                 message: res[
//                                                                     'message']);
//                                                           } else {
//                                                             popup(context,
//                                                                 success: false,
//                                                                 title:
//                                                                     "Error Rejecting Offer!",
//                                                                 message: res[
//                                                                     'error']);
//                                                           }
//                                                         },
//                                                         child: Text("Reject",
//                                                             style: TextStyle(
//                                                                 fontWeight:
//                                                                     FontWeight.bold,
//                                                                 fontSize: 20))),
//                                                   ),
//                                                   //counter
//                                                   Container(
//                                                     decoration: BoxDecoration(
//                                                         borderRadius:
//                                                             BorderRadius.only(
//                                                                 bottomLeft: Radius
//                                                                     .circular(
//                                                                         15),
//                                                                 bottomRight: Radius
//                                                                     .circular(
//                                                                         15))),
//                                                     width:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .width *
//                                                             0.3091,
//                                                     height:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .width *
//                                                             0.11,
//                                                     child: ElevatedButton(
//                                                         style: ButtonStyle(
//                                                             padding:
//                                                                 MaterialStateProperty.all<EdgeInsets>(
//                                                                     EdgeInsets.all(
//                                                                         0)),
//                                                             foregroundColor: MaterialStateProperty.all<Color>(
//                                                                 Colors.white),
//                                                             backgroundColor:
//                                                                 MaterialStateProperty.all<Color>(
//                                                                     Color(
//                                                                         0xff62CAFA)),
//                                                             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                                                 RoundedRectangleBorder())),
//                                                         onPressed: () {
//                                                           sendCounterOfferModel(
//                                                               context,
//                                                               snapshot.data[
//                                                                       index]
//                                                                   ['orderNo'],
//                                                               snapshot.data[
//                                                                       index]
//                                                                   ['phone']);
//                                                         },
//                                                         child: Text("Counter",
//                                                             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
//                                                   ),
//                                                   // Accept
//                                                   Container(
//                                                     decoration: BoxDecoration(
//                                                         borderRadius:BorderRadius.only(
//                                                                 bottomLeft: Radius
//                                                                     .circular(
//                                                                         15),
//                                                                 bottomRight: Radius
//                                                                     .circular(
//                                                                         15))),
//                                                     width:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .width *
//                                                             0.3091,
//                                                     height:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .width *
//                                                             0.11,
//                                                     child: ElevatedButton(
//                                                         style: ButtonStyle(
//                                                             foregroundColor:
//                                                                 MaterialStateProperty.all<Color>(
//                                                                     Colors
//                                                                         .white),
//                                                             backgroundColor:
//                                                                 MaterialStateProperty.all<Color>(
//                                                                     Color(
//                                                                         0xff13DD80)),
//                                                             padding:
//                                                                 MaterialStateProperty.all<EdgeInsets>(
//                                                                     EdgeInsets.all(
//                                                                         0)),
//                                                             shape: MaterialStateProperty.all<
//                                                                     RoundedRectangleBorder>(
//                                                                 RoundedRectangleBorder(
//                                                               borderRadius:
//                                                                   BorderRadius.only(
//                                                                       bottomRight:
//                                                                           Radius.circular(
//                                                                               18)),
//                                                             ))),
//                                                         onPressed: () {
//                                                           showDialog(
//                                                               context: context,
//                                                               builder: (BuildContext
//                                                                       context) =>
//                                                                   AlertDialog(
//                                                                     title: Text(
//                                                                       'congratulations',
//                                                                       style: Constants
//                                                                           .heading2,
//                                                                     ),
//                                                                     content:
//                                                                         Text(
//                                                                       "You have successfully accepted the Offer !",
//                                                                       style: Constants
//                                                                           .regular4,
//                                                                     ),
//                                                                     actions: [
//                                                                       TextButton(
//                                                                           onPressed:
//                                                                               () async {
//                                                                             snapshot.data[index]['type'].toString().toLowerCase() == "transit"
//                                                                                 ? Navigator.push(
//                                                                                     context,
//                                                                                     MaterialPageRoute(
//                                                                                         builder: (context) => UploadDocumnetsTransit(
//                                                                                               vendorName: snapshot.data[index]['vendor_name'],
//                                                                                               functionToRun: () async {
//                                                                                                 final res = await acceptQoute(snapshot.data[index]['orderNo'], snapshot.data[index]['phone']);
//                                                                                                 if (res['status']) {
//                                                                                                   print("Done");
//                                                                                                 }
//                                                                                               },
//                                                                                               orderNo: snapshot.data[index]['orderNo'],
//                                                                                               vendorPhone: snapshot.data[index]['user_phone'],
//                                                                                             )))
//                                                                                 : Navigator.push(
//                                                                                     context,
//                                                                                     MaterialPageRoute(
//                                                                                         builder: (context) => UploadDocumnetsUpcountry(
//                                                                                               vendorPhone: snapshot.data[index]['user_phone'],
//                                                                                               vendorName: snapshot.data[index]['vendor_name'],
//                                                                                               functionToRun: () async {
//                                                                                                 final res = await acceptQoute(snapshot.data[index]['orderNo'], snapshot.data[index]['phone']);
//                                                                                                 if (res['status']) {
//                                                                                                   print("Done");
//                                                                                                 }
//                                                                                               },
//                                                                                               orderNo: snapshot.data[index]['orderNo'],
//                                                                                             )));
//                                                                           },
//                                                                           child:
//                                                                               Text(
//                                                                             "Ok",
//                                                                             style:
//                                                                                 Constants.regular3.copyWith(color: Constants.Grey),
//                                                                           ))
//                                                                     ],
//                                                                   ));
//                                                         },
//                                                         child: Text(
//                                                           "Accept",
//                                                           style: TextStyle(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               fontSize: 20),
//                                                         )),
//                                                   ),
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         );
//                                       })),
//                                 ],
//                               );
//                             } else {
//                               return SizedBox(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.77,
//                                   child: Center(
//                                       child: CircularProgressIndicator(
//                                           color: Constants.Primary)));
//                             }
//                           }),
//                     ],
//                   ),
//                 )),
//           );
//         });
//   }