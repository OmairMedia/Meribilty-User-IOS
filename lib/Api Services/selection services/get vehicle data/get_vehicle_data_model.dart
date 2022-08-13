// To parse this JSON data, do
//
//     final getVehicleDataStep1Model = getVehicleDataStep1ModelFromJson(jsonString);

import 'dart:convert';

GetVehicleDataStep1Model getVehicleDataStep1ModelFromJson(String str) => GetVehicleDataStep1Model.fromJson(json.decode(str));

String getVehicleDataStep1ModelToJson(GetVehicleDataStep1Model data) => json.encode(data.toJson());

class GetVehicleDataStep1Model {
    GetVehicleDataStep1Model({
        this.status,
        this.data,
    });

    bool? status;
    List<Datum>? data;

    factory GetVehicleDataStep1Model.fromJson(Map<String, dynamic> json) => GetVehicleDataStep1Model(
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
        this.vehicleImage,
        this.vehicleLimit,
        this.vehicleType,
        this.weights,
        this.vehicleCategory,
    });

    String? id;
    String? vehicleImage;
    var vehicleLimit;
    String? vehicleType;
    List<String>? weights;
    String? vehicleCategory;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        vehicleImage: json["vehicle_image"],
        vehicleLimit: json["vehicle_limit"],
        vehicleType: json["vehicle_type"],
        vehicleCategory: json["vehicle_category"],
        weights: List<String>.from(json["weights"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "vehicle_image": vehicleImage,
        "vehicle_limit": vehicleLimit,
        "vehicle_type": vehicleType,
        "vehicle_category": vehicleCategory,
        "weights": List<dynamic>.from(weights!.map((x) => x)),
    };
}
