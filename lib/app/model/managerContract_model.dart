import 'dart:convert';

class GetAllManagerContractModel {
  final String? date;
  final List<GetAllManagerContractModelAttachment>? attachments;

  GetAllManagerContractModel({
    this.date,
    this.attachments,
  });

  factory GetAllManagerContractModel.fromRawJson(String str) => GetAllManagerContractModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllManagerContractModel.fromJson(Map<String, dynamic> json) => GetAllManagerContractModel(
    date: json["date"],
    attachments: json["attachments"] == null ? [] : List<GetAllManagerContractModelAttachment>.from(json["attachments"]!.map((x) => GetAllManagerContractModelAttachment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x.toJson())),
  };
}

class GetAllManagerContractModelAttachment {
  final List<AttachmentAttachment>? attachments;
  final String? projectId;
  final String? createdBy;
  final String? creatorRole;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? contractId;

  GetAllManagerContractModelAttachment({
    this.attachments,
    this.projectId,
    this.createdBy,
    this.creatorRole,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.contractId,
  });

  factory GetAllManagerContractModelAttachment.fromRawJson(String str) => GetAllManagerContractModelAttachment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllManagerContractModelAttachment.fromJson(Map<String, dynamic> json) => GetAllManagerContractModelAttachment(
    attachments: json["attachments"] == null ? [] : List<AttachmentAttachment>.from(json["attachments"]!.map((x) => AttachmentAttachment.fromJson(x))),
    projectId: json["projectId"],
    createdBy: json["createdBy"],
    creatorRole: json["creatorRole"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    contractId: json["_contractId"],
  );

  Map<String, dynamic> toJson() => {
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x.toJson())),
    "projectId": projectId,
    "createdBy": createdBy,
    "creatorRole": creatorRole,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "_contractId": contractId,
  };
}

class AttachmentAttachment {
  final String? attachment;
  final String? attachmentId;

  AttachmentAttachment({
    this.attachment,
    this.attachmentId,
  });

  factory AttachmentAttachment.fromRawJson(String str) => AttachmentAttachment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttachmentAttachment.fromJson(Map<String, dynamic> json) => AttachmentAttachment(
    attachment: json["attachment"],
    attachmentId: json["_attachmentId"],
  );

  Map<String, dynamic> toJson() => {
    "attachment": attachment,
    "_attachmentId": attachmentId,
  };
}
