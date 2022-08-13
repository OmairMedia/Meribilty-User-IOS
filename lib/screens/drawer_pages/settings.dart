import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_notifications.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_profile.dart';
import 'package:meribiltyapp/screens/home/home.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/custominputfornum.dart';

import '../../Api Services/changePassword/change_password.dart';
import '../../widgets/custuminput.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController oldPassword  = TextEditingController();
  TextEditingController changePassword  = TextEditingController();
  TextEditingController changePasswordConfirm  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
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
      body: ListView(
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Constants.White,
              ),
              width: MediaQuery.of(context).size.width,
              // height: 300,
              child: ListTile(
                // leading: CircleAvatar(
                //   backgroundColor: Constants.Primary,
                //   radius: 40,
                // ),
                title: Text("${storage.getItem('fullname')}",
                    style: Constants.heading4.copyWith(color: Constants.Black)),
                subtitle: Text("${storage.getItem('type')}",
                    style: Constants.regular5.copyWith(color: Constants.Grey)),
                    onTap: (){
                       Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyProfile()));
                    },
                trailing: Icon(
                      FontAwesomeIcons.chevronRight,
                      size: 20,
                      color: Constants.Grey,
                    ),
              )),
          // Container(
          //     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       color: Constants.White,
          //     ),
          //     width: MediaQuery.of(context).size.width,
          //     // height: 300,
          //     child: ListTile(
          //       title: Text("Notifications",
          //           style: Constants.regular5.copyWith(color: Constants.Black)),
          //           onTap: () {
          //             Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (context) => MyNotifications()));
          //           },
          //          trailing: Icon(
          //             FontAwesomeIcons.chevronRight,
          //             size: 20,
          //             color: Constants.Grey,
          //           )
          //     )),
          // Container(
          //     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       color: Constants.White,
          //     ),
          //     width: MediaQuery.of(context).size.width,
          //     // height: 300,
          //     child: ListTile(
          //       title: Text("Security",
          //           style: Constants.regular5.copyWith(color: Constants.Black)),
          //       trailing: Icon(
          //             FontAwesomeIcons.chevronRight,
          //             size: 20,
          //             color: Constants.Grey,
          //           )
          //     )),
          // Container(
          //     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       color: Constants.White,
          //     ),
          //     width: MediaQuery.of(context).size.width,
          //     // height: 300,
          //     child: ListTile(
          //       title: Text("Language",
          //           style: Constants.regular5.copyWith(color: Constants.Black)),
          //       trailing: Icon(
          //             FontAwesomeIcons.chevronRight,
          //             size: 20,
          //             color: Constants.Grey,
          //           ),
          //     )),
          
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Constants.White,
              ),
              width: MediaQuery.of(context).size.width,
              // height: 300,
              child: ListTile(
                onTap: () {
                  launchURL("https://meribilty.com/termsofservice/");
                },
                title: Text("Terms & Conditions",
                    style: Constants.regular5.copyWith(color: Constants.Black)),
                trailing: Icon(
                    
                      FontAwesomeIcons.chevronRight,
                      size: 20,
                      color: Constants.Grey,
                    ),
              )),
             Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Constants.White,
              ),
              width: MediaQuery.of(context).size.width,
              // height: 300,
              child: ListTile(
                  title: Text("Privacy Policy",
                      style:
                          Constants.regular5.copyWith(color: Constants.Black)),
                  onTap: () {
                    launchURL("https://meribilty.com/privacy-policy/");
                  },
                  trailing: Icon(
                    FontAwesomeIcons.chevronRight,
                    size: 20,
                    color: Constants.Grey,
                  ))),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Constants.White,
              ),
              width: MediaQuery.of(context).size.width,
              // height: 300,
              child: ListTile(
                  title: Text("FAQs",
                      style:
                          Constants.regular5.copyWith(color: Constants.Black)),
                  onTap: () {
                    launchURL("https://meribilty.com/faq/");
                  },
                  trailing: Icon(
                    FontAwesomeIcons.chevronRight,
                    size: 20,
                    color: Constants.Grey,
                  ))),
              Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Constants.White,
              ),
              width: MediaQuery.of(context).size.width,
              // height: 300,
              child: ListTile(
                onTap: (){
                  showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.0),
                                      topRight: Radius.circular(12.0))),
                              builder: (BuildContext context) {
                                return Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(  
                                        bottom: MediaQuery.of(context).viewInsets.bottom),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Change Your Password",
                                              style: Constants.heading2.copyWith(
                                                  color: Constants.Primary),
                                            ),
                                          ),
                                          PasswordTextField(labelText: "Enter Previous Password", controller: oldPassword,),
                                          PasswordTextField(labelText: "Enter New Password", controller: changePassword,),
                                          PasswordTextField(labelText: "Confirm Password", controller: changePasswordConfirm,),
                                          CustomBtn(text: "Confirm", onpreased: (){
                                            if(changePassword.text.isEmpty || changePasswordConfirm.text.isEmpty || oldPassword.text.isEmpty){
                                              Get.snackbar("Error", "Submit All Fields",backgroundColor: Colors.red);
                                            }
                                            else if(changePassword.text != changePasswordConfirm.text){
                                              Get.snackbar("Error", "Password doesnot matches confirm password",backgroundColor: Colors.red);
                                              print("Password");
                                            }
                                            else{
                                               UserChangePassword(context,oldPassword.text,changePassword.text);
                                            }
                                           
                                          }, outlinebtn: false),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              });
                },
                title: Text("Change Password",
                    style: Constants.regular5.copyWith(color: Constants.Black)),
                trailing:Icon(
                      FontAwesomeIcons.chevronRight,
                      size: 20,
                      color: Constants.Grey,
                    ),
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Constants.White,
              ),
              width: MediaQuery.of(context).size.width,
              // height: 300,
              child: ListTile(
                onTap: (){
                   showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.0),
                                      topRight: Radius.circular(12.0))),
                              builder: (BuildContext context) {
                                return Container(
                                  height: 280,
                                  //color: Constants.Primary,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Contact Us:",
                                          style: Constants.heading2.copyWith(
                                              color: Constants.Primary),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Card(
                                          color: Constants.Primary,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0)),
                                          child: ListTile(
                                            onTap: () {
                                              launchURL(
                                                  "https://api.whatsapp.com/send?phone=923000728557");
                                            },
                                            leading: Icon(
                                              Icons.whatsapp_rounded,
                                              color: Colors.white,
                                            ),
                                            title: Text(
                                              "Whatsapp",
                                              style: Constants.regular2
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Card(
                                          color: Constants.Primary,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0)),
                                          child: ListTile(
                                            onTap: () {
                                              launchURL(emailLaunchUri);
                                            },
                                            leading: Icon(
                                              Icons.mark_email_unread_outlined,
                                              color: Colors.white,
                                            ),
                                            title: Text(
                                              "Email",
                                              style: Constants.regular2
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Card(
                                          color: Constants.Primary,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0)),
                                          child: ListTile(
                                            onTap: () {
                                              makePhoneCall("+923000728557");
                                            },
                                            leading: Icon(
                                              Icons.phone_android_rounded,
                                              color: Colors.white,
                                            ),
                                            title: Text(
                                              "Call",
                                              style: Constants.regular2
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                },
                title: Text("Contact Us",
                    style: Constants.regular5.copyWith(color: Constants.Black)),
                trailing: Icon(
                      FontAwesomeIcons.chevronRight,
                      size: 20,
                      color: Constants.Grey,
                    ),
              )),
        ],
      ),
    );
  }
}
