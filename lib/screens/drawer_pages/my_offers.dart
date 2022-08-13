import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/home/drawer_User.dart';
import 'package:meribiltyapp/widgets/get_offers.dart';

import '../../widgets/get delieveries cards/fetchPendingDelieveries.dart';
import '../../widgets/get offers cards/NewRejctedCard.dart';
import '../../widgets/get offers cards/finding_best_rates.dart';
import '../../widgets/new cards/Transit_waiting_admin.dart';
import '../../widgets/new cards/transit_Offer_rejected.dart';
import '../../widgets/new cards/transit_counterByVendor_recieved.dart';
import '../../widgets/new cards/transit_offer_counter.dart';
import '../../widgets/new cards/transit_offer_recieved.dart';
import '../../widgets/new cards/transit_userCounter_accepted_byVendor.dart';
import 'my_deliveries.dart';

class MyOffers extends StatefulWidget {
  const MyOffers({Key? key}) : super(key: key);

  @override
  _MyOffersState createState() => _MyOffersState();
}

class _MyOffersState extends State<MyOffers> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int filter = 8;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "My Requests",
          style: Constants.regular4.copyWith(color: Constants.White),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyOffers()));
              },
              child: Text(
                "Refresh",
                style: Constants.regular4.copyWith(color: Constants.White),
              )),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: DropDownMenuFb1(
              icon: Icon(FontAwesomeIcons.filter),
              menuList: [
                PopupMenuItem(
                  child: Text("All Requests"),
                  onTap: () {
                    setState(() {
                      filter = 8;
                    });
                  },
                ),
                PopupMenuItem(
                  child: Text("Finding Best Rates"),
                  onTap: () {
                    setState(() {
                      filter = 0;
                    });
                  },
                ),
                // PopupMenuItem(
                //   child: Text("Pending Orders"),
                //   onTap: () {
                //     setState(() {
                //       filter = 1;
                //     });
                //   },
                // ),
                PopupMenuItem(
                  child: Text("Offer Recieved"),
                  onTap: () {
                    setState(() {
                      filter = 2;
                    });
                  },
                ),
                 PopupMenuItem(
                  child: Text('Counter Offer Sent'),
                  onTap: () {
                    setState(() {
                      filter = 5;
                    });
                    ;
                  },
                ),
                PopupMenuItem(
                  child: Text("Counter Offer Recieved"),
                  onTap: () {
                    setState(() {
                      filter = 6;
                    });
                  },
                ),
                PopupMenuItem(
                  child: Text("Accepted By Vendor"),
                  onTap: () {
                    setState(() {
                      filter = 7;
                    });
                  },
                ),
                PopupMenuItem(
                  child: Text("Offer Rejected"),
                  onTap: () {
                    setState(() {
                      filter = 3;
                    });
                  },
                ),
                PopupMenuItem(
                  child: Text("Waiting For Admin Approval"),
                  onTap: () {
                    setState(() {
                      filter = 4;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
        backgroundColor: Constants.Primary,
        elevation: 0,
        leading: Builder(
            builder: (context) => // Ensure Scaffold is in context
                IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openDrawer())),
      ),
      body: RefreshIndicator(
        edgeOffset: 20,
        displacement: 80,
        onRefresh: () async {
          await Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyOffers()));
          // await Future.delayed(Duration(milliseconds: 1));
        },
        child: SingleChildScrollView(
          child: SafeArea(
              child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            child: Column(children: [
              CheckOfferFilter(),
              // FutureBuilder(
              //   future: fetchVendorCounteredDeliveries(),
              //   builder: (context, AsyncSnapshot snap) {
              //     if (snap.connectionState == ConnectionState.none ||
              //         !snap.hasData ) {
              //       return Center(child: SizedBox());
              //     } else if (snap.hasError) {
              //       return Center(child: Text(""));
              //     } else if (snap.hasData) {
              //       return Column(
              //         children: [
              //          ListView.builder(
              //                   shrinkWrap: true,
              //                   physics: ScrollPhysics(),
              //                   itemCount: snap.data['accepted']?.length,
              //                   itemBuilder: (BuildContext context, int i) {
              //                     return OfferAcceptedCard(
              //                         status: 'Vendor Counter accepted by user',
              //                         colored: Colors.indigo,
              //                         data: snap.data['accepted']?[i]);
              //                   },
              //                 )
              // ],
              //       );
              //     } else {
              //       return Center(child: Text("Error Pending Orders"));
              //     }
              //   }),
            ]),
          )),
        ),
      ),
      drawer: Drawer(
        elevation: 5,
        child: SingleChildScrollView(
          child: Column(
            children: [CustomDrawerHeader(), CustomDrawerBody()],
          ),
        ),
      ),
    );
  }

  CheckOfferFilter() {
    if (filter == 0) {
      return FindingRates();
    }
    // else if(filter == 1){
    //   return FetchPendingDelieveries();
    // }
    else if (filter == 2) {
      return TransitOfferRecieved();
    } else if (filter == 3) {
      return Recjected_All();
    } else if (filter == 4) {
      return TransitWaitingAdminApproval();
    } else if (filter == 5) {
      return CounteredByUserSent();
    } else if (filter == 6) {
      return CounteredByVendorRecieved();
    } else if (filter == 7) {
      return UserCounterAcceptedByVendor();
    } else if (filter == 8) {
      return Column(
        children: [
          FindingRates(),
          //FetchPendingDelieveries(),
          TransitOfferRecieved(),
          CounteredByUserSent(),
          CounteredByVendorRecieved(),
          UserCounterAcceptedByVendor(),
          Recjected_All(),
          TransitWaitingAdminApproval(),
        ],
      );
    }
  }
}
