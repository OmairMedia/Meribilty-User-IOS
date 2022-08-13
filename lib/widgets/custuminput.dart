import 'package:flutter/material.dart';
import 'package:meribiltyapp/config/constants.dart';

// ignore: camel_case_types
class custominput extends StatelessWidget {
  final String hinttxt;
  final bool ispassword;
  final TextEditingController control;
  final TextInputType inputType;

  const custominput({
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
          border: Border.all(color: Constants.Primary, width: 0.5),
          borderRadius: BorderRadius.circular(10.0)),
      child: TextField(
      
     
        enableSuggestions: true,
        controller: control,
        keyboardType: inputType,
        obscureText: ispassword,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Color(0xffb8c2cc), fontSize: 18),
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
class PasswordTextField extends StatefulWidget {
  PasswordTextField(
      {Key? key,
      required this.labelText,
    required this.controller,})
      : super(key: key);
  TextEditingController controller;
  final labelText;
  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}
class _PasswordTextFieldState extends State<PasswordTextField> {
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
     margin: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      height: 50.0,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Constants.Primary, width: 0.5),
          borderRadius: BorderRadius.circular(10.0)),
        child: TextFormField(
          toolbarOptions: ToolbarOptions(copy: false),
          obscureText: !passwordVisible,
          keyboardType: TextInputType.visiblePassword,
          controller: this.widget.controller,
          decoration: InputDecoration(
             contentPadding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 12.0,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                passwordVisible ? Icons.visibility_off : Icons.visibility,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
            ),
            labelStyle: TextStyle(color: Color(0xffb8c2cc)),
            border: InputBorder.none,
            hintText: this.widget.labelText,
            hintStyle: TextStyle(color: Color(0xffb8c2cc), fontSize: 18),
           
                
           
               
          ),
        ));
  }
}
