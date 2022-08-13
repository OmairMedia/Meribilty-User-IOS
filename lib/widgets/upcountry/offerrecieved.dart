import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meribiltyapp/Api%20Services/ppl/upcountry/accept_up_qoute.dart';
import 'package:meribiltyapp/Api%20Services/ppl/upcountry/counter_up_qoute.dart';
import 'package:meribiltyapp/Api%20Services/ppl/upcountry/reject_up_qoute.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_offers.dart';
import 'package:meribiltyapp/screens/ppl/select_payment_method.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/custuminput.dart';
import 'package:meribiltyapp/widgets/location.dart';

class UpcountryOfferRecieved extends StatefulWidget {
  final String status;
  final Color colored;
  final data;
  final order;

  const UpcountryOfferRecieved({
    Key? key,
    required this.status,
    required this.colored,
    required this.data,
    required this.order,
  }) : super(key: key);

  @override
  _UpcountryOfferRecievedState createState() => _UpcountryOfferRecievedState();
}

class _UpcountryOfferRecievedState extends State<UpcountryOfferRecieved> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.White,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Constants.White, width: 1),
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
          Column(
            children: [
              ContainerDetailblue2(
                vehicleType: "${(widget.data ?? const {})['type']}",
                quantity: "${(widget.data ?? const {})['vehicle_quantity']}",
                weight: "${(widget.data ?? const {})['weight']} Ton",
                material: "${(widget.data ?? const {})['material'][0]}",
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: widget.colored,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 30),
                          child: Text(
                            "Rs ${(widget.data ?? const {})['qoute']?['qoute_amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                            style: Constants.regular4
                                .copyWith(color: Constants.White),
                          ),
                        )),
                  ],
                ),
              ),
              ((widget.data ?? const {})['qoute']['status'] == 'pending')
                  ? Row(
                      children: [
                        //Rejected
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3022,
                          height: MediaQuery.of(context).size.width * 0.11,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
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
                                        bottomLeft: Radius.circular(18)),
                                  ))),
                              onPressed: () async {
                                final res = await rejectUpQoute(
                                    (widget.data ?? const {})['subOrderNo'],
                                    ((widget.data ?? const {})['qoute']
                                            ['phone'] ??
                                        widget.data['qoute']['vendor_phone']));
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
                        // Counter
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15))),
                          width: MediaQuery.of(context).size.width * 0.3022,
                          height: MediaQuery.of(context).size.width * 0.11,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.all(0)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xff62CAFA)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder())),
                              onPressed: () {
                                sendCounterOfferModel(
                                    context,
                                    (widget.data ?? const {})['subOrderNo'],
                                    ((widget.data ?? const {})['qoute']
                                            ['phone'] ??
                                        widget.data['qoute']['vendor_phone']));
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
                          width: MediaQuery.of(context).size.width * 0.3022,
                          height: MediaQuery.of(context).size.width * 0.11,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xff13DD80)),
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.all(0)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(18)),
                                  ))),
                              onPressed: () async {
                                final res = await acceptUpQoute(
                                    widget.data['subOrderNo'],
                                    (widget.data['qoute']['phone'] ??
                                        widget.data['qoute']['vendor_phone']));
                                if (res['status']) {
                                  var allAccepted =
                                      await checkAllSubOrdersAccepted(
                                          widget.order['subOrders']);
                                  if (allAccepted) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyOffers()));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SelectPaymentMethod(
                                                  functionToRun: () {
                                              print(
                                                  "yaha par accept wala function daydena");
                                            },
                                                  orderNo:
                                                      widget.data['subOrderNo'],
                                                )));
                                  } else {
                                    popup(context,
                                        color: Constants.Success,
                                        title: "Offer Accepted!",
                                        message: res['message']);
                                  }
                                } else {
                                  popup(context,
                                      success: false,
                                      title: "Error Accepting Offer!",
                                      message: res['error']);
                                }
                              },
                              child: Text(
                                "Accept",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                        ),
                      ],
                    )
                  : Padding(padding: EdgeInsets.only(top: 0)),
            ],
          ),
        ],
      ),
    );
  }
}

class ContainerDetailblue2 extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  final String vehicleType;
  final String quantity;
  final String weight;
  final String material;

  const ContainerDetailblue2({
    Key? key,
    required this.vehicleType,
    required this.quantity,
    required this.weight,
    required this.material,
  }) : super(key: key);

  @override
  State<ContainerDetailblue2> createState() => _ContainerDetailblue2State();
}

class _ContainerDetailblue2State extends State<ContainerDetailblue2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //: MediaQuery.of(context).size.height * .15,
      decoration: BoxDecoration(
        color: Constants.Primary,
        //orderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                Icon(
                  FontAwesomeIcons.truck,
                  color: Constants.Grey,
                  size: 40,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Constants.White,
                    child: Text(
                      widget.quantity,
                      style: Constants.regular3,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 5, top: 5, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FittedBox(
                    child: Text(
                  widget.vehicleType,
                  style: Constants.regular4.copyWith(color: Constants.White),
                )),
                FittedBox(
                    child: Text(
                  "${widget.weight} \n${widget.material}",
                  style: Constants.regular4.copyWith(color: Constants.White),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Perlodlifter(),
                    // Perlodlifter(),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Perlodlifter extends StatelessWidget {
  Perlodlifter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      decoration: BoxDecoration(
          color: Constants.White, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "2x ",
            style: Constants.regular2,
          ),
          Icon(
            FontAwesomeIcons.truckLoading,
            color: Constants.Primary,
            size: 12,
          ),
        ],
      ),
    );
  }
}

void sendCounterOfferModel(context, orderNo, vendor_phone) {
  TextEditingController amount = TextEditingController();
  showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 25),
                  child: Text(
                    "$vendor_phone If your counter is accepted, the transaction will be considered confirmed If you reject a 5% penalty will be applied of the value. Enter the counter offer below, which you want to send to the vendor",
                    style: Constants.regular4.copyWith(color: Constants.Grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: custominput(
                      hinttxt: "Amount",
                      ispassword: false,
                      control: amount,
                      inputType: TextInputType.number),
                ),
                CustomBtn(
                    text: "Send Counter Offer",
                    onpreased: () async {
                      final res = await counterUpQoute(
                          orderNo, amount.text, vendor_phone);
                      if (res['status']) {
                        Navigator.of(context).pop();
                        popup(context,
                            success: true,
                            color: Constants.Primary,
                            title: "Offer Countered!",
                            message: res['message']);
                      } else {
                        Navigator.of(context).pop();
                        popup(context,
                            success: false,
                            title: "Error Countering Offer!",
                            message: res['error']);
                      }
                    },
                    outlinebtn: false)
              ],
            ),
          ));
}

void popup(context,
    {success = true,
    color = null,
    title = "Offer Rejected !",
    message =
        "You have rejected the offer. Your order details are saved in your profile."}) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext buildcontext) {
        return SingleChildScrollView(
          child: SafeArea(
            child: Container(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  success
                      ? Icon(FontAwesomeIcons.solidCheckCircle,
                          size: 64, color: (color ?? Constants.BrightRed))
                      : Icon(FontAwesomeIcons.solidTimesCircle,
                          size: 64, color: Constants.BrightRed),
                  Text(
                    title,
                    style:
                        Constants.heading2.copyWith(color: Constants.Primary),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    message,
                    style: Constants.regular4.copyWith(color: Constants.Grey),
                    textAlign: TextAlign.center,
                  ),
                  CustomBtn(
                      text: "Done",
                      onpreased: () {
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyOffers()));
                      },
                      outlinebtn: false)
                ],
              ),
            )),
          ),
        );
      });
}

bool checkAllSubOrdersAccepted(subOrders) {
  var accepted = 0;
  for (var subOrder in subOrders) {
    if (subOrder['status'] == 'accepted') {
      accepted += 1;
    }
  }
  if (subOrders.length == accepted) {
    return true;
  } else {
    return false;
  }
}
