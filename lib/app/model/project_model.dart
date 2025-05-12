import 'dart:convert';

class ProjectDetailsModel {
  final String? projectName;
  final String? projectLogo;
  final String? projectSuperVisorId;
  final String? projectManagerId;
  final String? streetAddress;
  final String? city;
  final String? zipCode;
  final String? country;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<dynamic>? attachments;
  final String? projectStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? projectId;

  ProjectDetailsModel({
    this.projectName,
    this.projectLogo,
    this.projectSuperVisorId,
    this.projectManagerId,
    this.streetAddress,
    this.city,
    this.zipCode,
    this.country,
    this.startDate,
    this.endDate,
    this.attachments,
    this.projectStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.projectId,
  });

  factory ProjectDetailsModel.fromRawJson(String str) => ProjectDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProjectDetailsModel.fromJson(Map<String, dynamic> json) => ProjectDetailsModel(
    projectName: json["projectName"],
    projectLogo: json["projectLogo"],
    projectSuperVisorId: json["projectSuperVisorId"],
    projectManagerId: json["projectManagerId"],
    streetAddress: json["streetAddress"],
    city: json["city"],
    zipCode: json["zipCode"],
    country: json["country"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    attachments: json["attachments"] == null ? [] : List<dynamic>.from(json["attachments"]!.map((x) => x)),
    projectStatus: json["projectStatus"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    projectId: json["_projectId"],
  );

  Map<String, dynamic> toJson() => {
    "projectName": projectName,
    "projectLogo": projectLogo,
    "projectSuperVisorId": projectSuperVisorId,
    "projectManagerId": projectManagerId,
    "streetAddress": streetAddress,
    "city": city,
    "zipCode": zipCode,
    "country": country,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x)),
    "projectStatus": projectStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "_projectId": projectId,
  };
}
