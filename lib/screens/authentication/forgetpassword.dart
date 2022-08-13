import 'package:flutter/material.dart';
import 'package:meribiltyapp/Api%20Services/registration%20Apis/forget_password.dart';
import 'package:meribiltyapp/Api%20Services/registration%20Apis/otp_verification.dart';
import 'package:meribiltyapp/screens/authentication/checkotp.dart';
import 'package:meribiltyapp/screens/authentication/otpverificationfor_forgerpassword.dart';
import 'package:meribiltyapp/screens/authentication/passwordset.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/custominputfornum.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);
  var phonenumbervar;
  @override
  Widget build(BuildContext context) {
    TextEditingController Phonenumber = TextEditingController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/group.png"),
                      alignment: Alignment.topCenter,
                      fit: BoxFit.contain)),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2.9,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              child: Card(
                elevation: 10,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 120,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    Text(
                      "Forget Password",
                      style: Constants.heading2,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    custominputfornumber(
                        control: Phonenumber,
                        hinttxt: "Enter Your Phone Number"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    CustomBtn(
                        text: "Next",
                        onpreased: () {
                          // print(phonenumberforinput);
                          forgetPassword(phonenumberforinput, context);
                        },
                        outlinebtn: false),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
