import 'dart:convert';

class DepositModel {
  final int? id;
  final List<DetailDepositModel>? orders;
  final String? uuid;
  final int? amount;
  final String? qris;
  final String? time;
  final String? createdAt;

  DepositModel({
    this.id,
    this.orders,
    this.uuid,
    this.amount,
    this.qris,
    this.time,
    this.createdAt,
  });

  factory DepositModel.fromJson(String str) =>
      DepositModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DepositModel.fromMap(Map<String, dynamic> json) => DepositModel(
        id: json["id"],
        uuid: json["uuid"],
        amount: json["amount"],
        time: json["time"],
        orders: json["transactions"] == null
            ? []
            : List<DetailDepositModel>.from(json["transactions"]!
                .map((x) => DetailDepositModel.fromMap(x))),
        qris: json["qris"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "uuid": uuid,
        "amount": amount,
        "qris": qris,
        "time": time,
        "created_at": createdAt,
        "orders": orders == null
            ? []
            : List<dynamic>.from(orders!.map((x) => x.toMap()))
      };
}

class DetailDepositModel {
  final String? uuid;
  final int? depositId;
  final int? amount;

  DetailDepositModel({
    this.uuid,
    this.depositId,
    this.amount,
  });

  factory DetailDepositModel.fromJson(String str) =>
      DetailDepositModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailDepositModel.fromMap(Map<String, dynamic> json) =>
      DetailDepositModel(
        uuid: json["uuid"],
        depositId: json["deposit_id"],
        amount: int.parse(json["amount"]),
      );

  Map<String, dynamic> toMap() => {
        "uuid": uuid,
        "deposit_id": depositId,
        "amount": amount,
      };
}
