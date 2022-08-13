import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/transit/optionchip.dart';

class ContainerDetailblue extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  final String vehicleType;
  final String quantity;
  final String weight;
  final String material;
  final String image;

  const ContainerDetailblue({
    Key? key,
    required this.vehicleType,
    required this.quantity,
    required this.weight,
    required this.material,
    required this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     
      decoration: BoxDecoration(
          color: Constants.Primary, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                image!="Null"||image!="null"||image!=null? Image(
                  image: NetworkImage(
                    "$image",
                  ),
                  height: 55,
                  width: 55,
                ):Icon(
                  FontAwesomeIcons.truck,
                  color: Constants.Grey,
                  size: 40,
                ),
                
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 5, top: 5, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FittedBox(
                    child: Text(
                  vehicleType,
                  style: Constants.regular4.copyWith(color: Constants.White),
                )),
                Text(
                  "$weight \n$material",
                  style: Constants.regular4.copyWith(color: Constants.White),
                ),
               
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ContainerDetailblueLoading_UnLoading extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  final String vehicleType;
  final String quantity;
  final String weight;
  final String material;
  final String image;

  const ContainerDetailblueLoading_UnLoading({
    Key? key,
    required this.vehicleType,
    required this.quantity,
    required this.weight,
    required this.material,
    required this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     
      decoration: BoxDecoration(
          color: Constants.Primary, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                image!="Null"||image!="null"||image!=null? Image(
                  image: NetworkImage(
                    "$image",
                  ),
                  height: 55,
                  width: 55,
                ):Icon(
                  FontAwesomeIcons.truck,
                  color: Constants.Grey,
                  size: 40,
                ),
                // Icon(
                //   FontAwesomeIcons.linux,
                //   color: Constants.Secondary,
                //   size: 40,
                // ),
                
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 5, top: 5, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FittedBox(
                    child: Text(
                  vehicleType,
                  style: Constants.regular4.copyWith(color: Constants.White),
                )),
                Row(
                  children: [
                    vehicleType.toString().toLowerCase() != "labour" ?
                    Padding(
                      padding: const EdgeInsets.only(right:8.0),
                      child: Text(
                        "$weight",
                        style: Constants.regular4.copyWith(color: Constants.White, fontSize: 14),
                      ),
                    ):
                    Text(
                      "",
                      style: Constants.regular4.copyWith(color: Constants.White, fontSize: 14),
                    ),
                    //SizedBox(width: 20,),
                    Text(
                      "$material".capitalize(),
                      style: Constants.regular4.copyWith(color: Constants.White, fontSize: 14),
                    ),
                  ],
                ),
               
              ],
            ),
          )
        ],
      ),
    );
  }
}

extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
}