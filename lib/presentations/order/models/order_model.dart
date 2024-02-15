// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../home/models/order_item.dart';

class OrderModel {
  final int? id;
  final String? paymentMethod;
  final int? nominalBayar;
  final List<OrderItem> orders;
  final int? totalQuantity;
  final int? totalPrice;
  final int? idKasir;
  final String? namaKasir;
  final String? transactionTime;
  final bool isSync;
  final String? uuid;
  final String? qris;
  OrderModel({
    this.id,
    required this.paymentMethod,
    required this.nominalBayar,
    required this.orders,
    required this.totalQuantity,
    required this.totalPrice,
    required this.idKasir,
    required this.namaKasir,
    required this.transactionTime,
    required this.isSync,
    required this.uuid,
    required this.qris,
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
      'transactionTime': transactionTime,
      'isSync': isSync,
      'uuid': uuid,
      'qris': qris,
    };
  }

  Map<String, dynamic> toMapForLocal() {
    return {
      'payment_method': paymentMethod,
      'uuid': uuid,
      'qris': qris,
      'total_item': totalQuantity,
      'nominal': totalPrice,
      'bayar': nominalBayar,
      'id_kasir': idKasir,
      'nama_kasir': namaKasir,
      'is_sync': isSync ? 1 : 0,
      'transaction_time': transactionTime,
    };
  }

  factory OrderModel.fromLocalMap(Map<String, dynamic> map) {
    return OrderModel(
      paymentMethod: map['payment_method'] ?? '',
      nominalBayar: map['bayar']?.toInt() ?? 0,
      orders: [],
      totalQuantity: map['total_item']?.toInt() ?? 0,
      totalPrice: map['nominal']?.toInt() ?? 0,
      idKasir: map['id_kasir']?.toInt() ?? 0,
      isSync: map['is_sync'] == 1 ? true : false,
      namaKasir: map['nama_kasir'] ?? '',
      id: map['id']?.toInt() ?? 0,
      transactionTime: map['transaction_time'] ?? '',
      qris: map['qris'] ?? '',
      uuid: map['uuid'] ?? '',
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
      transactionTime: map['transactionTime'] as String,
      isSync: map['isSync'] as bool,
      uuid: map['uuid'] as String,
      qris: map['qris'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory OrderModel.fromMapRemote(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"],
      paymentMethod: json["payment_method"],
      nominalBayar: json['nominalBayar'] ?? 0,
      orders: [],
      totalQuantity: json['totalQuantity'] ?? 0,
      totalPrice: json['amount'] ?? 0,
      idKasir: json['idKasir'] ?? 0,
      namaKasir: json['namaKasir'] ?? '',
      transactionTime: json['transactionTime'] ?? '',
      isSync: json['isSync'] == 1 ? true : false,
      uuid: json['uuid'] ?? '',
      qris: json['qris'] ?? '',
    );
  }
}
