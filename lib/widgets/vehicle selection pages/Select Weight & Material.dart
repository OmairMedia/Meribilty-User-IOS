// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:meribiltyapp/Api%20Services/selection%20services/get%20vehicle%20data/vehicle_data_getx_controller.dart';
// import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/loading/get_loading_controller.dart';
// import 'package:meribiltyapp/Api%20Services/selection%20services/loading%20and%20unloading%20options/unloading/get_unloading_option_controller.dart';
// import 'package:meribiltyapp/Api%20Services/selection%20services/materials/get_material_controller.dart';

// import 'package:meribiltyapp/config/constants.dart';
// import 'package:meribiltyapp/screens/drawer_pages/my_deliveries.dart';

// import 'VehicleSelectionHome.dart';

// class WeightAndMaterial extends StatefulWidget {
//   const WeightAndMaterial({Key? key, required this.type}) : super(key: key);
//   final int type;

//   @override
//   State<WeightAndMaterial> createState() => _WeightAndMaterialState();
// }

// class _WeightAndMaterialState extends State<WeightAndMaterial> {
//   List dropdownValueWeight = [];
//   List selectedmaterials = [];
//   VehicleDataStrp1Controller _vehicledata =
//       Get.put(VehicleDataStrp1Controller());

//   GetMaterialsController _materialController =
//       Get.put(GetMaterialsController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Column(
//           children: [
//             Text(
//               'Step 2',
//               style: Constants.heading3.copyWith(color: Colors.white),
//             ),
//             Text(
//               'Select Weight & Material',
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
//           child: Column(
//         children: [
//           ElevatedButton(
//               onPressed: () {
//                 _materialController.fetchMaterial();
//               },
//               child: Text("data")),

//           ListView.builder(
//               shrinkWrap: true,
//               physics: ScrollPhysics(),
//               itemCount: _vehicledata.selectedVehicles.length,
//               itemBuilder: (context, index) {
//                 if (dropdownValueWeight.length <
//                     _vehicledata.selectedVehicles.length) {
//                   dropdownValueWeight.add("Select Weight");
//                 }
//                 if (selectedmaterials.length <
//                     _vehicledata.selectedVehicles.length) {
//                   selectedmaterials.add("Select Material");
//                 }
//                 return ListTile(
//                   leading: CircleAvatar(
//                     radius: 30,
//                     backgroundColor: Colors.white,
//                     backgroundImage: NetworkImage(
//                       "${_vehicledata.selectedVehicles[index].vehicleImage}",
//                     ),
//                   ),
//                   title: Text(
//                     "${_vehicledata.selectedVehicles[index].vehicleType}",
//                     style: Constants.heading4,
//                   ),
//                   trailing: Padding(
//                     padding: const EdgeInsets.only(top: 17),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           dropdownValueWeight[index] != "Select Weight"
//                               ? "${dropdownValueWeight[index]} Tons"
//                               : "${dropdownValueWeight[index]}",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Constants.Primary),
//                         ),
//                         DropDownMenuFb1(
//                             icon: Icon(Icons.arrow_drop_down),
//                             menuList: [
//                               PopupMenuItem(
//                                 child: SizedBox(
//                                   // height: 170,
//                                   width: 150,
//                                   child: Column(
//                                     children: [
//                                       ListView.builder(
//                                         shrinkWrap: true,
//                                         physics: ScrollPhysics(),
//                                         itemBuilder: (context, ind) {
//                                           return Padding(
//                                             padding:
//                                                 const EdgeInsets.only(left: 10),
//                                             child: GestureDetector(
//                                                 onTap: () {
//                                                   Navigator.pop(context);
//                                                   print(
//                                                     _materialController
//                                                         .Materialdata[0]
//                                                         .data[index]
//                                                         .name,
//                                                   );
//                                                 },
//                                                 child: ListTile(
//                                                   onTap: () {
//                                                     print(
//                                                         "${_vehicledata.selectedVehicles[index].weights![ind]}");
//                                                     setState(() {
//                                                       dropdownValueWeight[
//                                                               index] =
//                                                           "${_vehicledata.selectedVehicles[index].weights![ind]}";
//                                                     });
//                                                     Navigator.pop(context);
//                                                   },
//                                                   title: Text(
//                                                     "${_vehicledata.selectedVehicles[index].weights![ind]}",
//                                                     style: Constants.regular5,
//                                                   ),
//                                                 )),
//                                           );
//                                         },
//                                         itemCount: _vehicledata
//                                             .selectedVehicles[index]
//                                             .weights!
//                                             .length,
//                                       ),
//                                       Container(
//                                         padding:
//                                             const EdgeInsets.only(left: 10),
//                                         width: 145,
//                                         child: TextFormField(
                                          
//                                           keyboardType: TextInputType.number,
//                                           onChanged: (val) {
//                                             setState(() {
//                                               dropdownValueWeight[index] = val;
//                                             });
//                                           },
//                                           decoration: InputDecoration(
//                                             hintText: "   Other",
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ]),
//                       ],
//                     ),
//                   ),
//                   subtitle: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         "${selectedmaterials[index]}",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       DropDownMenuFb1(
//                           icon: Icon(Icons.arrow_drop_down),
//                           menuList: [
//                             PopupMenuItem(
//                               child: SizedBox(
//                                 // height: 170,
//                                 width: 150,
//                                 child: Column(
//                                   children: [
//                                     ListView.builder(
//                                       shrinkWrap: true,
//                                       physics: ScrollPhysics(),
//                                       itemBuilder: (context, ind) {
//                                         return Padding(
//                                           padding:
//                                               const EdgeInsets.only(left: 10),
//                                           child: ListTile(
//                                             onTap: () {
//                                               print(
//                                                   "${_materialController.Materialdata[0].data[ind].name}");
//                                               setState(() {
//                                                 selectedmaterials[index] =
//                                                     "${_materialController.Materialdata[0].data[ind].name}";
//                                               });
//                                               Navigator.pop(context);
//                                             },
//                                             title: Text(
//                                               _materialController
//                                                   .Materialdata[0]
//                                                   .data[ind]
//                                                   .name,
//                                               style: Constants.regular5,
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                       itemCount: _materialController
//                                           .Materialdata[0].data.length,
//                                     ),
//                                     Container(
//                                       padding: const EdgeInsets.only(left: 10),
//                                       width: 145,
//                                       child: TextField(
//                                         onChanged: (val) {
//                                           setState(() {
//                                             selectedmaterials[index] = val;
//                                           });
//                                         },
//                                         decoration: InputDecoration(
//                                           hintText: "   Other",
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ]),
//                     ],
//                   ),
//                 );
//               }),
//           //Spacer(),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12.0),
//                       color: Constants.Primary,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 8.0, horizontal: 46.0),
//                       child: Text(
//                         "Back",
//                         style:
//                             Constants.regular3.copyWith(color: Constants.White),
//                       ),
//                     ),
//                   ),
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//                 InkWell(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12.0),
//                       color: Constants.Primary,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 8.0, horizontal: 46.0),
//                       child: Text(
//                         "Save",
//                         style:
//                             Constants.regular3.copyWith(color: Constants.White),
//                       ),
//                     ),
//                   ),
//                   onTap: () async {
//                     _vehicledata.selectedWeights = dropdownValueWeight;
//                     _vehicledata.selectedMaterials = selectedmaterials;
//                     await _unloadCont.getallValues();
                    
//                     await _vehicCont.getallVehicleForCreateingreq();
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (_) => VehicleSelectionHomePage(
//                               pickupLatLng: widget.pickupLatLng,
//                               dropOffLatLng: widget.dropOffLatLng,
//                               pickup_address: widget.pickup_address,
//                               dropOff_address: widget.dropOff_address,
//                               containerDropOff: widget.containerDropOff,
//                                   type: widget.type,
//                                 )));
//                   },
//                 )
//               ],
//             ),
//           )
//         ],
//       )),
//     );
//   }

//   UnloadingDataController _unloadCont = Get.put(UnloadingDataController());
//   LoadingDataController _loadinCont = Get.put(LoadingDataController());
//   VehicleDataStrp1Controller _vehicCont = Get.put(VehicleDataStrp1Controller());
//   saveMaterialandWeight() async {}
// }
