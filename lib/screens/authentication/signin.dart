import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meribiltyapp/Api%20Services/registration%20Apis/signapi.dart';
import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/screens/authentication/checkotp.dart';

import 'package:meribiltyapp/screens/authentication/forgetpassword.dart';
import 'package:meribiltyapp/screens/authentication/passwordcheck.dart';

import 'package:meribiltyapp/screens/authentication/signupcheck.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/home/home.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/checktile.dart';
import 'package:meribiltyapp/widgets/text_btns.dart';
import 'package:meribiltyapp/widgets/custuminput.dart';
import 'package:meribiltyapp/widgets/custominputfornum.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  var phonenumbervar;
    TextEditingController phonenumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isselected = false;
  

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          child: Stack(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextBtn(
                                onclick: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpCheck()));
                                },
                                txt: "Sign Up",
                                isslected: false),
                              
                            TextBtn(
                                onclick: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignIn()));
                                },
                                txt: "Sign In",
                                isslected: true),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 120,
                        ),
                        Divider(
                          color: Colors.grey[200],
                          thickness: 1,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 120,
                        ),
                        Text(
                          "Login With You Phone Number",
                          style: Constants.regular4,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 120,
                        ),
                        custominputfornumber(
                            hinttxt: "Enter Your Phone Number",
                            control: phonenumber),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height / 80,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // CheckTile(
                            //   ischecked: box.read("remember") == null
                            //       ? false
                            //       : box.read("remember"),
                            //   Txt: "Remember",
                            //   OnChange: (val) {
                            //     box.write("remember", val);
                            //     isselected = val;
                            //     print(box.read("remember"));
                            //   },
                            // ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ForgetPassword()));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 30, top: 10),
                                child: Text(
                                  "Forget Password",
                                  style: Constants.regular4,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 120,
                        ),
                        CustomBtn(
                            text: "Next",
                            onpreased: () {
                              // print('This is phone number ${phonenumberforinput}');
      
                              signin(phonenumberforinput, context);
                              // signin('+923352640168', context);
                              // signInUser(email.text, password.text);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>  PasswordCheck(phonenum: phonenumber)));
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
        ),
      ),
    );
  }
}

void signInUser(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    Fluttertoast.showToast(
        msg: "$userCredential",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: const Color.fromARGB(255, 39, 39, 39),
        fontSize: 16.0);
  } on FirebaseAuthException catch (e) {
    String? errormessage = e.message;
    Fluttertoast.showToast(
        msg: "$errormessage",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

void signOut() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  auth.signOut();
}
