import 'dart:convert';

import 'package:pos_hdn/presentations/manage/pages/deposit/models/deposit_model.dart';

class DepositResponseModel {
  final bool? success;
  final String? message;
  final List<DepositModel>? data;

  DepositResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory DepositResponseModel.fromJson(String str) =>
      DepositResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DepositResponseModel.fromMap(Map<String, dynamic> json) =>
      DepositResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DepositModel>.from(
                json["data"]!.map((x) => DepositModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  final int? id;
  final String? uuid;
  final int? amount;
  final List<Transaction>? transactions;

  Datum({
    this.id,
    this.uuid,
    this.amount,
    this.transactions,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        uuid: json["uuid"],
        amount: json["amount"],
        transactions: json["transactions"] == null
            ? []
            : List<Transaction>.from(
                json["transactions"]!.map((x) => Transaction.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "uuid": uuid,
        "amount": amount,
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toMap())),
      };
}

class Transaction {
  final String? uuid;
  final int? depositId;

  Transaction({
    this.uuid,
    this.depositId,
  });

  factory Transaction.fromJson(String str) =>
      Transaction.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
        uuid: json["uuid"],
        depositId: json["deposit_id"],
      );

  Map<String, dynamic> toMap() => {
        "uuid": uuid,
        "deposit_id": depositId,
      };
}
