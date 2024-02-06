import 'dart:convert';

import 'package:pos_hdn/presentations/manage/pages/deposit/models/deposit_model.dart';

class DepositResponseModel {
  final bool? success;
  final String? message;
  final List<DepositModel>? data;

  DepositResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory DepositResponseModel.fromJson(String str) =>
      DepositResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DepositResponseModel.fromMap(Map<String, dynamic> json) =>
      DepositResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DepositModel>.from(
                json["data"]!.map((x) => DepositModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}
