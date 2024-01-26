import 'dart:convert';

class AuthResponseModel {
  final bool success;
  final String message;
  final Data data;

  AuthResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AuthResponseModel.fromJson(String str) =>
      AuthResponseModel.fromMap(json.decode(str));

  get token => null;

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) =>
      AuthResponseModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data.toMap(),
      };
}

class Data {
  final String token;
  final User user;

  Data({
    required this.token,
    required this.user,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "token": token,
        "user": user.toMap(),
      };
}

class User {
  final int id;
  final int roleId;
  final dynamic companyId;
  final dynamic retailerId;
  final dynamic googleId;
  final int wilayahId;
  final String va;
  final dynamic ovo;
  final String ktp;
  final dynamic fotoktp;
  final String name;
  final dynamic jenkel;
  final dynamic tanggalLahir;
  final String noHp;
  final dynamic alamat;
  final dynamic clubsmart;
  final String email;
  final String token;
  final String accessToken;
  final String fcmToken;
  final int guide;
  final dynamic pemegangsaham;
  final dynamic ket;
  final dynamic photo;
  final String lat;
  final String lon;

  User({
    required this.id,
    required this.roleId,
    required this.companyId,
    required this.retailerId,
    required this.googleId,
    required this.wilayahId,
    required this.va,
    required this.ovo,
    required this.ktp,
    required this.fotoktp,
    required this.name,
    required this.jenkel,
    required this.tanggalLahir,
    required this.noHp,
    required this.alamat,
    required this.clubsmart,
    required this.email,
    required this.token,
    required this.accessToken,
    required this.fcmToken,
    required this.guide,
    required this.pemegangsaham,
    required this.ket,
    required this.photo,
    required this.lat,
    required this.lon,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        roleId: json["role_id"],
        companyId: json["company_id"],
        retailerId: json["retailer_id"],
        googleId: json["google_id"],
        wilayahId: json["wilayah_id"],
        va: json["va"],
        ovo: json["ovo"],
        ktp: json["ktp"],
        fotoktp: json["fotoktp"],
        name: json["name"],
        jenkel: json["jenkel"],
        tanggalLahir: json["tanggal_lahir"],
        noHp: json["no_hp"],
        alamat: json["alamat"],
        clubsmart: json["clubsmart"],
        email: json["email"],
        token: json["token"],
        accessToken: json["access_token"],
        fcmToken: json["fcm_token"],
        guide: json["guide"],
        pemegangsaham: json["pemegangsaham"],
        ket: json["ket"],
        photo: json["photo"],
        lat: json["lat"],
        lon: json["lon"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "role_id": roleId,
        "company_id": companyId,
        "retailer_id": retailerId,
        "google_id": googleId,
        "wilayah_id": wilayahId,
        "va": va,
        "ovo": ovo,
        "ktp": ktp,
        "fotoktp": fotoktp,
        "name": name,
        "jenkel": jenkel,
        "tanggal_lahir": tanggalLahir,
        "no_hp": noHp,
        "alamat": alamat,
        "clubsmart": clubsmart,
        "email": email,
        "token": token,
        "access_token": accessToken,
        "fcm_token": fcmToken,
        "guide": guide,
        "pemegangsaham": pemegangsaham,
        "ket": ket,
        "photo": photo,
        "lat": lat,
        "lon": lon,
      };
}
