import 'package:flutter/material.dart';
import 'package:meribiltyapp/config/constants.dart';

class BiltyStatusCheckPoints extends StatefulWidget {
  const BiltyStatusCheckPoints({ Key? key }) : super(key: key);

  @override
  _BiltyStatusCheckPointsState createState() => _BiltyStatusCheckPointsState();
}

class _BiltyStatusCheckPointsState extends State<BiltyStatusCheckPoints> {
  @override
  Widget build(BuildContext context) {
    return Stepper(
        
       
        steps: <Step>[
          Step(
            title: const Text('Order Time'),
            content: Text("9 Sept 2021 05:51PM",style: Constants.regular4.copyWith(color: Constants.Black),),
          ),
          Step(
           title: const Text('Offer Receiving Time'),
            content: Text("9 Sept 2021 06:00PM",style: Constants.regular4.copyWith(color: Constants.Black)),
          ),
           Step(
           title: const Text('Offer Acceptance Time'),
            content: Text("9 Sept 2021 06:20PM",style: Constants.regular4.copyWith(color: Constants.Black)),
          ),
           Step(
           title: const Text('Delivery Pickup Time'),
            content: Text("10 Sept 2021 03:00PM",style: Constants.regular4.copyWith(color: Constants.Black)),
          ),
            Step(
           title: const Text('Delivery Pickup Time'),
            content: Text("10 Sept 2021 03:00PM",style: Constants.regular4.copyWith(color: Constants.Black)),
          ),
           Step(
           title: const Text('Delivery Arrival Time'),
            content: Text("14 Sept 2021 05:00PM",style: Constants.regular4.copyWith(color: Constants.Black)),
          ),
           Step(
           title: const Text('Delivery Unloading Time'),
            content: Text("14 Sept 2021 09:00PM",style: Constants.regular4.copyWith(color: Constants.Black)),
          ),
          Step(
           title: const Text('Container Return Time'),
            content: Text("16 Sept 2021 07:00PM",style: Constants.regular4.copyWith(color: Constants.Black)),
          ),
        ],
    );
  }
}