import 'dart:convert';

class GetNoteDetailByIdModel {
  final String? title;
  final String? description;
  final List<Attachment>? attachments;
  final CreatedBy? createdBy;
  final ProjectId? projectId;
  final String? isAccepted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? noteId;

  GetNoteDetailByIdModel({
    this.title,
    this.description,
    this.attachments,
    this.createdBy,
    this.projectId,
    this.isAccepted,
    this.createdAt,
    this.updatedAt,
    this.noteId,
  });

  factory GetNoteDetailByIdModel.fromRawJson(String str) => GetNoteDetailByIdModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetNoteDetailByIdModel.fromJson(Map<String, dynamic> json) => GetNoteDetailByIdModel(
    title: json["title"],
    description: json["description"],
    attachments: json["attachments"] == null ? [] : List<Attachment>.from(json["attachments"]!.map((x) => Attachment.fromJson(x))),
    createdBy: json["createdBy"] == null ? null : CreatedBy.fromJson(json["createdBy"]),
    projectId: json["projectId"] == null ? null : ProjectId.fromJson(json["projectId"]),
    isAccepted: json["isAccepted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    noteId: json["_noteId"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x.toJson())),
    "createdBy": createdBy?.toJson(),
    "projectId": projectId?.toJson(),
    "isAccepted": isAccepted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "_noteId": noteId,
  };
}

class Attachment {
  final String? attachment;
  final String? attachmentType;
  final String? projectId;
  final DateTime? createdAt;
  final String? attachmentId;

  Attachment({
    this.attachment,
    this.attachmentType,
    this.projectId,
    this.createdAt,
    this.attachmentId,
  });

  factory Attachment.fromRawJson(String str) => Attachment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    attachment: json["attachment"],
    attachmentType: json["attachmentType"],
    projectId: json["projectId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    attachmentId: json["_attachmentId"],
  );

  Map<String, dynamic> toJson() => {
    "attachment": attachment,
    "attachmentType": attachmentType,
    "projectId": projectId,
    "createdAt": createdAt?.toIso8601String(),
    "_attachmentId": attachmentId,
  };
}

class CreatedBy {
  final String? fcmToken;
  final String? role;
  final String? superVisorsManagerId;
  final String? phoneNumber;
  final String? userId;

  CreatedBy({
    this.fcmToken,
    this.role,
    this.superVisorsManagerId,
    this.phoneNumber,
    this.userId,
  });

  factory CreatedBy.fromRawJson(String str) => CreatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    fcmToken: json["fcmToken"],
    role: json["role"],
    superVisorsManagerId: json["superVisorsManagerId"],
    phoneNumber: json["phoneNumber"],
    userId: json["_userId"],
  );

  Map<String, dynamic> toJson() => {
    "fcmToken": fcmToken,
    "role": role,
    "superVisorsManagerId": superVisorsManagerId,
    "phoneNumber": phoneNumber,
    "_userId": userId,
  };
}

class ProjectId {
  final String? projectName;
  final String? streetAddress;
  final String? city;
  final String? zipCode;
  final String? country;
  final String? projectId;

  ProjectId({
    this.projectName,
    this.streetAddress,
    this.city,
    this.zipCode,
    this.country,
    this.projectId,
  });

  factory ProjectId.fromRawJson(String str) => ProjectId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProjectId.fromJson(Map<String, dynamic> json) => ProjectId(
    projectName: json["projectName"],
    streetAddress: json["streetAddress"],
    city: json["city"],
    zipCode: json["zipCode"],
    country: json["country"],
    projectId: json["_projectId"],
  );

  Map<String, dynamic> toJson() => {
    "projectName": projectName,
    "streetAddress": streetAddress,
    "city": city,
    "zipCode": zipCode,
    "country": country,
    "_projectId": projectId,
  };
}
