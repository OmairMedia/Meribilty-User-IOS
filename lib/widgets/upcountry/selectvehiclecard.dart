import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';

class SingleVehicleSelectionCard extends StatefulWidget {
  const SingleVehicleSelectionCard({Key? key}) : super(key: key);

  @override
  _SingleVehicleSelectionCardState createState() =>
      _SingleVehicleSelectionCardState();
}

class _SingleVehicleSelectionCardState
    extends State<SingleVehicleSelectionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.White,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "20 Feet Container",
                      style: Constants.heading3,
                    ),
                    IconButton(
                        onPressed: () => {},
                        icon: Icon(
                          FontAwesomeIcons.trash,
                          size: 15,
                          color: Constants.BrightRed,
                        ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "2x Lifters 3-5 Tons",
                          style: Constants.regular2,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "5 Tons",
                          style: Constants.regular2,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Electronics",
                          style: Constants.regular2,
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // IconButton(onPressed: () => {}, )
                      TextButton.icon(
                          onPressed: () => {
                            
                          },
                          icon: Icon(
                            FontAwesomeIcons.plus,
                            size: 13,
                            color: Constants.Primary,
                          ),
                          label: Text("Add More",
                              style: Constants.heading5
                                  .copyWith(color: Constants.Primary)))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


