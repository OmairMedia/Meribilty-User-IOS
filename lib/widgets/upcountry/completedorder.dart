import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/location.dart';

class UpcountryCompletedOrderCard extends StatefulWidget {
  final String status;
  final String Rate;
  final Color colored;

  const UpcountryCompletedOrderCard({
    Key? key,
    required this.status,
    required this.colored,
    required this.Rate,
  }) : super(key: key);

  @override
  _UpcountryCompletedOrderCardState createState() => _UpcountryCompletedOrderCardState();
}

class _UpcountryCompletedOrderCardState extends State<UpcountryCompletedOrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.White,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Constants.White, width: 1),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: widget.colored,
            ),
            child: Center(
              child: Text(
                "${widget.status}",
                style: Constants.regular4.copyWith(color: Constants.White),
              ),
            ),
          ),
          Column(
            children: [
               ContainerDetailblue(
                vehicleType: "20 Feet Container",
                quantity: "2",
                weight: "5 Ton",
                material: "Cement",
              ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: widget.colored,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 30),
                                  child: Text(
                                    "${widget.Rate}",
                                    style: Constants.regular4
                                        .copyWith(color: Constants.White),
                                  ),
                                )),
                          ],
                        ),
                      ),
            ],
          ),
        ],
      ),
    );
  }
}

class ContainerDetailblue extends StatefulWidget {
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
  State<ContainerDetailblue> createState() => _ContainerDetailblueState();
}

class _ContainerDetailblueState extends State<ContainerDetailblue> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*.15,
      decoration: BoxDecoration(
          color: Constants.Primary,
           //orderRadius: BorderRadius.circular(12)
           ),
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
                      widget.quantity,
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
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FittedBox(
                    child: Text(
                  widget.vehicleType,
                  style: Constants.heading2.copyWith(color: Constants.White),
                )),
                FittedBox(
                    child: Text(
                  "${widget.weight} ${widget.material}",
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
