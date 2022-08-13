import 'package:flutter/material.dart';
import 'package:meribiltyapp/Api%20Services/province/staticData.dart';

import '../../Api Services/province/provinceList.dart';
import '../../config/constants.dart';
import '../../screens/drawer_pages/my_deliveries.dart';

class SelectProvince extends StatefulWidget {
  SelectProvince({Key? key, required this.provinceListmodel}) : super(key: key);
  final ProvinceListmodel? provinceListmodel;

  @override
  State<SelectProvince> createState() => _SelectProvinceState();
}

class _SelectProvinceState extends State<SelectProvince> {
  String selectedValue = "Province";
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Province", style:Constants.regular4), value: "Province"),
  ];
  @override
  void initState() {
    super.initState();
    setdropdown();

    ///whatever you want to run on page build
  }

  setdropdown() {
    widget.provinceListmodel?.data?.forEach((Data? element) {
      menuItems.add(DropdownMenuItem(
        child: Text("${element?.provinceLongname}",style:Constants.regular4),
        value: "${element?.provinceLongname}",
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 9.0,
      ),
      height: 70.0,
      child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Constants.Primary, width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Constants.Primary, width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.transparent,
          ),
          dropdownColor: Colors.white,
          value: selectedValue,
          onChanged: (String? newValue) {
            if (Selectedvalue.selectedvalue.length <= 2) {
              Selectedvalue.selectedvalue.add(newValue.toString());
            }else
            {
              Selectedvalue.selectedvalue.insert(
                Selectedvalue.selectedvalue.length - 1, newValue.toString());

            }
            
            setState(() {
              selectedValue = newValue!;
            });
          },
          items: menuItems),
    );
  }
}
