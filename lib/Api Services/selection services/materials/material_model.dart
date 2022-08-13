// To parse this JSON data, do
//
//     final getMaterialModel = getMaterialModelFromJson(jsonString);

import 'dart:convert';

GetMaterialModel getMaterialModelFromJson(String str) => GetMaterialModel.fromJson(json.decode(str));

String getMaterialModelToJson(GetMaterialModel data) => json.encode(data.toJson());

class GetMaterialModel {
    GetMaterialModel({
        this.status,
        this.data,
    });

    bool? status;
    List<Datum>? data;

    factory GetMaterialModel.fromJson(Map<String, dynamic> json) => GetMaterialModel(
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
        this.name,
    });

    String? name;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}
