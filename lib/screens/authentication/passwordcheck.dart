import 'package:flutter/material.dart';
import 'package:meribiltyapp/Api%20Services/registration%20Apis/signinapi2.dart';
import 'package:meribiltyapp/screens/authentication/signin.dart';
import 'package:meribiltyapp/screens/authentication/signupcheck.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/home/home.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/checktile.dart';
import 'package:meribiltyapp/widgets/text_btns.dart';
import 'package:meribiltyapp/widgets/custuminput.dart';
import 'package:meribiltyapp/widgets/custominputfornum.dart';

class PasswordCheck extends StatelessWidget {
  PasswordCheck({required this.phonenum});
  var phonenum;

  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
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
                    FittedBox(
                      child: Text("Enter Password", style: Constants.regular1),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    PasswordTextField(
                        labelText: "Enter Password",
                        controller: passwordController),
                    // custominput(
                    //     hinttxt: "Enter Your Password",
                    //     ispassword: true,
                    //     control: passwordController,
                    //     inputType: TextInputType.visiblePassword
                    //     ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    CustomBtn(
                        text: "Login",
                        onpreased: () {
                          signinapi2(
                              context, phonenum, passwordController.text);
                          // print(passwordController.text);

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
