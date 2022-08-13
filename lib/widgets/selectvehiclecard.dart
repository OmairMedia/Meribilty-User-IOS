import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:meribiltyapp/Api%20Services/vehicle%20selection/get_vehicle_service_with_getx.dart';
import 'package:meribiltyapp/Api%20Services/vehicle%20selection/get_vehicles_selections.dart';
import 'package:meribiltyapp/Api%20Services/vehicle%20selection/remove_vehicle.dart';
import 'package:meribiltyapp/Api%20Services/vehicle%20selection/vehicle_selection_data_service.dart';
import 'package:meribiltyapp/config/constants.dart';
import 'package:meribiltyapp/screens/ppl/home.dart';
import 'package:meribiltyapp/widgets/btns_all.dart';
//import 'package:meribiltyapp/widgets/selectvehiclecardEdit.dart';
import 'package:meribiltyapp/widgets/selectvehiclecartAdd.dart';
//import 'package:carousel_slider/carousel_slider.dart';

class SingleVehicleSelectionCard extends StatefulWidget {
  const SingleVehicleSelectionCard({Key? key}) : super(key: key);

  @override
  _SingleVehicleSelectionCardState createState() =>
      _SingleVehicleSelectionCardState();
}

class _SingleVehicleSelectionCardState
    extends State<SingleVehicleSelectionCard> {
  GetVehicleController _getVehicleController = Get.put(GetVehicleController());

  // final List<bool> _selected = List.generate(5, (index) => false);
  // final List<bool> _selected1 = List.generate(5, (index) => false);
  // final List<bool> _selected3 = List.generate(5, (index) => false);
  // final List<bool> _selected2 = List.generate(5, (index) => false);
  var num1 = 0;

  @override
  void oninit() async {
    _getVehicleController.fetchVehicle();
    super.initState();
  }

  GetVehicleSelectionDataController _getVehicleSelectionDataController =
      Get.put(GetVehicleSelectionDataController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        print("object");
      },
      child: SingleChildScrollView(
        //physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Obx(() {
              if (_getVehicleController.isLoading.value) {
                return Column(
                  children: [
                    Center(child: CircularProgressIndicator()),
                  ],
                );
              } else {
                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: _getVehicleController.vehicleList.isEmpty
                          ? 0
                          : _getVehicleController.vehicleList[0].data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Card(
                              elevation: 5.0,
                              color: Constants.White,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Column(
                                      children: [
                                        // const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  _getVehicleController
                                                          .vehicleList.isEmpty
                                                      ? ' No Vehicles'
                                                      : "${_getVehicleController.vehicleList[0].data![index].type}",
                                                  // getve
                                                  //       ? ' '
                                                  //       : _getVehicleController
                                                  //           .vehicleList[0]
                                                  //           .data![index]
                                                  //           .type,
                                                  style: Constants.heading3,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "x${_getVehicleController.vehicleList.isEmpty ? ' ' : _getVehicleController.vehicleList[0].data![index].vehicleQuantity}",
                                                  style: Constants.regular4
                                                      .copyWith(
                                                          color: Constants
                                                              .Primary),
                                                )
                                              ],
                                            ),
                                            // IconButton(
                                            //     onPressed: () {
                                            //       Navigator.push(
                                            //           context,
                                            //           MaterialPageRoute(
                                            //               builder: (BuildContext
                                            //                       context) =>
                                            //                   SelectVehicleOptionEdit(
                                            //                     vehicleQuantityEdit:
                                            //                         _getVehicleController
                                            //                             .vehicleList[
                                            //                                 0]
                                            //                             .data[index]
                                            //                             .vehicleQuantity,
                                            //                     vehicleTypeEdit:
                                            //                         _getVehicleController
                                            //                             .vehicleList[
                                            //                                 0]
                                            //                             .data[index]
                                            //                             .type,
                                            //                     vehicleOptionEdit:
                                            //                         _getVehicleController
                                            //                             .vehicleList[
                                            //                                 0]
                                            //                             .data[index]
                                            //                             .option,
                                            //                     optionQuantityEdit:
                                            //                         _getVehicleController
                                            //                             .vehicleList[
                                            //                                 0]
                                            //                             .data[index]
                                            //                             .optionQuantity,
                                            //                     weightEdit:
                                            //                         _getVehicleController
                                            //                             .vehicleList[
                                            //                                 0]
                                            //                             .data[index]
                                            //                             .weight,
                                            //                     materialEdit:
                                            //                         _getVehicleController
                                            //                             .vehicleList[
                                            //                                 0]
                                            //                             .data[index]
                                            //                             .material[0],
                                            //                   )));
                                            //       // removeVehicle(_getVehicleController
                                            //       //     .vehicleList[0].data[index].id);
                                            //     },
                                            //     icon: Icon(
                                            //       FontAwesomeIcons.edit,
                                            //       size: 15,
                                            //       color: Colors.green,
                                            //     )),
                                            IconButton(
                                                onPressed: () {
                                                  removeVehicle(
                                                      _getVehicleController
                                                          .vehicleList[0]
                                                          .data![index]
                                                          .id);
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.trash,
                                                  size: 15,
                                                  color: Constants.BrightRed,
                                                ))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Loading Option :',
                                                  style: Constants.heading5,
                                                ),
                                                Text(
                                                  'Weight :',
                                                  style: Constants.heading5,
                                                ),
                                                Text(
                                                  'Material Type :',
                                                  style: Constants.heading5,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 25,
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${_getVehicleController.vehicleList.isEmpty ? '' : _getVehicleController.vehicleList[0].data![index].option} x${_getVehicleController.vehicleList[0].data![index].optionQuantity} ",
                                                  style: Constants.regular5,
                                                ),
                                                Text(
                                                  "${_getVehicleController.vehicleList.isEmpty ? '' : _getVehicleController.vehicleList[0].data![index].weight}",
                                                  style: Constants.regular5,
                                                ),
                                                Text(
                                                  _getVehicleController
                                                          .vehicleList.isEmpty
                                                      ? ''
                                                      : _getVehicleController
                                                          .vehicleList[0]
                                                          .data![index]
                                                          .material![0],
                                                  style: Constants.regular5,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // Container(
                                        //   height: 110,
                                        //   child: ListTile(
                                        //     leading: Column(
                                        //      mainAxisSize: MainAxisSize.min,
                                        //       children: [
                                        //         Text(
                                        //           'Loading Option :',
                                        //           style: Constants.heading5,
                                        //         ),
                                        //         Text(
                                        //           'Weight :',
                                        //           style: Constants.heading5,
                                        //         ),

                                        //         Text(
                                        //           'Material Type :',
                                        //           style: Constants.heading5,
                                        //         ),
                                        //       ],
                                        //     ),
                                        //     title: Column(
                                        //       mainAxisSize: MainAxisSize.min,
                                        //       children: [
                                        //         Text(
                                        //           "${_getVehicleController.vehicleList.isEmpty ? '' : _getVehicleController.vehicleList[0].data[index].option} x${_getVehicleController.vehicleList[0].data[index].optionQuantity} ",
                                        //           style: Constants.regular5,
                                        //         ),
                                        //         Text(
                                        //           "${_getVehicleController.vehicleList.isEmpty ? '' : _getVehicleController.vehicleList[0].data[index].weight}",
                                        //           style: Constants.regular5,
                                        //         ),
                                        //         Text(
                                        //           _getVehicleController
                                        //                   .vehicleList.isEmpty
                                        //               ? ''
                                        //               : _getVehicleController
                                        //                   .vehicleList[0]
                                        //                   .data[index]
                                        //                   .material[0],
                                        //           style: Constants.regular5,
                                        //         ),
                                        //         Text("Hello\nworld")

                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    TextButton.icon(
                        // onPressed: () => {addVehicleSelection(context)},
                        onPressed: () {
                          _getVehicleSelectionDataController
                              .fetchSelectionData();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SelectVehicleOption()));
                        },
                        icon: Icon(
                          FontAwesomeIcons.plus,
                          size: 13,
                          color: Constants.Primary,
                        ),
                        label: Text("Add More",
                            style: Constants.heading5
                                .copyWith(color: Constants.Primary))),
                    SizedBox(
                      height: 15,
                    ),
                    CustomBtn(
                        text: "Proceed",
                        onpreased: () {
                          Navigator.pop(context);
                          // Navigator.of(context).pushReplacement(
                          // MaterialPageRoute(builder: (_) => PPLHome()));
                          // Navigator.pop(context, (){setState(() {

                          // });});
                        },
                        outlinebtn: false),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
