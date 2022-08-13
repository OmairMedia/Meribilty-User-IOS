// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meribiltyapp/Api%20Services/vehicle%20selection/get_vehicle_service_with_getx.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/ppl/home.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
import 'package:meribiltyapp/widgets/selectvehiclecard.dart';

class SelectVehicle extends StatefulWidget {
  const SelectVehicle({Key? key}) : super(key: key);

  @override
  _SelectVehicleState createState() => _SelectVehicleState();
}

class _SelectVehicleState extends State<SelectVehicle> {
  GetVehicleController _getVehicleController = GetVehicleController();
  void initState() {
    super.initState();
    _getVehicleController.fetchVehicle();
  }

  File? clearingForm;
  File? detailPackingList;
  XFile? clearingFormf;
  XFile? detailPackingListf;

  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Vehicle',
          style: Constants.heading3.copyWith(color: Constants.Primary),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.chevronLeft),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Constants.Primary,
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: const [SingleVehicleSelectionCard()],
          ),
        ),
      ),
    );
  }
}

// void addVehicleSelctionModel(context) {
//   String vehicleTypeDropdownValue;
//   String optionDropdownValue;

//   showModalBottomSheet(
//       context: context,
//       builder: (BuildContext buildcontext) {
//         return SingleChildScrollView(
//             child: SafeArea(
//                 child: Container(
//                     child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           child: Column(
//             children: [
//               Text("Vehicle Type",
//                   style: Constants.heading3.copyWith(color: Constants.Primary),
//                   textAlign: TextAlign.center),
//               SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Padding(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Constants.Grey,
//                                   radius: 30,
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "20 Feet Container",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Constants.Grey,
//                                   radius: 30,
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "40 Feet Container",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Constants.Grey,
//                                   radius: 30,
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "20 Feet Flatbed",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Constants.Grey,
//                                   radius: 30,
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "40 Feet Flatbed",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Constants.Grey,
//                                   radius: 30,
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "Shehzore",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Constants.Grey,
//                                   radius: 30,
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "Mazda",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Constants.Grey,
//                                   radius: 30,
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "Labour",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                       ],
//                     ),
//                   )),
//               Text("Loading/Unloading Options",
//                   style: Constants.heading3.copyWith(color: Constants.Primary),
//                   textAlign: TextAlign.center),
//               SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Constants.Grey,
//                                   radius: 30,
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "Lifter 1-3 Ton",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Constants.Grey,
//                                   radius: 30,
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "Lifter 3-5 Ton",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Constants.Grey,
//                                   radius: 30,
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "Lifter 5-7 Ton",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Constants.Grey,
//                                   radius: 30,
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "Crane 3-5 Ton",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Constants.Grey,
//                                   radius: 30,
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "Crane 5-7 Ton",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Constants.Grey,
//                                   radius: 30,
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "Labour",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                       ],
//                     ),
//                   )),
//               Text("Material",
//                   style: Constants.heading3.copyWith(color: Constants.Primary),
//                   textAlign: TextAlign.center),
//               SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Constants.Grey,
//                                   radius: 30,
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "Cement",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Constants.Grey,
//                                   radius: 30,
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "Electronics",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Constants.Grey,
//                                   radius: 30,
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "Food",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Constants.Grey,
//                                   radius: 30,
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "Glass",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Constants.Grey,
//                                   radius: 30,
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "Frozen Items",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                       ],
//                     ),
//                   )),
//               Text("Weight",
//                   style: Constants.heading3.copyWith(color: Constants.Primary),
//                   textAlign: TextAlign.center),
//               SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "+1 Tons",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "+1-3 Tons",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "+3-5 Tons",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   // AppLocalizations.of(context)!.access,
//                                   "+5-8 Tons",
//                                   style: Constants.heading4
//                                       .copyWith(color: Constants.Primary),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )),
//               CustomBtn(
//                   text: "Add",
//                   onpreased: () {
//                     Navigator.of(context).pop();
//                   },
//                   outlinebtn: false)
//             ],
//           ),
//         ))));
//       });
// }