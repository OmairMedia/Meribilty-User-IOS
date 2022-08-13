// import 'package:flutter/material.dart';
// import 'package:meribiltyapp/Api%20Services/AdminApproval/Waiting_for_admin.dart';
// import 'package:meribiltyapp/Api%20Services/deliveries/upcountry/get_upcountry_qoutes_n_counters.dart';
// import 'package:meribiltyapp/Api%20Services/deliveries/transit/get_counter_offers.dart';
// import 'package:meribiltyapp/Api%20Services/deliveries/transit/get_partner_counter_offers.dart';
// import 'package:meribiltyapp/Api%20Services/deliveries/transit/get_pending_orders.dart';
// import 'package:meribiltyapp/Api%20Services/deliveries/transit/get_vendor_qoutes.dart';
// import 'package:meribiltyapp/config/constants.dart';
// import 'package:meribiltyapp/widgets/get%20offers%20cards/finding_best_rates.dart';
// import 'package:meribiltyapp/widgets/transit/Waiting_for_admin.dart';
// import 'package:meribiltyapp/widgets/transit/counterofferreceived.dart';
// import 'package:meribiltyapp/widgets/transit/findingbestrates.dart';
// import 'package:meribiltyapp/widgets/transit/offerrejected.dart';
// import 'package:meribiltyapp/widgets/transit/qouted_delivery_card.dart';
// import 'package:meribiltyapp/widgets/upcountry/qoutes_n_counters_card.dart';

// import 'get delieveries cards/fetchPendingDelieveries.dart';
// import 'new cards/Transit_waiting_admin.dart';
// import 'new cards/transit_Offer_rejected.dart';
// import 'new cards/transit_counterByVendor_recieved.dart';
// import 'new cards/transit_offer_counter.dart';
// import 'new cards/transit_offer_recieved.dart';
// import 'new cards/transit_userCounter_accepted_byVendor.dart';

// class GetOffers extends StatefulWidget {
//   const GetOffers({Key? key}) : super(key: key);

//   @override
//   State<GetOffers> createState() => _GetOffersState();
// }

// class _GetOffersState extends State<GetOffers> {
//   @override
//   void dispose() {
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         FindingRates(),
//         FetchPendingDelieveries(),
//         TransitOfferRecieved(),
//         TransitOfferRejected(),
//         TransitWaitingAdminApproval(),
//         CounteredByUserSent(),
//         CounteredByVendorRecieved(),
//         UserCounterAcceptedByVendor(),

//         // FutureBuilder(
//         //   future: fetchVendorCounteredDeliveries(),
//         //   builder: (context, AsyncSnapshot snap) {
//         //     if (snap.connectionState == ConnectionState.none ||
//         //         !snap.hasData ) {
//         //       return Center(child: SizedBox());
//         //     } else if (snap.hasError) {
//         //       return Center(child: Text(' '));
//         //     } else if (snap.hasData) {
//         //       return Column(
//         //         children: [
//         //          ListView.builder(
//         //                   shrinkWrap: true,
//         //                   physics: ScrollPhysics(),
//         //                   itemCount: snap.data['accepted']?.length,
//         //                   itemBuilder: (BuildContext context, int i) {
//         //                     return OfferAcceptedCard(
//         //                         status: 'Vendor Counter accepted by user',
//         //                         colored: Colors.indigo,
//         //                         data: snap.data['accepted']?[i]);
//         //                   },
//         //                 )
                      
//         //         ],
//         //       );
//         //     } else {
//         //       return Center(child: Text("Error Pending Orders"));
//         //     }
//         //   }),
      


        
//       ],
//     );
//   }
// }
