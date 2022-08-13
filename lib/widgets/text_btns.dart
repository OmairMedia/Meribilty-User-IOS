import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meribiltyapp/config/constants.dart';

class TextBtn extends StatelessWidget {
  String txt;
  Function onclick;
  bool isslected;
  TextStyle? style;
  TextBtn(
      {Key? key,
      this.style,
      required this.onclick,
      required this.isslected,
      required this.txt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return TextButton(
        onPressed: () {
          onclick();
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: (isslected)
                ? BorderSide(color: Constants.Primary, width: 3.0)
                : BorderSide.none,
            left: BorderSide.none,
            right: BorderSide.none,
            top: BorderSide.none,
          )),
          child: Text(
            txt.toString(),
            style: style == null
                ? (isslected)
                    ? Constants.heading2
                    : Constants.heading2.copyWith(color: Constants.Grey)
                : style,
          ),
        ));
  }
}
