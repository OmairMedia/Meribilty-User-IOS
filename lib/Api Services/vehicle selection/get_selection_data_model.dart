// To parse this JSON data, do
//
//     final getVehicleSelectionDataModel = getVehicleSelectionDataModelFromJson(jsonString);

import 'dart:convert';

GetVehicleSelectionDataModel getVehicleSelectionDataModelFromJson(String str) => GetVehicleSelectionDataModel.fromJson(json.decode(str));

String getVehicleSelectionDataModelToJson(GetVehicleSelectionDataModel data) => json.encode(data.toJson());

class GetVehicleSelectionDataModel {
    GetVehicleSelectionDataModel({
        this.status,
        this.vehicleTypes,
        this.materials,
    });

    bool? status;
    List<String>? vehicleTypes;
    List<String>? materials;

    factory GetVehicleSelectionDataModel.fromJson(Map<String, dynamic> json) => GetVehicleSelectionDataModel(
        status: json["status"],
        vehicleTypes: List<String>.from(json["vehicle_types"].map((x) => x)),
        materials: List<String>.from(json["materials"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "vehicle_types": List<dynamic>.from(vehicleTypes!.map((x) => x)),
        "materials": List<dynamic>.from(materials!.map((x) => x)),
    };
}
