// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:meribiltyapp/Api%20Services/selection%20services/get%20vehicle%20data/vehicle_data_getx_controller.dart';
// import 'package:meribiltyapp/config/constants.dart';

// import 'package:meribiltyapp/widgets/btns_all.dart';

// import 'Select Weight & Material.dart';

// class VehicleStep1Selection extends StatefulWidget {
//   const VehicleStep1Selection({Key? key, required this.type}) : super(key: key);
//   final int type;
//   @override
//   State<VehicleStep1Selection> createState() => _VehicleSelectionState();
// }

// class _VehicleSelectionState extends State<VehicleStep1Selection> {
//   String image = 'assets/images/vehicle_images/suzuki.png';

//   // List<int> _loadingcounter = [];
//   List<int> selectedIndexesVehicle = [];

//   //int _count = 0;
//   int? selectedIndex;
//   List<int> _counter = [];
//   VehicleDataStrp1Controller _vehicledata =
//       Get.put(VehicleDataStrp1Controller());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Column(
//           children: [
//             Text(
//               'Step 1',
//               style: Constants.heading3.copyWith(color: Colors.white),
//             ),
//             Text(
//               'Select Vehicle',
//               style: Constants.heading3.copyWith(color: Colors.white),
//             ),
//           ],
//         ),
//         centerTitle: true,
//         backgroundColor: Constants.Primary,
//         leading: InkWell(
//           child: Icon(FontAwesomeIcons.chevronLeft),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   _vehicledata.fetchVehicleStep1();
//                 },
//                 child: Text("TEST")),
//             Obx(() {
//               if (_vehicledata.isLoading == true) {
//                 return Center(child: CircularProgressIndicator());
//               } else {
//                 return ListView.builder(
//                     itemCount: _vehicledata.vehicleData[0].data!.length,
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       if (_counter.length <
//                           _vehicledata.vehicleData[0].data!.length) {
//                         _counter.add(1);
//                       }

//                       if (_vehicledata.vehicleCounter.length <
//                           _vehicledata.vehicleData[0].data!.length) {
//                         _vehicledata.vehicleCounter.add(0);
//                       }
//                       return ListTile(
//                         onTap: () {
//                           setState(() {
//                             if (selectedIndexesVehicle.contains(index)) {
//                               selectedIndexesVehicle.remove(index);

//                               _vehicledata.vehicleCounter[index] = 0;
//                               _vehicledata.removeallofsameid(
//                                   _vehicledata.vehicleData[0].data![index].id);
//                             } else {
//                               selectedIndexesVehicle.add(index);

//                               _vehicledata.addtoHomeScreen(
//                                   _vehicledata.vehicleData[0].data![index].id);
//                             }
//                           });
//                         },
//                         tileColor: selectedIndexesVehicle.contains(index)
//                             ? Constants.Primary
//                             : null,
//                         leading: CircleAvatar(
//                           backgroundColor: Colors.white,
//                           radius: 30,
//                           backgroundImage: NetworkImage(
//                             '${_vehicledata.vehicleData[0].data![index].vehicleImage}',
//                           ),
//                         ),
//                         title: Text(
//                           '${_vehicledata.vehicleData[0].data![index].vehicleType}',
//                           style: Constants.heading4.copyWith(
//                               color: selectedIndexesVehicle.contains(index)
//                                   ? Colors.white
//                                   : Color(0xff2F4D84)),
//                         ),
//                         subtitle: Text(
//                             "Max Limit ${'${_vehicledata.vehicleData[0].data![index].vehicleLimit}'} Tons",
//                             style:
//                                 Constants.regular4.copyWith(color: Colors.grey)
//                             // selectedIndex == index
//                             //     ? Colors.white
//                             //     : Color(0xff2F4D84)),
//                             ),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             OutlinedButton(
//                                 style: ButtonStyle(
//                                   shape: MaterialStateProperty.all<
//                                           RoundedRectangleBorder>(
//                                       RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(18.0),
//                                           side: BorderSide(
//                                               color: selectedIndexesVehicle
//                                                       .contains(index)
//                                                   ? Colors.white
//                                                   : Color(0xff2F4D84),
//                                               width: 3))),
//                                   minimumSize: MaterialStateProperty.all(
//                                       const Size(20, 20)),
//                                   maximumSize: MaterialStateProperty.all(
//                                       const Size(39, 36)),
//                                 ),
//                                 onPressed: () {
//                                   !selectedIndexesVehicle.contains(index)
//                                       ? null
//                                       : _vehicledata.vehicleCounter[index] > 1
//                                           ? setState(() {
//                                               _vehicledata.removeFromHomeScreen(
//                                                   _vehicledata.vehicleData[0]
//                                                       .data![index].id);
//                                               _vehicledata
//                                                   .vehicleCounter[index]--;
//                                             })
//                                           : null;
//                                 },
//                                 child: Text(
//                                   "-",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                       color:
//                                           selectedIndexesVehicle.contains(index)
//                                               ? Colors.white
//                                               : Color(0xff2F4D84)),
//                                 )),
//                             Text(
//                               !selectedIndexesVehicle.contains(index)
//                                   ? "0"
//                                   : _vehicledata.vehicleCounter[index]
//                                       .toString(),
//                               style: TextStyle(
//                                   color: selectedIndexesVehicle.contains(index)
//                                       ? Colors.white
//                                       : Color(0xff2F4D84)),
//                             ),
//                             OutlinedButton(
//                                 style: ButtonStyle(
//                                   shape: MaterialStateProperty.all<
//                                           RoundedRectangleBorder>(
//                                       RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(18.0),
//                                     side: BorderSide(),
//                                   )),
//                                   minimumSize: MaterialStateProperty.all(
//                                       const Size(20, 20)),
//                                   maximumSize: MaterialStateProperty.all(
//                                       const Size(39, 36)),
//                                 ),
//                                 onPressed: () {
//                                   !selectedIndexesVehicle.contains(index)
//                                       ? null
//                                       : setState(() {
//                                           _vehicledata.addtoHomeScreen(
//                                               _vehicledata.vehicleData[0]
//                                                   .data![index].id);
//                                           _vehicledata.vehicleCounter[index]++;
//                                         });
//                                 },
//                                 child: Text(
//                                   "+",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                       color:
//                                           selectedIndexesVehicle.contains(index)
//                                               ? Colors.white
//                                               : Color(0xff2F4D84)),
//                                 )),
//                           ],
//                         ),
//                       );
//                     });
//               }
//             }),
//             CustomBtn(
//                 outlinebtn: false,
//                 onpreased: () {
//                   print(_vehicledata.vehicleCounter);

//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => WeightAndMaterial(
//                                 type: widget.type,
//                               )));
//                   print(selectedIndexesVehicle);
//                 },
//                 text: ("Next")),
//           ],
//         ),
//       ),
//     );
//   }
// }
