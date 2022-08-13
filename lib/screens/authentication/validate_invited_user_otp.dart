import 'package:flutter/material.dart';
import 'package:meribiltyapp/Api%20Services/registration%20Apis/otp_verification.dart';
import 'package:meribiltyapp/Api%20Services/registration%20Apis/otp_verification_for_foorgetpassword.dart';
import 'package:meribiltyapp/Api%20Services/registration%20Apis/validate_invited_user.dart';
import 'package:meribiltyapp/screens/authentication/passwordcheck.dart';

import 'package:meribiltyapp/screens/authentication/signin.dart';
import 'package:meribiltyapp/screens/authentication/signupcheck.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/home/home.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/checktile.dart';
import 'package:meribiltyapp/widgets/text_btns.dart';
import 'package:meribiltyapp/widgets/custuminput.dart';
import 'package:meribiltyapp/widgets/custominputfornum.dart';
import 'package:pinput/pin_put/pin_put.dart';

class ValidateInvitedUserOtp extends StatelessWidget {
  ValidateInvitedUserOtp({Key? key, required this.phone}) : super(key: key);
  final phone;
  TextEditingController control = TextEditingController();
  var otppin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/59.png"),
                      alignment: Alignment.topCenter,
                      fit: BoxFit.contain)),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 4,
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
                      "Enter OTP For Verification",
                      style: Constants.heading2,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: PinPut(
                        fieldsCount: 4,
                        textStyle: Constants.heading2,
                        eachFieldWidth: 20.0,
                        eachFieldHeight: 55.0,
                        selectedFieldDecoration: BoxDecoration(
                            border: BorderDirectional(
                                bottom: BorderSide(
                                    color: Constants.Primary, width: 2))),
                        followingFieldDecoration: BoxDecoration(
                            border: BorderDirectional(
                                bottom: BorderSide(
                                    color: Constants.Primary, width: 2))),
                        onSubmit: (pin) async {},
                        onChanged: (pinvalue) {
                          otppin = pinvalue;
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    // TextBtn(
                    //     style:
                    //         Constants.regular2.copyWith(color: Constants.Grey),
                    //     onclick: () {},
                    //     isslected: false,
                    //     txt: "Resend OTP"),
                    CustomBtn(
                        text: "Verify OTP",
                        onpreased: () {
                          //  print(otppin);
                          validateInvitedUserOtp(context, otppin, phone);
                          // ontap();

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const Home()));
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
