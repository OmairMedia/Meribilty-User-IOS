import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/payment_method/PaymentMethodTransit.dart';
import 'package:meribiltyapp/Api%20Services/invite/My%20Team/myTeamServide.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_offers.dart';
import 'package:meribiltyapp/screens/ppl/select_contact_person.dart';
import 'package:meribiltyapp/widgets/animated_toggle.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/loading.dart';

class SelectPaymentMethod extends StatefulWidget {
  SelectPaymentMethod(
      {Key? key, required this.orderNo, required this.functionToRun})
      : super(key: key);
  final orderNo;
  final Function functionToRun;
  @override
  _SelectPaymentMethodState createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  TextEditingController cardNo = TextEditingController();
  int _toggleValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Payment Method",
          style: Constants.regular4.copyWith(color: Constants.White),
        ),
        backgroundColor: Constants.Primary,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(FontAwesomeIcons.chevronLeft),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Constants.Primary, width: 1),
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () =>
                          {selectBankTransferModel(context,widget.functionToRun, widget.orderNo)},
                      leading: Padding(
                        padding: const EdgeInsets.only(top:10.0),
                        child: Text("PKR", style: Constants.heading4,),
                      ),
                      title: Text('Bank Transfer',
                          style: Constants.heading3
                              .copyWith(color: Constants.Primary)),
                      subtitle: Text(
                        'You have to upload transfer slip to proceed',
                        style:
                            Constants.regular4.copyWith(color: Constants.Grey),
                      ),
                    ),
                  ],
                ),
              ),
              // Card(
              //   clipBehavior: Clip.antiAlias,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(15.0),
              //     side: BorderSide(color: Constants.Primary, width: 1),
              //   ),
              //   child: Column(
              //     children: [
              //       ListTile(
              //         onTap: () => {notEligibleForCreditPro(context)},
              //         leading: const Icon(FontAwesomeIcons.dollarSign),
              //         title: Text('Credit Pro',
              //             style: Constants.heading3
              //                 .copyWith(color: Constants.Primary)),
              //         subtitle: Text(
              //           'Upgrade To Pro and Avail It',
              //           style:
              //               Constants.regular4.copyWith(color: Constants.Grey),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Constants.Primary, width: 1),
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () => {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Select Point Of Payment',style: Constants.regular3,textAlign: TextAlign.center,),
                           
                            actions: [
                              AnimatedToggle(
                                values: ['Origin', 'Destination'],
                                onToggleCallback: (value) {
                                  setState(() {
                                    _toggleValue = value;
                                  });
                                },
                                buttonColor: const Color(0xFF0A3157),
                                backgroundColor: const Color(0xFFB5C1CC),
                                textColor: const Color(0xFFFFFFFF),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel",
                                      style: TextStyle(
                                  fontSize: 16.0,
                                  color:  Constants.Primary,
                                  fontWeight: FontWeight.w600,)
                                      )),	
                                  TextButton(
                                  onPressed: () {
                                    _toggleValue == 1
                                        ? addPaymentMethod(
                                          functionToRun: widget.functionToRun,
                                            orderNo: widget.orderNo,
                                            paymentMethod: "cod",
                                            pointOfpayment: "destination",
                                            context: context)
                                        : addPaymentMethod(
                                          functionToRun: widget.functionToRun,
                                            orderNo: widget.orderNo,
                                            paymentMethod: "cod",
                                            pointOfpayment: "origin",
                                            context: context);
                                  },
                                  child: Text('Confirm',style: TextStyle(
                                  fontSize: 16.0,
                                  color:  Constants.Primary,
                                  fontWeight: FontWeight.w600,)),)
                                ],
                              ),
                              
                            ],
                          ),
                        ),
                      },
                       leading: Padding(
                        padding: const EdgeInsets.only(top:10.0),
                        child: Text("PKR", style: Constants.heading4,),
                      ),
                      title: Text('Cash On Delivery',
                          style: Constants.heading3
                              .copyWith(color: Constants.Primary)),
                      subtitle: Text(
                        'Default Payment Method',
                        style:
                            Constants.regular4.copyWith(color: Constants.Grey),
                      ),
                    ),
                  ],
                ),
              ),

              // Card(
              //   clipBehavior: Clip.antiAlias,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(15.0),
              //     side: BorderSide(color: Constants.Primary, width: 1),
              //   ),
              //   child: Column(
              //     children: [
              //       ListTile(
              //         onTap: () => {selectCreditCardModel(context, widget.orderNo)},
              //         leading: const Icon(FontAwesomeIcons.dollarSign),
              //         title: Text('Debit/Credit Card',
              //             style: Constants.heading3
              //                 .copyWith(color: Constants.Primary)),
              //         subtitle: Text(
              //           'Pay Online With Your Card',
              //           style:
              //               Constants.regular4.copyWith(color: Constants.Grey),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        )),
      ),
    );
  }
}

// Bottom Sheet Model For Payment Methods

void selectBankTransferModel(context,Function functionToRun, orderNo) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext buildcontext) {
        return AnimatedContainer(
            duration: Duration(seconds: 1),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Text(
                    "MERIBILTY BANK DETAILS",
                    style:
                        Constants.heading3.copyWith(color: Constants.Primary),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "MERIBILTY(Pvt) LIMITED \n05001007745092 \n BANK ALFALAH LIMITED ",
                    style: Constants.regular4.copyWith(color: Constants.Grey),
                    textAlign: TextAlign.center,
                  ),
                  // TextButton(
                  //     onPressed: () async {
                  //       FilePickerResult? result =
                  //           await FilePicker.platform.pickFiles();

                  //       if (result != null) {
                  //         print(result.files.first.path);
                  //         // File file = File(result.files.single.path);
                  //       } else {
                  //         // User canceled the picker
                  //       }
                  //     },
                  //     child: Text("Upload Transfer Slip")),
                  CustomBtn(
                      text: "Upload Transfer Slip",
                      onpreased: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          addpaymentmethodBank(
                              orderNo, result.files.first.path,functionToRun, context);
                          print(result.files.first.path);
                          // File file = File(result.files.single.path);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Image is Empty"),
                          ));
                          // User canceled the picker
                        }
                        // Navigator.of(context).pop();
                      },
                      outlinebtn: false)
                ],
              ),
            ));
      });
}

// void selectCreditCardModel(context, orderNo) {
//   showModalBottomSheet(
//       context: context,
//       builder: (BuildContext buildcontext) {
//         return SingleChildScrollView(
//             child: SafeArea(
//           child: Container(
//               // height: MediaQuery.of(context).size.height * .40,
//               child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             child: Column(
//               children: [
//                 Text(
//                   "Pay Online",
//                   style: Constants.heading3.copyWith(color: Constants.Primary),
//                   textAlign: TextAlign.center,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: "**** **** **** ****",
//                     prefixIcon: Icon(FontAwesomeIcons.creditCard),
//                   ),
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: "Expiration Date",
//                     prefixIcon: Icon(FontAwesomeIcons.solidCalendar),
//                   ),
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: "CVC",
//                     prefixIcon: Icon(FontAwesomeIcons.creditCard),
//                   ),
//                 ),
//                 CustomBtn(
//                     text: "Save & Continue",
//                     onpreased: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => SelectContactPerson(
//                                     OrderNo: orderNo,
//                                   )));
//                     },
//                     outlinebtn: false)
//               ],
//             ),
//           )),
//         ));
//       });
// }

void notEligibleForCreditPro(context) {
  TextEditingController amount = TextEditingController();
  showModalBottomSheet(
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
                  Icon(FontAwesomeIcons.solidCheckCircle,
                      size: 64, color: Constants.BrightRed),
                  Text(
                    "Upgrade To Pro !",
                    style:
                        Constants.heading2.copyWith(color: Constants.Primary),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "You are not eligible to use this payment method. Please upgrade your account and try again.",
                    style: Constants.regular4.copyWith(color: Constants.Grey),
                    textAlign: TextAlign.center,
                  ),
                  // CustomBtn(text: "Done", onpreased: () {}, outlinebtn: false)
                ],
              ),
            )),
          ),
        );
      });
}

addpaymentmethodBank(orderNo, path,Function functionToRun, context) async {
  showloadingDialog("Uploading Take Time", context);
  var request = http.MultipartRequest('POST',
      Uri.parse('https://staging-api.meribilty.com/ppl/user_add_payment_method'));
  request.fields.addAll({
    'token': '${box.read("token")}',
    'orderNo': '$orderNo',
    'payment_method': 'bank',
    'accountNo': '465465465132'
  });
  request.files
      .add(await http.MultipartFile.fromPath('transfer_slip', '$path'));

  http.StreamedResponse response = await request.send();
  Map responseMap = await json.decode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
    print(responseMap);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Slip added sucessfully, waiting from admin for approval"),
    ));
    if (responseMap['status'] == true) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => SelectContactPerson(OrderNo: orderNo, functionToRun: functionToRun,)));
      // Navigator.pushAndRemoveUntil(context,
      //     MaterialPageRoute(builder: (_) => MyOffers()), (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(responseMap['message']),
      ));
    }
  } else {
    print(responseMap);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("There is an error"),
    ));
    print(response.reasonPhrase);
  }
}
