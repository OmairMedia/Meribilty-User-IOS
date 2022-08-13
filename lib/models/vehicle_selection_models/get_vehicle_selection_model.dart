// To parse this JSON data, do
//
//     final getVehicleSelectionModel = getVehicleSelectionModelFromJson(jsonString);

import 'dart:convert';

GetVehicleSelectionModel getVehicleSelectionModelFromJson(String str) => GetVehicleSelectionModel.fromJson(json.decode(str));

String getVehicleSelectionModelToJson(GetVehicleSelectionModel data) => json.encode(data.toJson());

class GetVehicleSelectionModel {
    GetVehicleSelectionModel({
        this.status,
        this.data,
    });

    bool? status;
    List<Datum>? data;

    factory GetVehicleSelectionModel.fromJson(Map<String, dynamic> json) => GetVehicleSelectionModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.material,
        this.option,
        this.optionQuantity,
        this.type,
        this.userPhone,
        this.vehicleQuantity,
        this.weight,
    });

    String? id;
    List<String>? material;
    String? option;
    dynamic? optionQuantity;
    String? type;
    String? userPhone;
    dynamic? vehicleQuantity;
    String? weight;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        material: List<String>.from(json["material"].map((x) => x)),
        option: json["option"],
        optionQuantity: json["option_quantity"],
        type: json["type"],
        userPhone: json["user_phone"],
        vehicleQuantity: json["vehicle_quantity"],
        weight: json["weight"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "material": List<dynamic>.from(material!.map((x) => x)),
        "option": option,
        "option_quantity": optionQuantity,
        "type": type,
        "user_phone": userPhone,
        "vehicle_quantity": vehicleQuantity,
        "weight": weight,
    };
}
