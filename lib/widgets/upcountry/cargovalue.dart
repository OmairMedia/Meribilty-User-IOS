import 'package:flutter/material.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/custuminput.dart';

class CargoValueSection extends StatefulWidget {
  const CargoValueSection({Key? key}) : super(key: key);

  @override
  _CargoValueSectionState createState() => _CargoValueSectionState();
}

class _CargoValueSectionState extends State<CargoValueSection> {
  bool isChecked = false;
  bool isVisible = false;
  TextEditingController cargoValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  "Do you want to insure your cargo",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
                width: 36,
                child: Checkbox(
                  activeColor: Constants.Primary,
                  checkColor: Constants.White,
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                      isVisible = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Visibility(
            visible: isVisible,
            child: Container(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: custominput(
                    hinttxt: "Enter Cargo Value",
                    ispassword: false,
                    control: cargoValue,
                    inputType: TextInputType.number)),
          ),
        ],
      ),
    );
  }
}
