import 'dart:convert';

import 'package:pos_hdn/presentations/order/models/order_model.dart';

class DepositModel {
  final int? id;
  final List<OrderModel>? orders;
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
        qris: json["qris"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "uuid": uuid,
        "amount": amount,
        "qris": qris,
        "created_at": createdAt,
      };
}
