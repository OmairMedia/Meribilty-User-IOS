// To parse this JSON data, do
//
//     final myTeamModel = myTeamModelFromJson(jsonString);

import 'dart:convert';

MyTeamModel myTeamModelFromJson(String str) => MyTeamModel.fromJson(json.decode(str));

String myTeamModelToJson(MyTeamModel data) => json.encode(data.toJson());

class MyTeamModel {
    MyTeamModel({
        this.status,
        this.data,
    });

    bool? status;
    List<Datum>? data;

    factory MyTeamModel.fromJson(Map<String, dynamic> json) => MyTeamModel(
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
        this.created,
        this.email,
        this.fullname,
        this.id,
        this.phone,
        this.referer,
        this.type,
        this.verified,
    });

    String? created;
    String? email;
    String? fullname;
    String? id;
    String? phone;
    String? referer;
    String? type;
    bool? verified;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        created: json["created"],
        email: json["email"],
        fullname: json["fullname"],
        id: json["id"],
        phone: json["phone"],
        referer: json["referer"],
        type: json["type"],
        verified: json["verified"],
    );

    Map<String, dynamic> toJson() => {
        "created": created,
        "email": email,
        "fullname": fullname,
        "id": id,
        "phone": phone,
        "referer": referer,
        "type": type,
        "verified": verified,
    };
}
