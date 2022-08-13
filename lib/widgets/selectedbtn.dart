import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meribiltyapp/config/constants.dart';

class SelectedBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlinebtn;
  final bool isdata;

  // ignore: use_key_in_widget_constructors
  const SelectedBtn({
    required this.text,
    required this.onPressed,
    required this.outlinebtn,
    required this.isdata
  });

  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outlinebtn;

    return InkWell(
      onTap: () {
        onPressed();
      },
      splashColor: Constants.Secondarylight,
      child: Container(
          height: 50.0,
          decoration: BoxDecoration(
              color: _outlineBtn ? Colors.transparent : Constants.Primary,
              // border: Border.all(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(15.0)),
          margin: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 5.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: _outlineBtn ? Constants.Primary : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            //   if(isdata)
            //  Icon(
            //     FontAwesomeIcons.checkCircle,
            //     color: Constants.Success,
            //   ) 
            ],
          )),
    );
  }
}
