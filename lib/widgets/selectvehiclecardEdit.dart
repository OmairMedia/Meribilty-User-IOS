import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:meribiltyapp/Api%20Services/vehicle%20selection/add_vehicle.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:meribiltyapp/Api%20Services/vehicle%20selection/get_vehicle_service_with_getx.dart';
// import 'package:meribiltyapp/Api%20Services/vehicle%20selection/get_vehicles_selections.dart';
// import 'package:meribiltyapp/Api%20Services/vehicle%20selection/remove_vehicle.dart';
// import 'package:meribiltyapp/Api%20Services/vehicle%20selection/vehicle_selection_data_service.dart';
import 'package:meribiltyapp/config/constants.dart';

import '../Api Services/vehicle selection/vehicle_selection_data_service.dart';
//import 'package:meribiltyapp/widgets/btns_all.dart';

class SelectVehicleOptionEdit extends StatefulWidget {
  const SelectVehicleOptionEdit({Key? key, required this.vehicleTypeEdit,required this.vehicleQuantityEdit,required this.vehicleOptionEdit,required this.optionQuantityEdit,required this.weightEdit,required this.materialEdit}) : super(key: key);
  final vehicleTypeEdit;
  final vehicleQuantityEdit;
  final vehicleOptionEdit;
  final optionQuantityEdit;
  final weightEdit;
  final materialEdit;

  @override
  _SelectVehicleState createState() => _SelectVehicleState();
}

class _SelectVehicleState extends State<SelectVehicleOptionEdit> {
  final List<bool> _selected = List.generate(5, (index) => false);
  final List<bool> _selected1 = List.generate(5, (index) => false);
  final List<bool> _selected3 = List.generate(5, (index) => false);
  final List<bool> _selected2 = List.generate(5, (index) => false);
  GetVehicleSelectionDataController _getVehicleSelectionDataController =
      Get.put(GetVehicleSelectionDataController());
  int? selectIndexVehicle;
  int? selectIndexlabour;
  int? selectIndexMaterial1;
  int? selectIndexMaterial2;
  bool vehicleSelected = true;
  bool laborOptionSelected = true;
  bool MaterialOptionSelected1 = true;
  bool MaterialOptionSelected2 = true;
  var vehicleOptionSelect;
  var vehicleTypeSelect;
  var vehicleQuantity = 1;
  var optionQuantity = 1;
  var num1 = 1;
  var num2 = 1;
  var list1 = [
    "20 Feet Container",
    "10 Feet Container",
    "30 Feet Container",
    "40 Feet Container",
    "5 Feet Container",
  ];
  var vehicleType = ["Pickup", "Shehzor", "Mazda", "Pickup", "Pickup"];
  var loadingOpt = [
    
    "Labour",
    "Crane 0-15",
    "Crane 15-20",
    "Crane 25-30",
    "Lifter 3-4",
    "Lifter 5-7",
    "Lifter 8-10",
  ];
  var tellus = [
    "Electronics",
    "Building Material",
    "Food",
    "Crops",
    "Appareal",
  ];
  var weights = [
    "Less Than 1 Ton",
    "Between 3 - 5",
    "Between 5 - 8",
    "More Than 8",
  ];
  var images = [
    "assets/water.png",
    "assets/water.png",
    "assets/water.png",
    "assets/water.png",
    "assets/water.png",
  ];
  var images2 = [
    "assets/water.png",
    "assets/water.png",
    "assets/water.png",
    "assets/water.png",
    "assets/water.png",
  ];
  var images3 = [
    "assets/cement.png",
    "assets/cement.png",
    "assets/cement.png",
    "assets/cement.png",
    "assets/cement.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 26,
            )),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [     
              Text("Select Vehicle Type",
                  style: Constants.heading2.copyWith(color: Constants.Grey)),
              const SizedBox(height: 5.0),
              SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100.0,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: vehicleType.length,
                                itemBuilder: (BuildContext context, int index) {
                                  //Color backgroundColor;
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          child: Stack(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    "assets/water.png"),
                                                radius: 30,
                                                backgroundColor:
                                                    selectIndexVehicle ==
                                                                index &&
                                                            vehicleSelected ==
                                                                false
                                                        ? Constants.Secondary
                                                        : Colors.transparent,
                                              ),
                                              // if(vehicleSelected == false && selectIndexVehicle == index)
                                              // Positioned(
                                              //   height: 0,
                                              //   right: 0,
                                              //   child: Icon(
                                              //     Icons.check,
                                              //     color: Constants.Secondary,
                                              //     )
                                              //   )
                                            ],
                                          ),
                                          onTap: () {
                                            if (vehicleSelected) {
                                              setState(() {
                                                selectIndexVehicle = index;
                                                vehicleSelected =
                                                    !vehicleSelected;
                                              });
                                            } else {
                                              setState(() {
                                                selectIndexVehicle == index
                                                    ? {
                                                        vehicleSelected =
                                                            !vehicleSelected,
                                                        selectIndexVehicle =
                                                            null
                                                      }
                                                    : null;
                                              });
                                            }
                                          },
                                        ),
                                        Text(
                                          _getVehicleSelectionDataController
                                              .selectionDataList[0]
                                              .vehicleTypes![index],
                                          // vehicleType[index],
                                          style: Constants.heading5
                                              .copyWith(color: Constants.Black),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          if (vehicleSelected == false)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.red,
                                    ),
                                    height: 28,
                                    width: 28,
                                    child: Icon(
                                      Icons.remove,
                                      size: 15,
                                    ),
                                  ),
                                  onTap: vehicleQuantity == 1
                                      ? () {}
                                      : () {
                                          setState(() {
                                            --vehicleQuantity;
                                          });
                                        },
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.blue,
                                    ),
                                    height: 28,
                                    width: 28,
                                    child: Center(
                                        child: Text(
                                      vehicleQuantity.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Constants.White),
                                    ))),
                                SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.green,
                                    ),
                                    height: 28,
                                    width: 28,
                                    child: Icon(
                                      Icons.add,
                                      size: 15,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      ++vehicleQuantity;
                                    });
                                  },
                                )
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text("Select Loading and Unloading option",
                  style: Constants.heading3.copyWith(color: Constants.Grey)),
              const SizedBox(height: 5.0),
              SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100.0,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: loadingOpt.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          child: CircleAvatar(
                                            backgroundImage:
                                                AssetImage("assets/car.png"),
                                            radius: 30,
                                            backgroundColor:
                                                selectIndexlabour == index &&
                                                        laborOptionSelected ==
                                                            false
                                                    ? Constants.Secondarylight
                                                    : Colors.transparent,
                                          ),
                                          onTap: () {
                                            if (laborOptionSelected) {
                                              setState(() {
                                                selectIndexlabour = index;
                                                laborOptionSelected =
                                                    !laborOptionSelected;
                                              });
                                            } else {
                                              setState(() {
                                                selectIndexlabour == index
                                                    ? {
                                                        laborOptionSelected =
                                                            !laborOptionSelected,
                                                        selectIndexlabour = null
                                                      }
                                                    : null;
                                              });
                                            }
                                          },
                                        ),
                                        Text(
                                          loadingOpt[index],
                                          style: Constants.heading5
                                              .copyWith(color: Constants.Black),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          if (laborOptionSelected == false)
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.red,
                                      ),
                                      height: 28,
                                      width: 28,
                                      child: Icon(
                                        Icons.remove,
                                        size: 15,
                                      ),
                                    ),
                                    onTap: optionQuantity == 1
                                        ? () {}
                                        : () {
                                            setState(() {
                                              --optionQuantity;
                                            });
                                          },
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.blue,
                                      ),
                                      height: 28,
                                      width: 28,
                                      child: Center(
                                          child: Text(
                                        optionQuantity.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Constants.White),
                                      ))),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.green,
                                      ),
                                      height: 28,
                                      width: 28,
                                      child: Icon(
                                        Icons.add,
                                        size: 15,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        ++optionQuantity;
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text("Tell us about the material",
                  style: Constants.heading3.copyWith(color: Constants.Grey)),
              const SizedBox(height: 5.0),
              SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 100.0,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: _getVehicleSelectionDataController
                                .selectionDataList[0].materials!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      child: Stack(children: [
                                        Container(
                                            height: 60.0,
                                            child: const Image(
                                                image: AssetImage(
                                              'assets/cement.png',
                                            ))),
                                        selectIndexMaterial1 == index
                                            ? Positioned(
                                                top: 0,
                                                right: 20,
                                                child: Icon(
                                                  Icons.check,
                                                  color: Constants.Primary,
                                                ))
                                            : Positioned(child: SizedBox())
                                      ]),
                                      onTap: () {
                                        if (MaterialOptionSelected1) {
                                          setState(() {
                                            selectIndexMaterial1 = index;
                                          });
                                        } else {
                                          setState(() {
                                            selectIndexMaterial1 = null;

                                            return null;
                                          });
                                        }
                                        print(selectIndexMaterial1.toString());
                                      },
                                    ),
                                    Text(
                                      "${_getVehicleSelectionDataController.selectionDataList[0].materials![index]}",
                                      style: Constants.heading5
                                          .copyWith(color: Constants.Black),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              Text("Tell Us about the material",
                  style: Constants.heading3.copyWith(color: Constants.Grey)),
              const SizedBox(height: 5.0),
              SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 30.0,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: weights.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        child: Text(
                                          "${weights[index]}",
                                          style: Constants.heading5.copyWith(
                                              color:
                                                  selectIndexMaterial2 == index
                                                      ? Constants.Primary
                                                      : Constants.Black,
                                                      fontWeight: selectIndexMaterial2 == index
                                                      ?FontWeight.w900:FontWeight.w600),
                                        ),
                                      ),
                                      onTap: () {
                                        if (MaterialOptionSelected2) {
                                          setState(() {
                                            selectIndexMaterial2 = index;
                                          });
                                        } else {
                                          setState(() {
                                            selectIndexMaterial2 = null;
                                            return null;
                                          });
                                        }
                                      },
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 3,
                color: Constants.Grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'CANCEL',
                        style:
                            Constants.heading1.copyWith(color: Constants.Grey),
                      )),
                  Divider(thickness: 3, color: Constants.Grey),
                  TextButton(
                      onPressed: () {
                        if (selectIndexVehicle == null) {
                          Get.snackbar("Please Select Vehicle Type", " ",
                              colorText: Colors.red);
                        } else if (selectIndexlabour == null) {
                          Get.snackbar("Please Select One Loading Option", " ",
                              colorText: Colors.red);
                        } else if (selectIndexMaterial1 == null) {
                          Get.snackbar("Please Select Material", " ",
                              colorText: Colors.red);
                        } else if (selectIndexMaterial2 == null) {
                          Get.snackbar("Please Select Weight", " ",
                              colorText: Colors.red);
                        } else {
                          // print(loadingOpt[selectIndexlabour!],);
                          addVehicle(
                              type: _getVehicleSelectionDataController
                                  .selectionDataList[0]
                                  .vehicleTypes![selectIndexVehicle!],
                              option: loadingOpt[selectIndexlabour!],
                              vehicle_quantity: vehicleQuantity,
                              weight: weights[selectIndexMaterial2!],
                              material: _getVehicleSelectionDataController
                                  .selectionDataList[0]
                                  .materials![selectIndexMaterial1!],
                              option_quantity: optionQuantity);
                          // print([_getVehicleSelectionDataController
                          //         .selectionDataList[0]
                          //         .vehicleTypes![selectIndexVehicle!], loadingOpt[selectIndexlabour!],vehicleQuantity,weights[selectIndexMaterial2!],
                          //         _getVehicleSelectionDataController
                          //         .selectionDataList[0]
                          //         .materials![selectIndexMaterial1!],optionQuantity

                          // ]);
                        }
                      },
                      child: Text(
                        'EDIT NOW',
                        style: Constants.heading1
                            .copyWith(color: Constants.Primary),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
