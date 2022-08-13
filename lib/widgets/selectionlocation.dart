import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meribiltyapp/config/constants.dart';

class SelectionLocationCard extends StatelessWidget {
  const SelectionLocationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _originLocation = TextEditingController();
    final _destinationLocation = TextEditingController();
    final _containerReturnLocation = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Constants.White,
      ),
      child: Column(
        children: [
          TextField(
            controller: _originLocation,
            onTap: () async {
              // should show search screen here
            },
            decoration: InputDecoration(
              icon: Container(
                margin: EdgeInsets.only(left: 20),
                width: 10,
                height: 10,
                child: Icon(
                  FontAwesomeIcons.dotCircle,
                  color: Constants.Primary,
                ),
              ),
              hintText: "Pickup Location",
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
            ),
          ),
          TextField(
            controller: _destinationLocation,
            onTap: () async {
              // should show search screen here
            },
            decoration: InputDecoration(
              icon: Container(
                margin: EdgeInsets.only(left: 20),
                width: 10,
                height: 10,
                child: Icon(
                  FontAwesomeIcons.mapMarkerAlt,
                  color: Constants.BrightRed,
                ),
              ),
              hintText: "Destination Location",
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
            ),
          ),
          TextField(
            controller: _containerReturnLocation,
            onTap: () async {
              // should show search screen here
            },
            decoration: InputDecoration(
              icon: Container(
                margin: EdgeInsets.only(left: 20),
                width: 10,
                height: 10,
                child: Icon(
                  FontAwesomeIcons.dotCircle,
                  color: Constants.Primary,
                ),
              ),
              hintText: "Empty Container Return",
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
