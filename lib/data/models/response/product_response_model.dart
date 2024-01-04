// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

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
  final int? id;
  final int typeId;
  final bool isBestSeller;
  final String name;
  final String image;
  final String harga;
  final String? type;

  Product({
    this.id,
    required this.typeId,
    required this.isBestSeller,
    required this.name,
    required this.image,
    required this.harga,
    this.type,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        typeId: json["type_id"],
        isBestSeller: json["is_best_seller"] == 1 ? true : false,
        name: json["short_name"] ?? json["name"],
        image: json["image"] ?? "",
        harga: json["harga"] ?? "",
        type: json["type"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "image": image,
        "price": harga,
        "category": type,
        "is_best_seller": isBestSeller ? 1 : 0,
      };

  Product copyWith({
    int? id,
    int? typeId,
    bool? isBestSeller,
    String? name,
    String? image,
    String? harga,
    String? type,
  }) {
    return Product(
      id: id ?? this.id,
      typeId: typeId ?? this.typeId,
      isBestSeller: isBestSeller ?? this.isBestSeller,
      name: name ?? this.name,
      image: image ?? this.image,
      harga: harga ?? this.harga,
      type: type ?? this.type,
    );
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.typeId == typeId &&
        other.isBestSeller == isBestSeller &&
        other.name == name &&
        other.image == image &&
        other.harga == harga &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        typeId.hashCode ^
        isBestSeller.hashCode ^
        name.hashCode ^
        image.hashCode ^
        harga.hashCode ^
        type.hashCode;
  }
}
