import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meribiltyapp/Api%20Services/ppl/add_address_info.dart';
import 'package:meribiltyapp/Api%20Services/province/staticData.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/ppl/select_payment_method.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/custuminput.dart';

import '../../Api Services/province/provinceList.dart';
import '../../widgets/vehicle selection pages/selectprovancie.dart';

class AddAddressInfo extends StatelessWidget {
  AddAddressInfo(
      {Key? key,
      required this.functionToRun,
      required this.orderNo,
      this.provinceListmodel})
      : super(key: key);
  final Function functionToRun;
  final String orderNo;
  final ProvinceListmodel? provinceListmodel;
  TextEditingController fromnameController = TextEditingController();
  TextEditingController fromaddressController = TextEditingController();
  TextEditingController fromcityController = TextEditingController();
  // TextEditingController fromprovinceController = TextEditingController();
  TextEditingController fromcountryController = TextEditingController();
  TextEditingController tonameController = TextEditingController();
  TextEditingController toaddressController = TextEditingController();
  TextEditingController tocityController = TextEditingController();
  // TextEditingController toprovinceController = TextEditingController();
  TextEditingController tocountryController = TextEditingController();
  // String selectedValueto = "Province";
  // String selectedValuefrom= "Province";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Address Info",
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
        child: Column(
          children: [
            Card(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.56,
                width: MediaQuery.of(context).size.width * 1,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Constants.Primary, width: 1.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      "From",
                      style: Constants.heading2,
                      textAlign: TextAlign.center,
                    ),
                    custominput(
                      hinttxt: "Name",
                      ispassword: false,
                      control: fromnameController,
                      inputType: TextInputType.text,
                    ),
                    custominput(
                      hinttxt: "Address",
                      ispassword: false,
                      control: fromaddressController,
                      inputType: TextInputType.text,
                    ),
                    custominput(
                      hinttxt: "City",
                      ispassword: false,
                      control: fromcityController,
                      inputType: TextInputType.text,
                    ),
                    SelectProvince(provinceListmodel: provinceListmodel),
                    custominput(
                      hinttxt: "Country",
                      ispassword: false,
                      control: fromcountryController,
                      inputType: TextInputType.text,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.56,
                width: MediaQuery.of(context).size.width * 1,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Constants.Primary, width: 1.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      "To",
                      style: Constants.heading2,
                      textAlign: TextAlign.center,
                    ),
                    custominput(
                      hinttxt: "Name",
                      ispassword: false,
                      control: tonameController,
                      inputType: TextInputType.text,
                    ),
                    custominput(
                      hinttxt: "Address",
                      ispassword: false,
                      control: toaddressController,
                      inputType: TextInputType.text,
                    ),
                    custominput(
                      hinttxt: "City",
                      ispassword: false,
                      control: tocityController,
                      inputType: TextInputType.text,
                    ),
                    SelectProvince(provinceListmodel: provinceListmodel),
                    // custominput(
                    //   hinttxt: "Province",
                    //   ispassword: false,
                    //   control: toprovinceController,
                    //   inputType: TextInputType.text,
                    // ),
                    custominput(
                      hinttxt: "Country",
                      ispassword: false,
                      control: tocountryController,
                      inputType: TextInputType.text,
                    ),
                  ],
                ),
              ),
            ),
            CustomBtn(
                text: "Proceed",
                onpreased: () {
                  print(
                      "\n\n\nmeri selecteed value from wali ${Selectedvalue.selectedvalue}\n\n\n");
                  if (fromnameController.text.isEmpty ||
                      fromaddressController.text.isEmpty ||
                      fromcityController.text.isEmpty ||
                      Selectedvalue.selectedvalue[0].isEmpty ||
                      fromcountryController.text.isEmpty ||
                      tonameController.text.isEmpty ||
                      toaddressController.text.isEmpty ||
                      tocityController.text.isEmpty ||
                      Selectedvalue.selectedvalue[1].isEmpty ||
                      tocountryController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text("Please fill all the fields"),
                            actions: [
                              FlatButton(
                                child: Text("Ok"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        });

                        
                  } else {
                    addAddressInfo(
                        orderNo,
                        fromnameController.text,
                        fromaddressController.text,
                        fromcityController.text,
                        Selectedvalue.selectedvalue[0],
                        fromcountryController.text,
                        tonameController.text,
                        toaddressController.text,
                        tocityController.text,
                        Selectedvalue.selectedvalue[1],
                        tocountryController.text,
                        context,
                        functionToRun);
                    Selectedvalue.selectedvalue.clear();
                  }
                },
                outlinebtn: false)
          ],
        ),
      ),
    );
  }
}
