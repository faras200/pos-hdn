import 'dart:convert';

import 'package:pos_hdn/presentations/order/models/order_model.dart';

class DepositRequestModel {
  final String qrisId;
  final int amount;
  final List<OrderModel> orders;
  final String uuid;

  DepositRequestModel({
    required this.qrisId,
    required this.amount,
    required this.orders,
    required this.uuid,
  });

  factory DepositRequestModel.fromJson(String str) =>
      DepositRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DepositRequestModel.fromMap(Map<String, dynamic> json) =>
      DepositRequestModel(
        uuid: json['uuid'],
        qrisId: json["kasir_id"],
        amount: json["total_price"],
        orders: List<OrderModel>.from(
            json["order_items"].map((x) => OrderItemModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "uuid": uuid,
        "qris_id": qrisId,
        "amount": amount,
        "orders": List<dynamic>.from(orders.map((x) => x.toMap())),
      };
}

class OrderItemModel {
  final String uuid;

  OrderItemModel({
    required this.uuid,
  });

  factory OrderItemModel.fromJson(String str) =>
      OrderItemModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderItemModel.fromMap(Map<String, dynamic> json) => OrderItemModel(
        uuid: json["uuid"],
      );

  Map<String, dynamic> toMap() => {
        "uuid": uuid,
      };
}
