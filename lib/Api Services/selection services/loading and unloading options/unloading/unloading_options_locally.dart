// To parse this JSON data, do
//
//     final getLoadingOptionsModel = getLoadingOptionsModelFromJson(jsonString);

// import 'dart:convert';

// SetLoadingOptionsModel setLoadingOptionsModelFromJson(String str) => SetLoadingOptionsModel.fromJson(json.decode(str));

// String setLoadingOptionsModelToJson(SetLoadingOptionsModel data) => json.encode(data.toJson());



class UnLoadingSelectedData {
    UnLoadingSelectedData({
        required this.id,
        required this.image,
        required this.name,
        required this.weight,
    });

    String? id;
    String? image;
    String? name;
    dynamic weight;

    factory UnLoadingSelectedData.fromJson(Map<String, dynamic> json) => UnLoadingSelectedData(
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
