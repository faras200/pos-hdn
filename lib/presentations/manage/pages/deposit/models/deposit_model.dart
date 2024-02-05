import 'dart:convert';

import 'package:pos_hdn/presentations/order/models/order_model.dart';

class DepositModel {
  final int? id;
  final List<Transaction>? orders;
  final String? uuid;
  final int? amount;
  final String? qris;
  final String? createdAt;

  DepositModel({
    this.id,
    this.orders,
    this.uuid,
    this.amount,
    this.qris,
    this.createdAt,
  });

  factory DepositModel.fromJson(String str) =>
      DepositModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DepositModel.fromMap(Map<String, dynamic> json) => DepositModel(
        id: json["id"],
        uuid: json["uuid"],
        amount: json["amount"],
        orders: json["transactions"] == null
            ? []
            : List<Transaction>.from(
                json["transactions"]!.map((x) => Transaction.fromMap(x))),
        qris: json["qris"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "uuid": uuid,
        "amount": amount,
        "qris": qris,
        "created_at": createdAt,
        "orders": orders == null
            ? []
            : List<dynamic>.from(orders!.map((x) => x.toMap()))
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
