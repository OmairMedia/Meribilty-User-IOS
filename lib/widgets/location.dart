import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meribiltyapp/config/constants.dart';

class Custom3LocationWigets extends StatelessWidget {
  final pickup;
  final dropoff;
  final empty;
  const Custom3LocationWigets(
      {Key? key,
      this.pickup = "Pick Up Location",
      this.dropoff = "Dropoff Location",
      this.empty = "Empty Container Location"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                FontAwesomeIcons.dotCircle,
                color: Constants.Primary,
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  pickup,
                  style: Constants.regular4,
                ),
              ),
            ],
          ),
          Divider(
            color: Constants.Grey,
            thickness: 1,
          ),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.mapMarkerAlt,
                color: Constants.BrightRed,
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  dropoff,
                  style: Constants.regular4,
                ),
              ),
            ],
          ),
          Divider(
            color: Constants.Grey,
            thickness: 1,
          ),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.dotCircle,
                color: Constants.Primary,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                empty,
                style: Constants.regular4,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Custom3LocationWigetsWallet extends StatelessWidget {
  final pickup;
  final dropoff;
  final empty;
  const Custom3LocationWigetsWallet(
      {Key? key,
      this.pickup = "Pick Up Location",
      this.dropoff = "Dropoff Location",
      this.empty = "Empty Container Location"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                FontAwesomeIcons.dotCircle,
                color: Constants.Primary,
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  pickup,
                  style: Constants.regular4,
                ),
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 2),
          //   child: Divider(
          //     color: Constants.Grey,
          //     thickness: 1,
          //   ),
          // ),
               SizedBox(height:5),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.mapMarkerAlt,
                color: Constants.BrightRed,
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  dropoff,
                  style: Constants.regular4,
                ),
              ),
            ],
          ),
          SizedBox(height:5),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 2),
          //   child: Divider(
          //     color: Constants.Grey,
          //     thickness: 1,
          //   ),
          // ),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.dotCircle,
                color: Constants.Primary,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                empty,
                style: Constants.regular4,
              ),
            ],
          ),
        ],
      ),
    );
  }
}