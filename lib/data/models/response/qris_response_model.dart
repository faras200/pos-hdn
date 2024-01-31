import 'dart:convert';

class QrisResponseModel {
  final int? id;
  final String? uuid;
  final String? type;
  final int? amount;
  final String? qris;
  final String? status;
  final DateTime? expiredAt;
  final DateTime? createdAt;

  QrisResponseModel({
    this.id,
    this.uuid,
    this.type,
    this.amount,
    this.qris,
    this.status,
    this.expiredAt,
    this.createdAt,
  });

  factory QrisResponseModel.fromJson(String str) =>
      QrisResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory QrisResponseModel.fromMap(Map<String, dynamic> json) =>
      QrisResponseModel(
        id: json["id"],
        uuid: json["uuid"],
        type: json["type"],
        amount: json["amount"],
        qris: json["qris"],
        status: json["status"],
        expiredAt: json["expired_at"] == null
            ? null
            : DateTime.parse(json["expired_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "uuid": uuid,
        "type": type,
        "amount": amount,
        "qris": qris,
        "status": status,
        "expired_at": expiredAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
      };
}
