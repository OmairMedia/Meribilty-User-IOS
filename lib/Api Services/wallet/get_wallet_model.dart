// To parse this JSON data, do
//
//     final getWalletModel = getWalletModelFromJson(jsonString);

import 'dart:convert';

GetWalletModel getWalletModelFromJson(String str) => GetWalletModel.fromJson(json.decode(str));

String getWalletModelToJson(GetWalletModel data) => json.encode(data.toJson());

class GetWalletModel {
    GetWalletModel({
        this.status,
        this.type,
        this.data,
    });

    bool? status;
    String? type;
    Data? data;

    factory GetWalletModel.fromJson(Map<String, dynamic> json) => GetWalletModel(
        status: json["status"],
        type: json["type"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "type": type,
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.amount,
        this.transactions,
        this.type,
    });

    int? amount;
    List<Transaction>? transactions;
    String? type;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        amount: json["amount"],
        transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "transactions": List<dynamic>.from(transactions!.map((x) => x.toJson())),
        "type": type,
    };
}

class Transaction {
    Transaction({
        this.acceptedAmount,
        this.afterDeduction,
        this.deductedAmount,
        this.orderNo,
        this.previousBalance,
        this.time,
    });

    dynamic acceptedAmount;
    int? afterDeduction;
    dynamic? deductedAmount;
    String? orderNo;
    int? previousBalance;
    String? time;

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        acceptedAmount: json["acceptedAmount"],
        afterDeduction: json["afterDeduction"],
        deductedAmount: json["deductedAmount"],
        orderNo: json["orderNo"],
        previousBalance: json["previousBalance"],
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "acceptedAmount": acceptedAmount,
        "afterDeduction": afterDeduction,
        "deductedAmount": deductedAmount,
        "orderNo": orderNo,
        "previousBalance": previousBalance,
        "time": time,
    };
}





// // To parsethis JSON data, do
// //
// //     final getWalletModel = getWalletModelFromJson(jsonString);

// import 'dart:convert';

// GetWalletModel getWalletModelFromJson(String str) =>
//     GetWalletModel.fromJson(json.decode(str));

// String getWalletModelToJson(GetWalletModel data) => json.encode(data.toJson());

// class GetWalletModel {
//   GetWalletModel({
//     this.status,
//     this.type,
//     this.data,
//     this.transactions,
//   });

//   bool? status;
//   String? type;
//   Data? data;
//   List<Transaction>? transactions;

//   factory GetWalletModel.fromJson(Map<String, dynamic> json) => GetWalletModel(
//         status: json["status"],
//         type: json["type"],
//         data: Data.fromJson(json["data"]),
//         transactions: List<Transaction>.from(
//             json["transactions"]!.map((x) => Transaction.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "type": type,
//         "data": data!.toJson(),
//         "transactions": List<dynamic>.from(transactions!.map((x) => x!.toJson())),
//       };
// }

// class Data {
//   Data({
//     this.amount,
//     this.transactions,
//     this.type,
//   });

//   int? amount;
//   List<Transaction>? transactions;
//   String? type;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         amount: json["amount"],
//         transactions: List<Transaction>.from(
//             json["transactions"].map((x) => Transaction.fromJson(x))),
//         type: json["type"],
//       );

//   Map<String, dynamic> toJson() => {
//         "amount": amount,
//         "transactions": List<dynamic>.from(transactions!.map((x) => x.toJson())),
//         "type": type,
//       };
// }

// class Transaction {
//   Transaction({
//     this.acceptedAmount,
//     this.afterDeduction,
//     this.deductedAmount,
//     this.orderNo,
//     this.previousBalance,
//     this.time,
//   });

//   var acceptedAmount;
//   var afterDeduction;
//   var deductedAmount;
//   String? orderNo;
//   int? previousBalance;
//   String? time;

//   factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
//         acceptedAmount: json["acceptedAmount"],
//         afterDeduction: json["afterDeduction"],
//         deductedAmount: json["deductedAmount"],
//         orderNo: json["orderNo"],
//         previousBalance: json["previousBalance"],
//         time: json["time"],
//       );

//   Map<String, dynamic> toJson() => {
//         "acceptedAmount": acceptedAmount,
//         "afterDeduction": afterDeduction,
//         "deductedAmount": deductedAmount,
//         "orderNo": orderNo,
//         "previousBalance": previousBalance,
//         "time": time,
//       };
// }
