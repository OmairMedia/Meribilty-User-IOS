import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/home/drawer_User.dart';
import 'package:meribiltyapp/screens/home/home.dart';
import 'package:meribiltyapp/widgets/get%20delieveries%20cards/activeDelieveries.dart';
import 'package:meribiltyapp/widgets/get%20delieveries%20cards/fetchCompletedDelieveries.dart';
import 'package:meribiltyapp/widgets/get%20delieveries%20cards/fetchPendingDelieveries.dart';
import 'package:meribiltyapp/widgets/get%20delieveries%20cards/fetchUpCountryActiveDelieveries.dart';
import 'package:meribiltyapp/widgets/get%20delieveries%20cards/fetchUpCountryPendingDeieveries.dart';
import 'package:meribiltyapp/widgets/get%20delieveries%20cards/fetchUpcountryCompletedDelieveries.dart';
import 'package:meribiltyapp/widgets/get_deliveries.dart';

class MyDeliveries extends StatefulWidget {
  const MyDeliveries({Key? key}) : super(key: key);

  @override
  State<MyDeliveries> createState() => _MyDeliveriesState();
}

class _MyDeliveriesState extends State<MyDeliveries> {
  int filter = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => Home()), (route) => false);
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          print("Refresh");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> MyDeliveries()));
        },
        child: Scaffold(
          key: _key,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            actions: [
               TextButton(onPressed: (){
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyDeliveries()));
          }, child: Text("Refresh",style: Constants.regular4.copyWith(color: Constants.White),)),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: DropDownMenuFb1(
                  icon: Icon(FontAwesomeIcons.filter),
                  menuList: [
                    PopupMenuItem(
                      child: Text('All Deliveries'),
                      onTap: () {
                        setState(() {
                          filter = 0;
                        });
                        ;
                      },
                    ),
                    PopupMenuItem(
                      child: Text('Active Deliveries'),
                      onTap: () {
                        setState(() {
                          filter = 1;
                        });
                      },
                    ),
                    // PopupMenuItem(
                    //   child: Text('Pending Deliveries'),
                    //   onTap: () {
                    //     setState(() {
                    //       filter = 2;
                    //     });
                    //   },
                    // ),
                    PopupMenuItem(
                      child: Text('Completed Deliveries'),
                      onTap: () {
                        setState(() {
                          filter = 2;
                        });
                      },
                    ),
                  ],
                ),
              ),
            
            ],
            title: Text(
              "My Deliveries",
              style: Constants.regular4.copyWith(color: Constants.White),
            ),
            backgroundColor: Constants.Primary,
            elevation: 0,
            leading: Builder(
                builder: (context) => // Ensure Scaffold is in context
                    IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () => Scaffold.of(context).openDrawer())),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    child: checkFilter())),
          ),
          drawer: Drawer(
            elevation: 5,
            child: SingleChildScrollView(
              child: Column(
                children: [CustomDrawerHeader(), CustomDrawerBody()],
              ),
            ),
          ),
        ),
      ),
    );
  }

  checkFilter() {
    if (filter == 0) {
      return Column(children: [
        FetchActiveDelieveries(),
        // FetchUpCountryActiveDelieveries(),
        
        // FetchUpCountryPendingDelieveries(),
        FetchCompletedDelieveries(),
        // FetchUpCountryCompletedDeleiveries()
      ]);
    } else if (filter == 1) {
      return Column(
        children: [
          FetchActiveDelieveries(),
          //FetchUpCountryActiveDelieveries(),
        ],
      );
    } 
    // else if (filter == 2) {
    //   return Column(
    //     children: [
    //       FetchPendingDelieveries(),
    //       //FetchUpCountryPendingDelieveries(),
    //     ],
    //   );
    // }
     else if (filter == 2) {
      return Column(
        children: [
          FetchCompletedDelieveries(),
          //FetchUpCountryCompletedDeleiveries()
        ],
      );
    }
  }
}

class DropDownMenuFb1 extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Color color;
  final Widget icon;

  const DropDownMenuFb1(
      {required this.menuList,
      this.color = Colors.white,
      this.icon = const Icon(
        Icons.more_vert,
        color: Color(0xff4338CA),
      ),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (val) {
        print(val);
      },
      color: color,
      child: Container(
        height: 32,
        width: 30,
        alignment: Alignment.centerRight,
        child: icon,
      ),
      itemBuilder: (BuildContext context) => menuList,
    );
  }
}
