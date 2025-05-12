import 'dart:convert';

class GetAllImageAndDocumentModel {
  final String? date;
  final List<Attachment>? attachments;

  GetAllImageAndDocumentModel({
    this.date,
    this.attachments,
  });

  factory GetAllImageAndDocumentModel.fromRawJson(String str) => GetAllImageAndDocumentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllImageAndDocumentModel.fromJson(Map<String, dynamic> json) => GetAllImageAndDocumentModel(
    date: json["date"],
    attachments: json["attachments"] == null ? [] : List<Attachment>.from(json["attachments"]!.map((x) => Attachment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x.toJson())),
  };
}

class Attachment {
  final String? attachment;
  final String? attachedToType;
  final String? uploadedByUserId;
  final String? uploaderRole;
  final List<dynamic>? reactions;
  final DateTime? createdAt;
  final String? attachmentId;

  Attachment({
    this.attachment,
    this.attachedToType,
    this.uploadedByUserId,
    this.uploaderRole,
    this.reactions,
    this.createdAt,
    this.attachmentId,
  });

  factory Attachment.fromRawJson(String str) => Attachment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    attachment: json["attachment"],
    attachedToType: json["attachedToType"],
    uploadedByUserId: json["uploadedByUserId"],
    uploaderRole: json["uploaderRole"],
    reactions: json["reactions"] == null ? [] : List<dynamic>.from(json["reactions"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    attachmentId: json["_attachmentId"],
  );

  Map<String, dynamic> toJson() => {
    "attachment": attachment,
    "attachedToType": attachedToType,
    "uploadedByUserId": uploadedByUserId,
    "uploaderRole": uploaderRole,
    "reactions": reactions == null ? [] : List<dynamic>.from(reactions!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "_attachmentId": attachmentId,
  };
}
