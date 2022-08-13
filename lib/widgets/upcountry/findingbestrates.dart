import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/location.dart';


class UpcountryFindingBestRatesCard extends StatefulWidget {
   // ignore: use_key_in_widget_constructors
  final String status;

  const UpcountryFindingBestRatesCard({
    Key? key, 
    required this.status,
  }) : super(key: key);


  @override
  _UpcountryFindingBestRatesCardState createState() => _UpcountryFindingBestRatesCardState();
}

class _UpcountryFindingBestRatesCardState extends State<UpcountryFindingBestRatesCard> {
  @override
  Widget build(BuildContext context) {
     return Card(
      color: Constants.White,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Constants.Primary, width: 1),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: Constants.Primary,
            ),
            child: Center(
              child: Text(
                "Finding Best Rates...",
                style: Constants.regular2.copyWith(color: Constants.White),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order No. 00214",
                      style: Constants.regular2,
                    ),
                    Text(
                      "9 Sep 2022 8:59Pm",
                      style: Constants.regular2,
                    )
                  ],
                ),
                ContainerDetailblue(
                  vehicleType: "20 Feet Container",
                  quantity: "2",
                  weight: "5 Ton",
                  material: "Cement",
                ),
                SizedBox(
                  height: 10,
                ),
                ContainerDetailblue(
                  vehicleType: "40 Feet Container",
                  quantity: "1",
                  weight: "10 Ton",
                  material: "Electronics",
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Row(
                //       children: [
                //         Text(
                //           "Distance ",
                //           style: Constants.regular2,
                //         ),
                //         Text(
                //           "2000 KM",
                //           style: Constants.heading3,
                //         ),
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Text(
                //           "Time ",
                //           style: Constants.regular2,
                //         ),
                //         Text(
                //           "200 Min",
                //           style: Constants.heading3,
                //         )
                //       ],
                //     ),
                //   ],
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 15),
                //   child: Custom3LocationWigets(),
                // ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Constants.Primary,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 30),
                            child: Text(
                              "Transit",
                              style: Constants.regular2
                                  .copyWith(color: Constants.White),
                            ),
                          )),
                      Container(
                          decoration: BoxDecoration(
                            color: Constants.Grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 30),
                            child: Text(
                              "Rs.200,000",
                              style: Constants.regular2.copyWith(color: Constants.Black),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   height: 60,
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.only(
          //           bottomLeft: Radius.circular(15),
          //           bottomRight: Radius.circular(15)),
          //       color: Constants.Primary),
          //   child: ButtonBar(
          //     children: [
          //        TextButton(
          //          onPressed: () {}, 
          //          child: Text("Reject")
          //         ),
          //          TextButton(
          //          onPressed: () {}, 
          //          child: Text("Counter")
          //         ),
          //         TextButton(
          //          onPressed: () {}, 
          //          child: Text("Accept")
          //         )
          //     ],
          //   )
          // )
        ],
      ),
    );
  }
}




class ContainerDetailblue extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  final String vehicleType;
  final String quantity;
  final String weight;
  final String material;

  const ContainerDetailblue({
    Key? key,
    required this.vehicleType,
    required this.quantity,
    required this.weight,
    required this.material,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          color: Constants.Primary, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                Icon(
                  FontAwesomeIcons.truck,
                  color: Constants.Grey,
                  size: 60,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Constants.White,
                    child: Text(
                      quantity,
                      style: Constants.regular3,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 5, top: 5, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                    child: Text(
                  vehicleType,
                  style: Constants.heading2.copyWith(color: Constants.White),
                )),
                FittedBox(
                    child: Text(
                  "$weight $material",
                  style: Constants.regular2.copyWith(color: Constants.White),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Perlodlifter(),
                    Perlodlifter(),
                    
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Perlodlifter extends StatelessWidget {
  Perlodlifter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
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