import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meribiltyapp/Api%20Services/invite/invite.dart';
import 'package:meribiltyapp/Api%20Services/invite/user_invites_user.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/custominputfornum.dart';
import 'package:meribiltyapp/widgets/custuminput.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
//Invite Team Agents
class InviteFriend_UI extends StatefulWidget {
  InviteFriend_UI({Key? key, Function? functionToRun}) : super(key: key);

  @override
  State<InviteFriend_UI> createState() => _InviteFriend_UIState();
}

class _InviteFriend_UIState extends State<InviteFriend_UI> {
  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  final FlutterContactPicker _contactPicker = new FlutterContactPicker();

  Contact? _contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Invite Agent",
            style: Constants.heading3.copyWith(color: Constants.White),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(FontAwesomeIcons.chevronLeft),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.8,
                width: MediaQuery.of(context).size.width * 2,
                color: Constants.Primary,
                //padding: EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Image(
                        image: AssetImage(
                          "assets/7.png",
                        ),
                        height: 310,
                        width: 370,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              // Text(
              //   "Enter Number to Invite Friends",
              //   style: Constants.regular3,
              // ),
              // SizedBox(
              //   height: 5,
              // ),

              // custominput(
              //   hinttxt: "ABCDEF",
              //   ispassword: false,
              //   control: phoneNumberController,
              //   inputType: TextInputType.text,
              //   readonly: true,
              // ),

              custominput(
                  hinttxt: "Full Name",
                  ispassword: false,
                  control: nameController,
                  inputType: TextInputType.name),
              custominput(
                  hinttxt: "Email",
                  ispassword: false,
                  control: emailController,
                  inputType: TextInputType.emailAddress),
              // Text(_contact =),
              Text(
                "Enter Number to Invite Agent",
                style: Constants.regular3,
              ),
              SizedBox(
                height: 12,
              ),

              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: custominputfornumber(
                      // ispassword: false,
                      // inputType: TextInputType.phone,
                      hinttxt: "Phone Number",
                      control: phoneNumberController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 13),
                    child: IconButton(
                      onPressed: () async {
                        Contact? contact = await _contactPicker.selectContact();
                        print(contact);
                        setState(() {
                          // _contact = contact;
                          phoneNumberController.text = contact!.phoneNumbers![0].toString();
                        });
                      },
                      icon: Icon(
                        Icons.contacts_rounded,
                        color: Constants.Primary,
                        size: 38,
                      ),
                    ),
                  )
                ],
              ),
              CustomBtn(
                  text: "Invite Agent",
                  onpreased: () {
                    // print(phonenumberforinput);
                    userInvitesAUser(
                        context: context,
                        name: nameController.text,
                        email: emailController.text,
                        phone: phonenumberforinput,
                        namec: nameController,
                        emailc: emailController,
                        phonec: phoneNumberController);
                    // inviteFriend(phonenumberforinput, context);

                    // Share.share("Use Out Code (ABCDEF)");
              
                  },
                  outlinebtn: false)
            ],
          ),
        ));
  }
}
