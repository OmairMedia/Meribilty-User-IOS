import 'dart:convert';

class LoadingForapiModel {
  LoadingForapiModel(
      {required this.name,
      required this.weight,
      required this.quantity,
      required this.image});

  String? name;
  dynamic? weight;
  var quantity = 1;
  String image;

  factory LoadingForapiModel.fromJson(Map<String, dynamic> json) =>
      LoadingForapiModel(
          name: json["name"],
          weight: json["weight"],
          quantity: json["quantity"],
          image: json["image"]);

  Map<String, dynamic> toJson() =>
      {"name": name, "weight": weight, "quantity": quantity, "image": image};
}

class UnLoadingForapiModel {
  UnLoadingForapiModel(
      {required this.name, required this.weight, required this.quantity, required this.image});

  String? name;
  dynamic? weight;
  var quantity = 1;
  String image;

  factory UnLoadingForapiModel.fromJson(Map<String, dynamic> json) =>
      UnLoadingForapiModel(
          name: json["name"],
          weight: json["weight"],
          quantity: json["quantity"],
          image: json["image"]);

  Map<String, dynamic> toJson() =>
      {"name": name, "weight": weight, "quantity": quantity, 
      "image": image};
}

class LoadingForapiModelWithImage {
  LoadingForapiModelWithImage(
      {required this.name,
      required this.weight,
      required this.quantity,
      required this.image});

  String? name;
  dynamic? weight;
  var quantity = 1;
  String image;

  factory LoadingForapiModelWithImage.fromJson(Map<String, dynamic> json) =>
      LoadingForapiModelWithImage(
          name: json["name"],
          weight: json["weight"],
          quantity: json["quantity"],
          image: json["image"]);

  Map<String, dynamic> toJson() =>
      {"name": name, "weight": weight, "quantity": quantity, "image": image};
}

class UnLoadingForapiModelWithImage {
  UnLoadingForapiModelWithImage(
      {required this.name,
      required this.weight,
      required this.quantity,
      required this.image});

  String? name;
  dynamic? weight;
  var quantity = 1;
  String image;

  factory UnLoadingForapiModelWithImage.fromJson(Map<String, dynamic> json) =>
      UnLoadingForapiModelWithImage(
          name: json["name"],
          weight: json["weight"],
          quantity: json["quantity"],
          image: json["image"]);

  Map<String, dynamic> toJson() =>
      {"name": name, "weight": weight, "quantity": quantity, "image": image};
}

class AddVehicleForapiModel {
  AddVehicleForapiModel(
      {required this.name, required this.weight, required this.quantity});

  String? name;
  dynamic? weight;
  var quantity = 1;

  factory AddVehicleForapiModel.fromJson(Map<String, dynamic> json) =>
      AddVehicleForapiModel(
          name: json["name"],
          weight: json["weight"],
          quantity: json["quantity"]);

  Map<String, dynamic> toJson() =>
      {"name": name, "weight": weight, "quantity": quantity};
}

// To parse this JSON data, do
//
//     final addVehicleModel = addVehicleModelFromJson(jsonString);

AddVehicleModel addVehicleModelFromJson(String str) =>
    AddVehicleModel.fromJson(json.decode(str));

String addVehicleModelToJson(AddVehicleModel data) =>
    json.encode(data.toJson());

class AddVehicleModel {
  AddVehicleModel({
    required this.name,
    required this.quantity,
    required this.weight,
    required this.image,
  });

  String name;
  String quantity;
  String weight;
  String image;

  factory AddVehicleModel.fromJson(Map<String, dynamic> json) =>
      AddVehicleModel(
          name: json["name"],
          quantity: json["quantity"],
          weight: json["weight"],
          image: json['image']);

  Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
        "weight": weight,
        "image": image,
      };
}

AddVehicleModelImage addVehicleModelImageFromJson(String str) =>
    AddVehicleModelImage.fromJson(json.decode(str));

String addVehicleModelImageToJson(AddVehicleModelImage data) =>
    json.encode(data.toJson());

class AddVehicleModelImage {
  AddVehicleModelImage(
      {required this.name,
      required this.quantity,
      required this.weight,
      required this.image,
      required this.weightList,
      required this.maxLimit});

  String name;
  String quantity;
  String weight;
  String image;
  dynamic weightList;
  dynamic maxLimit;

  factory AddVehicleModelImage.fromJson(Map<String, dynamic> json) =>
      AddVehicleModelImage(
        name: json["name"],
        quantity: json["quantity"],
        weight: json["weight"],
        image: json['image'],
        weightList: json['weightList'],
        maxLimit: json['maxLimit'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
        "weight": weight,
        "image": image,
        "weightList": weightList,
        "maxLimit": maxLimit,
      };
}
