// To parse this JSON data, do
//
//     final getUserProfileModel = getUserProfileModelFromJson(jsonString);

import 'dart:convert';

GetUserProfileModel getUserProfileModelFromJson(String str) =>
    GetUserProfileModel.fromJson(json.decode(str));

String getUserProfileModelToJson(GetUserProfileModel data) =>
    json.encode(data.toJson());

class GetUserProfileModel {
  GetUserProfileModel({
    required this.status,
    required this.data,
  });

  bool status;
  Data data;

  factory GetUserProfileModel.fromJson(Map<String, dynamic> json) =>
      GetUserProfileModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.applicationStatus,
    required this.created,
    required this.email,
    required this.form,
    required this.fullname,
    required this.id,
    this.password,
    required this.phone,
    required this.type,
    required this.userType,
    required this.verified,
  });

  bool applicationStatus;
  String created;
  String email;
  String form;
  String fullname;
  String id;
  dynamic password;
  String phone;
  String type;
  String userType;
  bool verified;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        applicationStatus: json["application_status"],
        created: json["created"],
        email: json["email"],
        form: json["form"],
        fullname: json["fullname"],
        id: json["id"],
        password: json["password"],
        phone: json["phone"],
        type: json["type"],
        userType: json["user_type"],
        verified: json["verified"],
      );

  Map<String, dynamic> toJson() => {
        "application_status": applicationStatus,
        "created": created,
        "email": email,
        "form": form,
        "fullname": fullname,
        "id": id,
        "password": password,
        "phone": phone,
        "type": type,
        "user_type": userType,
        "verified": verified,
      };
}
