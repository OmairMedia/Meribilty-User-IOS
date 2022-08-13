// To parse this JSON data, do
//
//     final getUnloadingOptionsModel = getUnloadingOptionsModelFromJson(jsonString);

import 'dart:convert';

GetUnloadingOptionsModel getUnloadingOptionsModelFromJson(String str) => GetUnloadingOptionsModel.fromJson(json.decode(str));

String getUnloadingOptionsModelToJson(GetUnloadingOptionsModel data) => json.encode(data.toJson());

class GetUnloadingOptionsModel {
    GetUnloadingOptionsModel({
        this.status,
        this.data,
    });

    bool? status;
    List<Datum>? data;

    factory GetUnloadingOptionsModel.fromJson(Map<String, dynamic> json) => GetUnloadingOptionsModel(
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
        this.image,
        this.name,
        this.weight,
    });

    String? id;
    String? image;
    String? name;
    dynamic? weight;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        weight: json["weight"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "weight": weight,
    };
}
