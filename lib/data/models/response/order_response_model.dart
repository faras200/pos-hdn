import 'dart:convert';

import 'package:pos_hdn/presentations/order/models/order_model.dart';

class OrderResponseModel {
  final bool? success;
  final String? message;
  final List<OrderModel>? data;

  OrderResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory OrderResponseModel.fromJson(String str) =>
      OrderResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderResponseModel.fromMap(Map<String, dynamic> json) =>
      OrderResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<OrderModel>.from(
                json["data"]!.map((x) => OrderModel.fromMapRemote(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}
