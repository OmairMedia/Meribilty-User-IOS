// To parse this JSON data, do
//
//     final getLoadingOptionsModel = getLoadingOptionsModelFromJson(jsonString);

import 'dart:convert';

GetLoadingOptionsModel getLoadingOptionsModelFromJson(String str) => GetLoadingOptionsModel.fromJson(json.decode(str));

String getLoadingOptionsModelToJson(GetLoadingOptionsModel data) => json.encode(data.toJson());

class GetLoadingOptionsModel {
    GetLoadingOptionsModel({
        this.status,
        this.data,
    });

    bool? status;
    List<Datum>? data;

    factory GetLoadingOptionsModel.fromJson(Map<String, dynamic> json) => GetLoadingOptionsModel(
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
        "weight": weight
    };
}
