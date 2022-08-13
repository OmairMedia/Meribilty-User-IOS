import 'package:flutter/material.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/transit/get_completed_orders.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/upcountry/get_up_active_orders.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/transit/get_active_orders.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/transit/get_vendor_qoutes.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/upcountry/get_up_completed_orders.dart';
import 'package:meribiltyapp/Api%20Services/deliveries/upcountry/get_up_pending_orders.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/widgets/get%20delieveries%20cards/activeDelieveries.dart';
import 'package:meribiltyapp/widgets/get%20delieveries%20cards/fetchCompletedDelieveries.dart';
import 'package:meribiltyapp/widgets/get%20delieveries%20cards/fetchPendingDelieveries.dart';
import 'package:meribiltyapp/widgets/get%20delieveries%20cards/fetchUpCountryActiveDelieveries.dart';
import 'package:meribiltyapp/widgets/get%20delieveries%20cards/fetchUpCountryPendingDeieveries.dart';
import 'package:meribiltyapp/widgets/get%20delieveries%20cards/fetchUpcountryCompletedDelieveries.dart';
import 'package:meribiltyapp/widgets/transit/activeorder.dart';
import 'package:meribiltyapp/widgets/transit/completedorder.dart';
import 'package:meribiltyapp/widgets/transit/qouted_delivery_card.dart';
import 'package:meribiltyapp/widgets/upcountry/delivery_card.dart';

class GetDeliveries extends StatefulWidget {
  const GetDeliveries({Key? key}) : super(key: key);

  @override
  State<GetDeliveries> createState() => _GetDeliveriesState();
}

class _GetDeliveriesState extends State<GetDeliveries> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FetchActiveDelieveries(),
        FetchUpCountryActiveDelieveries(),
        FetchPendingDelieveries(),
        FetchUpCountryPendingDelieveries(),
        FetchCompletedDelieveries(),
        FetchUpCountryCompletedDeleiveries()
      ],
    );
  }
}
