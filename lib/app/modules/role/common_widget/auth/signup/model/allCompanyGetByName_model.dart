import 'dart:convert';

class GetAllCompanyModel {
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? companyId;

  GetAllCompanyModel({
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.companyId,
  });

  factory GetAllCompanyModel.fromRawJson(String str) => GetAllCompanyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllCompanyModel.fromJson(Map<String, dynamic> json) => GetAllCompanyModel(
    name: json["name"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    companyId: json["_companyId"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "_companyId": companyId,
  };
}
