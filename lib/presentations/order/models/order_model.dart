// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:pos_hdn/core/extensions/int_ext.dart';

import '../../home/models/order_item.dart';

// class OrderModel {
//   final String image;
//   final String name;
//   final int price;
//   int quantity;

//   OrderModel({
//     required this.image,
//     required this.name,
//     required this.price,
//     this.quantity = 1,
//   });

//   String get priceFormat => price.currencyFormatRp;
// }

class OrderModel {
  final int? id;
  final String paymentMethod;
  final int nominalBayar;
  final List<OrderItem> orders;
  final int totalQuantity;
  final int totalPrice;
  final int idKasir;
  final String namaKasir;
  // final String transactionTime;
  final bool isSync;
  OrderModel({
    this.id,
    required this.paymentMethod,
    required this.nominalBayar,
    required this.orders,
    required this.totalQuantity,
    required this.totalPrice,
    required this.idKasir,
    required this.namaKasir,
    // required this.transactionTime,
    required this.isSync,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'paymentMethod': paymentMethod,
      'nominalBayar': nominalBayar,
      'orders': orders.map((x) => x.toMap()).toList(),
      'totalQuantity': totalQuantity,
      'totalPrice': totalPrice,
      'idKasir': idKasir,
      'namaKasir': namaKasir,
      // 'transactionTime': transactionTime,
      'isSync': isSync,
    };
  }

  //  mominal INTEGER,
  //       payment_method TEXT
  //       total_item INTEGER,
  //       id_kasir INTEGER,
  //       nama_kasir TEXT,
  //       is_sync INTEGER DEFAULT 0

  Map<String, dynamic> toMapForLocal() {
    return {
      'payment_method': paymentMethod,
      'total_item': totalQuantity,
      'nominal': totalPrice,
      'id_kasir': idKasir,
      'nama_kasir': namaKasir,
      'is_sync': isSync ? 1 : 0,
      // 'transaction_time': transactionTime,
    };
  }

  factory OrderModel.fromLocalMap(Map<String, dynamic> map) {
    return OrderModel(
      paymentMethod: map['payment_method'] ?? '',
      nominalBayar: map['nominal']?.toInt() ?? 0,
      orders: [],
      totalQuantity: map['total_item']?.toInt() ?? 0,
      totalPrice: map['nominal']?.toInt() ?? 0,
      idKasir: map['id_kasir']?.toInt() ?? 0,
      isSync: map['is_sync'] == 1 ? true : false,
      namaKasir: map['nama_kasir'] ?? '',
      id: map['id']?.toInt() ?? 0,
      // transactionTime: map['transaction_time'] ?? '',
    );
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] != null ? map['id'] as int : null,
      paymentMethod: map['paymentMethod'] as String,
      nominalBayar: map['nominalBayar'] as int,
      orders: List<OrderItem>.from(
        (map['orders'] as List<int>).map<OrderItem>(
          (x) => OrderItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      totalQuantity: map['totalQuantity'] as int,
      totalPrice: map['totalPrice'] as int,
      idKasir: map['idKasir'] as int,
      namaKasir: map['namaKasir'] as String,
      // transactionTime: map['transactionTime'] as String,
      isSync: map['isSync'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
