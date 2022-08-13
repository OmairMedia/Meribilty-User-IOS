import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/custuminput.dart';
import 'package:http/http.dart' as http;
import 'package:meribiltyapp/widgets/loading.dart';

var insurance_value;
bool isInsuranceChecked = false;

class CargoValueSection extends StatefulWidget {
  const CargoValueSection({Key? key}) : super(key: key);

  @override
  _CargoValueSectionState createState() => _CargoValueSectionState();
}

class _CargoValueSectionState extends State<CargoValueSection> {
  calculateInsurance(cargo_value) async {
    showloadingDialog("Calculating", context);
    var headers = {'Content-Type': 'application/json'};
    Uri apiUrl = Uri.parse('https://staging-api.meribilty.com/ppl/calculate_insurance');
    var response = await http.Client().post(apiUrl,
        headers: headers, body: json.encode({"cargo_value": cargo_value}));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() {
        var jsonString = json.decode(response.body);
        if (jsonString['status'] == true) {
          setState(() {
            insurance_value = jsonString['insurance'];
            isCalculated = true;
          });
          print(insurance_value);
        }
      });
    } else {
   
      Navigator.pop(context);
    }
  }

  bool isCalculated = false;

  bool isVisible = false;
  TextEditingController cargoValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 4),
                child: Text("Do you want to insure your cargo",
                    style: Constants.regular5.copyWith(color: Constants.Black)),
              ),
              SizedBox(
                // height: 25,
                // width: 36,
                child: Checkbox(
                  activeColor: Constants.Primary,
                  checkColor: Constants.White,
                  value: isInsuranceChecked,
                  onChanged: (value) {
                    setState(() {
                      isInsuranceChecked = value!;
                      isVisible = value;
                      cargoValue.clear();
                      insurance_value = null;
                    });
                  },
                ),
              ),
            ],
          ),
          Visibility(
            visible: isVisible,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width * 0.6,
                        padding:
                            const EdgeInsets.only(top: 3, left: 7, right: 7),
                        child: custominput(
                            hinttxt: "Enter Cargo Value",
                            ispassword: false,
                            control: cargoValue,
                            inputType: TextInputType.number)),
                    // MaterialButton(onPressed: (){}, child: Text("calculate"),)
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 1, right: 2, bottom: 8),
                      // child: IconButton(onPressed: () {}, icon: Icon(Icons.calculate, size: 60,)),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Constants.Primary),
                            borderRadius: BorderRadius.circular(9)),
                        height: 56,
                        child: MaterialButton(
                          onPressed: () {
                            calculateInsurance(cargoValue.text);
                          },
                          child: Text(
                            "Calculate",
                            style: TextStyle(
                                color: Constants.Primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Insurance Value",
                  style: Constants.regular3.copyWith(color: Constants.Primary),
                ),
                Visibility(
                    visible: isCalculated,
                    child: Text(
                        insurance_value != null
                            ? insurance_value.toString()
                            : ' ',
                        style: Constants.heading2))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
