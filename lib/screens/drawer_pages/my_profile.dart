import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meribiltyapp/Api%20Services/profile/update_user_profile.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/constants/main_constants.dart';
// import 'package:manager_flutter_app/colors.dart';

// import 'homepage.dart';

class MyProfile extends StatefulWidget {
  String imagePath = "";
  @override
  State<StatefulWidget> createState() {
    return MyProfileState();
  }
}

class MyProfileState extends State<MyProfile> {
  bool pressGeoON = false;

  bool cmbscritta = false;
  int _groupValue = -1;
  final FullNameController = TextEditingController(text: storage.getItem('fullname'));
  final emailController = TextEditingController(text: storage.getItem('email'));
  late File _image;
  final picker = ImagePicker();

  late FocusNode fname;
  late FocusNode phone;

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        widget.imagePath = pickedFile.path;
        print(_image);
      } else {}
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        widget.imagePath = pickedFile.path;

        print(_image);
      } else {
        print("error");
      }
    });
  }

  Widget _myRadioButton(
      {required String title,
      required int value,
      required Function onChanged}) {
    return RadioListTile(
      activeColor: Color(0xff018577),
      value: value,
      groupValue: _groupValue,
      onChanged: null,
      title: Text(title),
    );
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    fname = FocusNode();
    phone = FocusNode();
  }

  @override
  void dispose() {
    fname.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  bool isClick = false;
  final homeLocationController = TextEditingController();
  final officeLocationController = TextEditingController();
  final PhoneController = TextEditingController();
  final depController = TextEditingController();
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black12,
    ));
    bool _enabled = false;
    FocusNode myFocusNode = new FocusNode();
    return MaterialApp(
      // theme: ThemeData(primarySwatch: Colors.blueGrey,
      //   // hintColor: Colors.grey,
      // ),
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Scaffold(
          appBar: AppBar(
            brightness: Brightness.light, // status bar brightness
            title: Text(
              "Profile",
              style: TextStyle(color: Colors.white),
            ),

            leading: IconButton(
              icon: Icon(
              FontAwesomeIcons.chevronLeft,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Constants.Primary,
          ),
          body: Stack(
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 130,
                          height: 130,
                          child: Stack(
                            children: [
                              Positioned(
                                child: Container(
                                  child: widget.imagePath == ""
                                      ? CircleAvatar(
                                          radius: 70,
                                          backgroundColor: Colors.transparent,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(70),
                                            child: Image(
                                                image: AssetImage(
                                                    "assets/user.png"),
                                                width: 200,
                                                height: 200,
                                                fit: BoxFit.cover),
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 70,
                                          backgroundColor: Colors.transparent,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(70),
                                              child: Image.file(
                                                  new File(widget.imagePath),
                                                  width: 120,
                                                  height: 120,
                                                  fit: BoxFit.cover)),
                                        ),
                                ),
                                left: 0,
                                right: 0,
                              ),
                              Positioned(
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  child: isClick
                                      ? Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            color: Constants.Primary,
                                          ),
                                          child: IconButton(
                                            iconSize: 18,
                                            icon: Icon(
                                              Icons.camera_alt_outlined,
                                              color: Colors.white,
                                            ),
                                            color: Colors.white,
                                            onPressed: () {
                                              _cameraGalleryModalBottomSheet(
                                                  context);
                                              /*showDialog(
                                          context: context, builder: (context) {
                                        return Dialog(
                                          insetPadding: EdgeInsets.all(20),
                                          backgroundColor: Colors.white,
                                          child: Container(
                                            width: double.infinity,
                                            height: 150,
                                            padding: EdgeInsets.only(left: 30),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .stretch,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text("Select Profile Picture",
                                                  style: TextStyle(fontSize: 20,
                                                      color: Colors.black),),
                                                _myRadioButton(
                                                  title: "Take Photo",
                                                  value: 0,
                                                  onChanged: (newValue) {
                                                    Navigator.pop(context);
                                                    getImageFromCamera();
                                                    // setState(() => _groupValue = newValue,
                                                    );//
                                                  }
                                                  ,
                                                ),
                                                _myRadioButton(
                                                    title: "Choose From Gallery",
                                                    value: 1,
                                                    onChanged: (newValue1) {
                                                      Navigator.pop(context);
                                                      getImageFromGallery();
                                                      //   setState(() => _groupValue = newValue1,
                                                      );//
                                                    }
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });*/
                                            },
                                          ),
                                        )
                                      : SizedBox(),
                                ),
                                right: 20,
                                bottom: 0,
                              ),
                            ],
                          ),
                        ),
                        /* CircleAvatar(

                      radius: 50,
                      backgroundImage: AssetImage(
                          "assets/image.png"
                      ),
                      child:Align(
                        alignment: Alignment.bottomRight,
                        child: isClick? Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Color(0xfff4762c),
                          ),
                          child: IconButton(
                            onPressed: (){
                            //  showDialog(context: context,builder: (context) => dialog());
                            },
                             iconSize: 20,
                            icon: Icon(Icons.camera_alt_outlined,color: Colors.white,),
                            color: Colors.white,
                          ),
                        ):SizedBox(),
                      ),
                    ),*/
                        SizedBox(
                          height: 10,
                        ),
                        // Text(widget.MyProfile==null?"":widget.MyProfile.full_name,style: TextStyle(color: Colors.black,fontSize: 20),),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          // focusNode: fname,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(32),
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z ]")),
                          ],
                          enabled: isClick ? true : false,
                          controller: FullNameController,
                          textInputAction: TextInputAction.next,
                          cursorColor: Constants.Primary,
                          style: TextStyle(
                              color: isClick ? Colors.black : Colors.grey),

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            prefixIcon: Icon(
                              Icons.person_rounded,
                              color: Colors.grey,
                            ),
                            labelText: "Full Name",
                            //    labelStyle: TextStyle( color:  Color(0xfff4762c)   ),
                            // hintText: box.read('fullname'),
                            floatingLabelBehavior: FloatingLabelBehavior.always,

                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Constants.Primary),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          // maxLength: 16,
                          // focusNode: fname,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(32),
                            FilteringTextInputFormatter.allow(RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")),
                          ],
                          enabled: isClick ? true : false,
                          controller: emailController,
                          // keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          cursorColor: Constants.Primary,
                          style: TextStyle(
                              color: isClick ? Colors.black : Colors.grey),

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                            labelText: "Email ",
                            //    labelStyle: TextStyle( color:  Color(0xfff4762c)   ),
                            // hintText: box.read('email'),
                            floatingLabelBehavior: FloatingLabelBehavior.always,

                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Constants.Primary),
                            ),
                          ),
                        ),

                        TextField(
                          cursorColor: Constants.Primary,
                          controller: PhoneController,
                          enabled: false,
                          focusNode: FocusNode(),
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.grey,
                            ),
                            labelText: "Mobile Number",
                            //    labelStyle: TextStyle( color:  Color(0xfff4762c)   ),
                            hintText: storage.getItem('phone'),
                            hintStyle: TextStyle(color: Colors.grey),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        TextField(
                          textInputAction: TextInputAction.done,
                          cursorColor: Constants.Primary,
                          controller: depController,
                          enabled: false,
                          focusNode: FocusNode(),
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            prefixIcon: Icon(Icons.wallet_travel),
                            labelText: "Type",
                            //    labelStyle: TextStyle( color:  Color(0xfff4762c)   ),
                            hintText: storage.getItem('type'),
                            hintStyle: TextStyle(color: Colors.grey),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 6,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ButtonTheme(
                            minWidth: double.infinity,
                            child: RaisedButton(
                              color: Constants.Primary,
                              onPressed: () async {
                                /*if(FullNameController.text.isEmpty|| PhoneController.text.isEmpty) {
                                    return Fluttertoast.showToast(
                                        msg: "please some text",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                    );
                                  }if(PhoneController.text.length<10){
                                    return  Fluttertoast.showToast(
                                        msg: "Please Enter Valid Number ",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 14.0
                                    );

                                  }*/

                                myFocusNode.requestFocus();
                                if (isClick) {
                                  final res = await updateUserProfile(
                                      FullNameController.text,
                                      emailController.text);

                                  if (res['status']) {
                                    box.write(
                                        'fullname', FullNameController.text);
                                    box.write('email', emailController.text);
                                     storage.setItem(
                                        'fullname', FullNameController.text);
                                    storage.setItem('email', emailController.text);


                                    setState(() {
                                      cmbscritta = false;
                                      isClick = false;
                                    });
                                    _updatedDialog(res['message']);
                                  } else {
                                    _updatedDialog(
                                        res['error'] ?? 'Type error!');
                                  }
                                } else {
                                  setState(() {
                                    cmbscritta = !cmbscritta;
                                    isClick = !isClick;
                                  });
                                }
                              },
                              child: cmbscritta
                                  ? Text(
                                      "UPDATE PROFILE",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    )
                                  : Text(
                                      "EDIT PROFILE",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(40.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _cameraGalleryModalBottomSheet(context) {
    final _formKey = GlobalKey<FormState>();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0)),
        ),
        backgroundColor: Color(0xfffbf7f4),
        context: context,
        builder: (BuildContext bc) {
          return Form(
              key: _formKey,
              child: Container(
                  height: 350.0,
                  // color: Colors.transparent,
                  child: Container(
                    height: 350,
                    padding: EdgeInsets.all(30),
                    // decoration: BoxDecoration(
                    //   color: Colors.black12,
                    //   borderRadius: new BorderRadius.only(
                    //       topLeft: const Radius.circular(10.0),
                    //       topRight: const Radius.circular(10.0)),
                    //
                    // ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 3,
                            width: 100,
                            color: Color(0xffe3e3e2),
                            child: Align(
                              alignment: Alignment.topLeft,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(padding: EdgeInsets.all(10)),
                          Text(
                            "Select Image",
                            style: TextStyle(
                                color: Constants.Primary,
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                  "Pleace choose one of the following option to upload your profile picture",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: Constants.Primary),
                                color: Color(0xfffbf7f4),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50.0),
                                  topRight: Radius.circular(50.0),
                                  bottomLeft: Radius.circular(50.0),
                                  bottomRight: Radius.circular(50.0),
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    getImageFromCamera();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 85),
                                    child: Row(
                                      children: [
                                        Icon(Icons.camera_alt_outlined,
                                            color: Constants.Primary,
                                            size: 25.0),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Use Camera",
                                          style: TextStyle(
                                              color: Constants.Primary,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 40),
                            child: Row(
                              children: [
                                Container(
                                  height: 2,
                                  width: 100,
                                  color: Color(0xffe3e3e2),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "OR",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 2,
                                  width: 100,
                                  color: Color(0xffe3e3e2),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50.0),
                                  topRight: Radius.circular(50.0),
                                  bottomLeft: Radius.circular(50.0),
                                  bottomRight: Radius.circular(50.0),
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    getImageFromGallery();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 50),
                                    child: Row(
                                      children: [
                                        Icon(Icons.add_photo_alternate_outlined,
                                            color: Constants.Primary,
                                            size: 25.0),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Upload From Gallery",
                                          style: TextStyle(
                                              color: Constants.Primary,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )));
        });
  }

  Future<void> _updatedDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Message'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(message)],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:meribiltyapp/config/constants.dart';

// class MyProfile extends StatefulWidget {
//   const MyProfile({Key? key}) : super(key: key);

//   @override
//   _MyProfileState createState() => _MyProfileState();
// }

// class _MyProfileState extends State<MyProfile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "My Profile",
//             style: Constants.regular4.copyWith(color: Constants.White),
//           ),
//           backgroundColor: Constants.Primary,
//           elevation: 0,
//           leading: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: const Icon(FontAwesomeIcons.chevronLeft),
//           ),
//         ),
//         body: ListView(
//           children: [
//             Container(
//                 padding: EdgeInsets.symmetric(vertical: 10),
//                 margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Constants.White,
//                 ),
//                 width: MediaQuery.of(context).size.width,
//                 // height: 300,
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundColor: Constants.Primary,
//                     ),
//                     TextButton(
//                         onPressed: () => {},
//                         child: Text(
//                           "Upload Profile Image",
//                           style: Constants.regular5
//                               .copyWith(color: Constants.Primary),
//                         ))
//                   ],
//                 )),
//             Container(
//                 margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Constants.White,
//                 ),
//                 width: MediaQuery.of(context).size.width,
//                 // height: 300,
//                 child: ListTile(
//                   title: Text("Account Type",
//                       style:
//                           Constants.heading4.copyWith(color: Constants.Black)),
//                   trailing: Text("User",
//                       style:
//                           Constants.regular4.copyWith(color: Constants.Grey)),
//                 )),
//             Container(
//                 margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Constants.White,
//                 ),
//                 width: MediaQuery.of(context).size.width,
//                 // height: 300,
//                 child: ListTile(
//                   title: Text("Phone",
//                       style:
//                           Constants.heading4.copyWith(color: Constants.Black)),
//                   subtitle: Text("You cannot change your phone number.",
//                       style:
//                           Constants.regular6.copyWith(color: Constants.Grey)),
//                   trailing: Text("+92332432547",
//                       style:
//                           Constants.regular4.copyWith(color: Constants.Grey)),
//                 )),
//             Container(
//                 margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Constants.White,
//                 ),
//                 width: MediaQuery.of(context).size.width,
//                 // height: 300,
//                 child: ListTile(
//                   title: Text("Username",
//                       style:
//                           Constants.heading4.copyWith(color: Constants.Black)),
//                   trailing: Text("M.Omair",
//                       style:
//                           Constants.regular4.copyWith(color: Constants.Grey)),
//                 )),
//             Container(
//                 margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Constants.White,
//                 ),
//                 width: MediaQuery.of(context).size.width,
//                 // height: 300,
//                 child: ListTile(
//                   title: Text("Email",
//                       style:
//                           Constants.heading4.copyWith(color: Constants.Black)),
//                   trailing: Text("omair@4slash.com",
//                       style:
//                           Constants.regular4.copyWith(color: Constants.Grey)),
//                 )),
//           ],
//         ));
//   }
// }





