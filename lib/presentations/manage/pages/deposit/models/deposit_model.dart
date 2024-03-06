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
  final List<Detail>? detail;

  DetailDepositModel({
    this.uuid,
    this.depositId,
    this.amount,
    this.detail,
  });

  factory DetailDepositModel.fromJson(String str) =>
      DetailDepositModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailDepositModel.fromMap(Map<String, dynamic> json) =>
      DetailDepositModel(
        uuid: json["uuid"],
        depositId: json["deposit_id"],
        amount: int.parse(json["amount"]),
        detail: json["detail"] == null
            ? []
            : List<Detail>.from(json["detail"]!.map((x) => Detail.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "uuid": uuid,
        "deposit_id": depositId,
        "amount": amount,
        "detail": detail == null
            ? []
            : List<dynamic>.from(detail!.map((x) => x.toMap())),
      };
}

class Detail {
  final int? produkId;
  final int? detailId;
  final String? code;
  final String? harga;
  final String? qty;
  final String? name;
  final String? salesname;
  final int? typeId;
  final String? total;
  final String? produk;

  Detail({
    this.produkId,
    this.detailId,
    this.code,
    this.harga,
    this.qty,
    this.name,
    this.salesname,
    this.typeId,
    this.total,
    this.produk,
  });

  factory Detail.fromJson(String str) => Detail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Detail.fromMap(Map<String, dynamic> json) => Detail(
        produkId: json["produk_id"],
        detailId: json["detail_id"],
        code: json["code"],
        harga: json["harga"],
        qty: json["qty"],
        name: json["name"],
        salesname: json["salesname"],
        typeId: json["type_id"],
        total: json["total"],
        produk: json["produk"],
      );

  Map<String, dynamic> toMap() => {
        "produk_id": produkId,
        "detail_id": detailId,
        "code": code,
        "harga": harga,
        "qty": qty,
        "name": name,
        "salesname": salesname,
        "type_id": typeId,
        "total": total,
        "produk": produk,
      };
}
