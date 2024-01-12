import 'dart:convert';

class QrisDbsResponseModel {
  final int? id;
  final dynamic kunjunganId;
  final String? uuid;
  final dynamic soId;
  final dynamic so;
  final dynamic doId;
  final dynamic qrisDbsResponseModelDo;
  final dynamic doDate;
  final dynamic siId;
  final dynamic si;
  final dynamic siDate;
  final dynamic receiptId;
  final dynamic receipt;
  final dynamic receiptDate;
  final dynamic salesId;
  final dynamic tokoId;
  final dynamic accurateid;
  final String? status;
  final String? type;
  final String? amount;
  final dynamic ppn;
  final dynamic adminFee;
  final dynamic berat;
  final String? qris;
  final dynamic nopo;
  final dynamic filenopo;
  final dynamic fakturpajak;
  final dynamic ket;
  final dynamic rute;
  final DateTime? expiredAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  QrisDbsResponseModel({
    this.id,
    this.kunjunganId,
    this.uuid,
    this.soId,
    this.so,
    this.doId,
    this.qrisDbsResponseModelDo,
    this.doDate,
    this.siId,
    this.si,
    this.siDate,
    this.receiptId,
    this.receipt,
    this.receiptDate,
    this.salesId,
    this.tokoId,
    this.accurateid,
    this.status,
    this.type,
    this.amount,
    this.ppn,
    this.adminFee,
    this.berat,
    this.qris,
    this.nopo,
    this.filenopo,
    this.fakturpajak,
    this.ket,
    this.rute,
    this.expiredAt,
    this.createdAt,
    this.updatedAt,
  });

  factory QrisDbsResponseModel.fromJson(String str) =>
      QrisDbsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory QrisDbsResponseModel.fromMap(Map<String, dynamic> json) =>
      QrisDbsResponseModel(
        id: json["id"],
        kunjunganId: json["kunjungan_id"],
        uuid: json["uuid"],
        soId: json["so_id"],
        so: json["so"],
        doId: json["do_id"],
        qrisDbsResponseModelDo: json["do"],
        doDate: json["do_date"],
        siId: json["si_id"],
        si: json["si"],
        siDate: json["si_date"],
        receiptId: json["receipt_id"],
        receipt: json["receipt"],
        receiptDate: json["receipt_date"],
        salesId: json["sales_id"],
        tokoId: json["toko_id"],
        accurateid: json["accurateid"],
        status: json["status"],
        type: json["type"],
        amount: json["amount"],
        ppn: json["ppn"],
        adminFee: json["admin_fee"],
        berat: json["berat"],
        qris: json["qris"],
        nopo: json["nopo"],
        filenopo: json["filenopo"],
        fakturpajak: json["fakturpajak"],
        ket: json["ket"],
        rute: json["rute"],
        expiredAt: json["expired_at"] == null
            ? null
            : DateTime.parse(json["expired_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "kunjungan_id": kunjunganId,
        "uuid": uuid,
        "so_id": soId,
        "so": so,
        "do_id": doId,
        "do": qrisDbsResponseModelDo,
        "do_date": doDate,
        "si_id": siId,
        "si": si,
        "si_date": siDate,
        "receipt_id": receiptId,
        "receipt": receipt,
        "receipt_date": receiptDate,
        "sales_id": salesId,
        "toko_id": tokoId,
        "accurateid": accurateid,
        "status": status,
        "type": type,
        "amount": amount,
        "ppn": ppn,
        "admin_fee": adminFee,
        "berat": berat,
        "qris": qris,
        "nopo": nopo,
        "filenopo": filenopo,
        "fakturpajak": fakturpajak,
        "ket": ket,
        "rute": rute,
        "expired_at": expiredAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
