import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meribiltyapp/Api%20Services/registration%20Apis/upgrade_to_pro.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/home/home.dart';
import 'package:meribiltyapp/screens/ppl/select_contact_person.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/custuminput.dart';
import 'package:meribiltyapp/screens/home/drawer_User.dart';

import '../../widgets/custominputfornum.dart';

class ProBussinessForm extends StatefulWidget {
  const ProBussinessForm({Key? key}) : super(key: key);

  @override
  _ProBussinessFormState createState() => _ProBussinessFormState();
}

class _ProBussinessFormState extends State<ProBussinessForm> {
  bool isOwner = false;
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          title: Text(
            "Business Pro",
            style: Constants.heading2.copyWith(color: Constants.White),
          ),
          backgroundColor: Constants.Primary,
          elevation: 0,
          leading: IconButton(
              icon: Icon(FontAwesomeIcons.chevronLeft),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => Home()),
                    (route) => false);
              }),
        ),
        drawer: Drawer(
          elevation: 5,
          child: SingleChildScrollView(
            child: Column(
              children: [CustomDrawerHeader(), CustomDrawerBody()],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
                child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: Column(
                children: [
                  Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'I would like to apply to become a business pro and i agree to provide accurate business information',
                      style:
                          Constants.regular5.copyWith(color: Constants.Black),
                      textAlign: TextAlign.center,
                    ),
                  )),
                  
                  custominputForUpgrade(
                      hinttxt: "Full Name",
                      ispassword: false,
                      control: fullName,
                      inputType: TextInputType.text),
                  custominputfornumber(
                      hinttxt: "Mobile Phone", control: phone),
                  // custominputForUpgrade(
                  //     hinttxt: "Mobile Phone",
                  //     ispassword: false,
                  //     control: phone,
                  //     inputType: TextInputType.phone),
                  custominputForUpgrade(
                      hinttxt: "Email",
                      ispassword: false,
                      control: email,
                      inputType: TextInputType.emailAddress),
                  custominputForUpgrade(
                      hinttxt: "Business Name",
                      ispassword: false,
                      control: bussinessName,
                      inputType: TextInputType.text),
                  custominputForUpgrade(
                      hinttxt: "Business Address",
                      ispassword: false,
                      control: bussinessAddress,
                      inputType: TextInputType.text),
                  custominputForUpgrade(
                      hinttxt: "NTN Number",
                      ispassword: false,
                      control: ntn,
                      inputType: TextInputType.text),
                  custominputfornumber(
                      hinttxt: "Land Line Number", control: landline),
                  // custominputForUpgrade(
                  //     hinttxt: "Land Line Number",
                  //     ispassword: false,
                  //     control: landline,
                  //     inputType: TextInputType.number),
                  
                  // custominputForUpgrade(
                  //     hinttxt: "Are You Owner Or Team Member (Checkbox)",
                  //     ispassword: false,
                  //     control: status,
                  //     inputType: TextInputType.number),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 12.0,
                      ),
                      height: 50.0,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border:
                              Border.all(color: Constants.Primary, width: 1),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: CheckboxListTile(
                        title: Text(
                          'Are You Owner',
                          style: Constants.regular4
                              .copyWith(color: Colors.black54),
                        ),
                        activeColor: Constants.Primary,
                        value: isOwner,
                        onChanged: (val) {
                          setState(() {
                            isOwner = val!;
                          });
                        },
                      )),
                  custominputForUpgrade(
                      hinttxt: "Point Of Contact",
                      ispassword: false,
                      control: pointOfContact,
                      inputType: TextInputType.text),
                  custominputForUpgrade(
                      hinttxt: "Volume Of Cargo Per Month",
                      ispassword: false,
                      control: cargoPerMonth,
                      inputType: TextInputType.number),
                  custominputForUpgrade(
                      hinttxt: "How many days of credit you need ?",
                      ispassword: false,
                      control: daysOfCredit,
                      inputType: TextInputType.number),
                  custominputForUpgrade(
                      hinttxt: "Per month credit requirement ?",
                      ispassword: false,
                      control: perMonthCredit,
                      inputType: TextInputType.number),
                  CustomBtn(
                      text: "Send Application",
                      onpreased: () {
                        
                        if (fullName.text.isEmpty ||
                            phone.text.isEmpty ||
                            email.text.isEmpty ||
                            bussinessName.text.isEmpty ||
                            bussinessAddress.text.isEmpty ||
                            ntn.text.isEmpty ||
                            landline.text.isEmpty ||
                            pointOfContact.text.isEmpty ||
                            cargoPerMonth.text.isEmpty ||
                            daysOfCredit.text.isEmpty ||
                            perMonthCredit.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please fill all the fields"),
                          ));
                        } 
                        else if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email.text)==false){
                          var snackBar = SnackBar(
                              content:
                                  Text('Enter Valid Email Address'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                       
                        else {
                          upgradeToPro(
                              name: fullName.text,
                              email: email.text,
                              bussiness_name: bussinessName.text,
                              bussiness_address: bussinessAddress.text,
                              Ntn: ntn.text,
                              landline: landline.text,
                              owner: isOwner,
                              point_of_contact: pointOfContact.text,
                              cargo_volumne_per_month: cargoPerMonth.text,
                              credit_duration: daysOfCredit.text,
                              credit_requirement_per_month: perMonthCredit.text,
                              context: context,
                              controller1: fullName,
                              controller2: email,
                              controller3: bussinessName,
                              controller4: bussinessAddress,
                              controller5: ntn,
                              controller6: landline,
                              controller7: pointOfContact,
                              controller8: cargoPerMonth,
                              controller9: daysOfCredit,
                              controller10: perMonthCredit);
                        }
                      },
                      outlinebtn: false)
                ],
              ),
            )),
          ),
        ));
  }

  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController bussinessName = TextEditingController();
  TextEditingController bussinessAddress = TextEditingController();
  TextEditingController ntn = TextEditingController();
  TextEditingController landline = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController pointOfContact = TextEditingController();
  TextEditingController cargoPerMonth = TextEditingController();
  TextEditingController daysOfCredit = TextEditingController();
  TextEditingController perMonthCredit = TextEditingController();
}

class custominputForUpgrade extends StatelessWidget {
  final String hinttxt;
  final bool ispassword;
  final TextEditingController control;
  final TextInputType inputType;

  const custominputForUpgrade({
    Key? key,
    required this.hinttxt,
    required this.ispassword,
    required this.control,
    required this.inputType,
  }) : super(key: key);

  // ignore: use_key_in_widget_constructors

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 12.0,
      ),
      height: 50.0,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Constants.Primary, width: 1),
          borderRadius: BorderRadius.circular(10.0)),
      child: TextField(
        controller: control,
        keyboardType: inputType,
        obscureText: ispassword,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hinttxt,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 10.0,
            )),
        style: Constants.regular4,
      ),
    );
  }
}
