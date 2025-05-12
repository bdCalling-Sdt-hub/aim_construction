import 'dart:convert';

class GetAllManagerModel {
  final UserId? userId;
  final String? companyId;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? userCompanyId;

  GetAllManagerModel({
    this.userId,
    this.companyId,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.userCompanyId,
  });

  factory GetAllManagerModel.fromRawJson(String str) => GetAllManagerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllManagerModel.fromJson(Map<String, dynamic> json) => GetAllManagerModel(
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    companyId: json["companyId"],
    role: json["role"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    userCompanyId: json["_userCompanyId"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId?.toJson(),
    "companyId": companyId,
    "role": role,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "_userCompanyId": userCompanyId,
  };
}

class UserId {
  final String? fname;
  final String? lname;
  final String? userId;

  UserId({
    this.fname,
    this.lname,
    this.userId,
  });

  factory UserId.fromRawJson(String str) => UserId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    fname: json["fname"],
    lname: json["lname"],
    userId: json["_userId"],
  );

  Map<String, dynamic> toJson() => {
    "fname": fname,
    "lname": lname,
    "_userId": userId,
  };
}
