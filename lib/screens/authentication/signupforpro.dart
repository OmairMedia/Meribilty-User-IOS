import 'package:flutter/material.dart';
import 'package:meribiltyapp/Api%20Services/registration%20Apis/signup.dart';
import 'package:meribiltyapp/screens/authentication/signin.dart';
import 'package:meribiltyapp/screens/authentication/signupcheck.dart';
import 'package:meribiltyapp/screens/authentication/checkotp.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/checktile.dart';
import 'package:meribiltyapp/widgets/custominputfornum.dart';
import 'package:meribiltyapp/widgets/custuminput.dart';
import 'package:meribiltyapp/widgets/text_btns.dart';

class SignUpForPro extends StatelessWidget {
  SignUpForPro({Key? key}) : super(key: key);
  bool isselected = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var phonenumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/group.png"),
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth)),
        child: Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 3.5, bottom: 20),
          width: MediaQuery.of(context).size.width / 1,
          child: Card(
            elevation: 10,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height / 120,
                  // ),
                  //Top Bar Start
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
                  //Top Bar End
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height / 120,
                  // ),
                  Divider(
                    color: Colors.grey[200],
                    thickness: 1,
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height / 60,
                  // ),
                  // //Heading
                  // Text(
                  //   "Pro Registration",
                  //   style: Constants.regular3,
                  // ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height / 20,
                  // ),
                  // Form Field Start
                  custominput(
                      inputType: TextInputType.name,
                      hinttxt: "Full Name",
                      ispassword: false,
                      control: nameController),
                  custominputfornumber(
                      hinttxt: "Mobile Number", control: phoneController),
                  custominput(
                      inputType: TextInputType.emailAddress,
                      hinttxt: "Email",
                      ispassword: false,
                      control: emailController),
                  PasswordTextField(labelText: "Enter Password", controller: passwordController),
                  PasswordTextField(labelText: "Confirm Password", controller: confirmpasswordController),
                  // Form Field End

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 100,
                  ),
                  CustomBtn(
                      text: "Signup For Pro",
                      onpreased: () {
                       if (nameController.text.isEmpty ||
                            // phonecontroller.text.isEmpty ||
                            phonenumberforinput==null||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            confirmpasswordController.text.isEmpty) {
                          var snackBar = const SnackBar(
                              content: Text('No field can be Empty'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        else if (passwordController.text != confirmpasswordController.text){
                          var snackBar = const SnackBar(
                              content: Text('Password and Confirm Password must be same'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        else {
                          SignUpUser(
                            fullname: nameController.text,
                            phone: phonenumberforinput,
                            email: '${emailController.text}',
                            password: '${passwordController.text}',
                            pro: true,
                            context: context,
                          );
                        }
                      },
                      outlinebtn: false)
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
