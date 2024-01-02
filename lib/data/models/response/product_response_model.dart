import 'package:meta/meta.dart';
import 'dart:convert';

class ProductResponseModel {
  final bool success;
  final String message;
  final List<Product> data;

  ProductResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProductResponseModel.fromJson(String str) =>
      ProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponseModel.fromMap(Map<String, dynamic> json) =>
      ProductResponseModel(
        success: json["success"],
        message: json["message"],
        data: List<Product>.from(json["data"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Product {
  final int id;
  final int satuanId;
  final int accurateid;
  final int typeId;
  final int tokopediaId;
  final int shopeeId;
  final String blibliId;
  final String name;
  final String shortName;
  final String code;
  final String image;
  final String harga;
  final String tokopediaHarga;
  final dynamic shopeeHarga;
  final String minimarket;
  final String berat;
  final String active;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String satuan;

  Product({
    required this.id,
    required this.satuanId,
    required this.accurateid,
    required this.typeId,
    required this.tokopediaId,
    required this.shopeeId,
    required this.blibliId,
    required this.name,
    required this.shortName,
    required this.code,
    required this.image,
    required this.harga,
    required this.tokopediaHarga,
    required this.shopeeHarga,
    required this.minimarket,
    required this.berat,
    required this.active,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.satuan,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        satuanId: json["satuan_id"] ?? 0,
        accurateid: json["accurateid"] ?? 0,
        typeId: json["type_id"] ?? 0,
        tokopediaId: json["tokopedia_id"] ?? 0,
        shopeeId: json["shopee_id"] ?? 0,
        blibliId: json["blibli_id"] ?? "",
        name: json["name"] ?? "",
        shortName: json["short_name"] ?? "",
        code: json["code"] ?? "",
        image: json["image"] ?? "",
        harga: json["harga"] ?? "",
        tokopediaHarga: json["tokopedia_harga"] ?? "",
        shopeeHarga: json["shopee_harga"] ?? "",
        minimarket: json["minimarket"] ?? "",
        berat: json["berat"] ?? "",
        active: json["active"] ?? "",
        type: json["type"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        satuan: json["satuan"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "name": shortName,
        "image": image,
        "price": harga,
        "category": type,
      };
}
