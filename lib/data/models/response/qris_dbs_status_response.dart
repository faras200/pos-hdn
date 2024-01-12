import 'dart:convert';

class QrisDbsStatusResponseModel {
  final bool? success;
  final String? message;
  final Data? data;

  QrisDbsStatusResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory QrisDbsStatusResponseModel.fromJson(String str) =>
      QrisDbsStatusResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory QrisDbsStatusResponseModel.fromMap(Map<String, dynamic> json) =>
      QrisDbsStatusResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data?.toMap(),
      };
}

class Data {
  final String? outletProxy;
  final List<TxnList>? txnList;

  Data({
    this.outletProxy,
    this.txnList,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        outletProxy: json["outletProxy"],
        txnList: json["txnList"] == null
            ? []
            : List<TxnList>.from(
                json["txnList"]!.map((x) => TxnList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "outletProxy": outletProxy,
        "txnList": txnList == null
            ? []
            : List<dynamic>.from(txnList!.map((x) => x.toMap())),
      };
}

class TxnList {
  final String? txnRefId;
  final String? billReference;
  final String? txnAmount;
  final String? txnCcy;
  final String? paymentBrand;
  final int? statusCode;
  final String? statusDesc;
  final String? txnType;
  final String? tipsAmount;

  TxnList({
    this.txnRefId,
    this.billReference,
    this.txnAmount,
    this.txnCcy,
    this.paymentBrand,
    this.statusCode,
    this.statusDesc,
    this.txnType,
    this.tipsAmount,
  });

  factory TxnList.fromJson(String str) => TxnList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TxnList.fromMap(Map<String, dynamic> json) => TxnList(
        txnRefId: json["txnRefId"],
        billReference: json["billReference"],
        txnAmount: json["txnAmount"],
        txnCcy: json["txnCcy"],
        paymentBrand: json["paymentBrand"],
        statusCode: json["statusCode"],
        statusDesc: json["statusDesc"],
        txnType: json["txnType"],
        tipsAmount: json["tipsAmount"],
      );

  Map<String, dynamic> toMap() => {
        "txnRefId": txnRefId,
        "billReference": billReference,
        "txnAmount": txnAmount,
        "txnCcy": txnCcy,
        "paymentBrand": paymentBrand,
        "statusCode": statusCode,
        "statusDesc": statusDesc,
        "txnType": txnType,
        "tipsAmount": tipsAmount,
      };
}
