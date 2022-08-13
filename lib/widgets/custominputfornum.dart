import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:meribiltyapp/config/constants.dart';
var phonenumberforinput;
// ignore: camel_case_types
class custominputfornumber extends StatelessWidget {
  final String hinttxt;
  final TextEditingController control;
  
  const custominputfornumber({
    Key? key,
    required this.hinttxt,
    required this.control,
  }) : super(key: key);

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
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: InternationalPhoneNumberInput(
              initialValue: PhoneNumber(isoCode: 'PK'),
                textFieldController: control,
                onInputChanged: (value) {
                  phonenumberforinput = value;
                },
                cursorColor: Constants.Primary,
                formatInput: false,
                selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
                    maxLength: 10,
                inputDecoration: InputDecoration(
                  hintStyle: TextStyle(color: Color(0xffb8c2cc), fontSize: 18),
                  contentPadding: const EdgeInsets.only(bottom: 15, left: 0),
                  border: InputBorder.none,
                  hintText: hinttxt,
                )),
                
          ),
          Positioned(
              left: 90,
              child: Container(
                height: 50,
                width: 0.5,
                color: Constants.Primary,
              )),
        ],
      ),
    );
  }
}

// 03243280234
// umair123
