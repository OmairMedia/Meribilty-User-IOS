import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meribiltyapp/config/constants.dart';


class Perlodlifter extends StatelessWidget {
  Perlodlifter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      decoration: BoxDecoration(
          color: Constants.White, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "2x ",
            style: Constants.regular2,
          ),
          Icon(
            FontAwesomeIcons.truckLoading,
            color: Constants.Primary,
            size: 12,
          ),
        ],
      ),
    );
  }
}