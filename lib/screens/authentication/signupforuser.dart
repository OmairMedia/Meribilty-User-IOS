import 'package:flutter/material.dart';
import 'package:meribiltyapp/Api%20Services/registration%20Apis/signup.dart';
import 'package:meribiltyapp/screens/authentication/checkotp.dart';
import 'package:meribiltyapp/screens/authentication/signin.dart';
import 'package:meribiltyapp/screens/authentication/signupcheck.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/checktile.dart';
import 'package:meribiltyapp/widgets/custominputfornum.dart';
import 'package:meribiltyapp/widgets/custuminput.dart';
import 'package:meribiltyapp/widgets/text_btns.dart';

class SignUpForUser extends StatelessWidget {
  SignUpForUser(
      {required fullname,
      required phone,
      required email,
      required password,
      required context});

  @override
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();

  Widget build(BuildContext context) {
    bool isselected = false;
    TextEditingController control = TextEditingController();
    var phoneNumbervar;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/group.png"),
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth)),
        child: Container(
          margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 3.6, bottom: 20),
          width: MediaQuery.of(context).size.width / 1,
          child: Card(
            elevation: 10,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextBtn(
                          onclick: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpCheck()));
                          },
                          txt: "Sign Up",
                          isslected: true),
                      TextBtn(
                          onclick: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          },
                          txt: "Sign In",
                          isslected: false),
                    ],
                  ),
                  
                  Divider(
                    color: Colors.grey[200],
                    thickness: 1,
                  ),
                  
                  custominput(
                      inputType: TextInputType.name,
                      hinttxt: "Full Name",
                      ispassword: false,
                      control: namecontroller),

                  custominputfornumber(
                      hinttxt: "Mobile Number", control: phonecontroller),
                  custominput(
                      inputType: TextInputType.emailAddress,
                      hinttxt: "Email",
                      ispassword: false,
                      control: emailcontroller),
                 PasswordTextField(labelText: "Enter Password", controller: passwordcontroller),
                  PasswordTextField(labelText: "Confirm Password", controller: confirmpasswordcontroller),
                  // Form Field End

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 120,
                  ),
                  CustomBtn(
                      text: "Signup For User",
                      onpreased: () {
                        if (namecontroller.text.isEmpty ||
                            // phonecontroller.text.isEmpty ||
                            phonenumberforinput==null||
                            emailcontroller.text.isEmpty ||
                            passwordcontroller.text.isEmpty ||
                            confirmpasswordcontroller.text.isEmpty) {
                          var snackBar = const SnackBar(
                              content: Text('No field can be Empty'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        else if (passwordcontroller.text != confirmpasswordcontroller.text){
                          var snackBar = const SnackBar(
                              content: Text('Password and Confirm Password must be same'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        else {
                          SignUpUser(
                            fullname: namecontroller.text,
                            phone: phonenumberforinput,
                            email: '${emailcontroller.text}',
                            password: '${passwordcontroller.text}',
                            pro: false,
                            context: context,
                          );
                        }

                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => CheckOtp(ontap: () {})));
                      },
                      outlinebtn: false),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(bottom: 35),
        height: 15,
        child: Text(
          "By clicking proceed, you agree to our Terms and Conditions",
          style: Constants.regular6,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
